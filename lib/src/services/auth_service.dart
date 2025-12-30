import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'dart:io';
import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'package:googleapis/gmail/v1.dart';
import '../config/google_oauth_config.dart';

class AuthService extends ChangeNotifier {
  // Map of email -> Authenticated Client
  final Map<String, http.Client> _clients = {};
  
  // Track connected emails
  final Set<String> _connectedEmails = {};

  final bool _isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  final _storage = const FlutterSecureStorage();
  final _logger = Logger('AuthService');

  late final GoogleSignIn _googleSignIn;

  AuthService() {
    _googleSignIn = GoogleSignIn(
      clientId: _isMobile ? GoogleOAuthConfig.mobileClientId : null,
      scopes: GoogleOAuthConfig.gmailReadOnlyScopes,
    );
    _initialize();
  }

  // --- Dynamic Platform Configuration ---

  String get _currentClientId {
    if (_isMobile) {
      return GoogleOAuthConfig.mobileClientId;
    }
    return GoogleOAuthConfig.desktopClientId;
  }

  String? get _currentClientSecret {
    if (_isMobile) {
      return null;
    }
    return GoogleOAuthConfig.desktopClientSecret;
  }

  ClientId get _oauthClientId => ClientId(_currentClientId, _currentClientSecret);

  // --- Getters ---

  Set<String> get connectedEmails => _connectedEmails;
  bool get isAuthenticated => _connectedEmails.isNotEmpty;

  // --- Initialization ---

  Future<void> _initialize() async {
    await _verifyStorage();
    await _restoreAccounts();
  }

  Future<void> _verifyStorage() async {
    try {
      const key = 'test_storage_perm';
      await _storage.write(key: key, value: 'ok');
      final val = await _storage.read(key: key);
      if (val == 'ok') {
        _logger.info('Secure storage verification passed.');
        await _storage.delete(key: key);
      } else {
        _logger.severe('Secure storage verification failed: Value mismatch.');
      }
    } catch (e) {
      _logger.severe('Secure storage verification failed.', e);
    }
  }

  // --- Sign In ---

  Future<String?> signInWithGoogle() async {
    if (_isMobile) {
      return await _signInMobile();
    } else {
      return await _signInDesktop();
    }
  }

  Future<String?> _signInMobile() async {
    try {
      // For mobile, we might want to force choosing an account if adding multiple
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        _logger.info('Sign in returned null (user cancelled or failed)');
        return null;
      } else {
        _logger.info('Signed in as ${account.email}');

        _connectedEmails.add(account.email);
        
        // Get client and store it
        final client = _GoogleSignInHttpClient(account);
        _clients[account.email] = client;

        await _saveAccountsState();
        notifyListeners();

        return account.email;
      }
    } catch (e, stack) {
      _logger.severe('Google Sign-In failed', e, stack);
      rethrow;
    }
  }

  Future<String?> _signInDesktop() async {
    try {
      final clientId = _oauthClientId;
      _logger.info('Starting Desktop OAuth flow with Client ID: ${clientId.identifier}');
      
      final scopes = [...GoogleOAuthConfig.gmailReadOnlyScopes];
      
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final redirectUri = 'http://localhost:${server.port}';

      final authUrl = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
        'client_id': clientId.identifier,
        'redirect_uri': redirectUri,
        'response_type': 'code',
        'scope': scopes.join(' '),
        'access_type': 'offline', 
        'prompt': 'select_account', // Always allow selecting different accounts
      });

      _logger.info('Launching auth URL: $authUrl');
      if (!await launchUrl(authUrl)) {
        throw Exception('Could not launch URL: $authUrl');
      }

      String? code;
      await for (final request in server) {
        if (request.uri.queryParameters.containsKey('code')) {
          code = request.uri.queryParameters['code'];
          request.response
            ..statusCode = 200
            ..headers.contentType = ContentType.html
            ..write('<html><head><title>Auth Success</title></head><body style="font-family: sans-serif; text-align: center; padding-top: 50px;"><h1>Authentication Successful</h1><p>You can close this window now and return to the application.</p><script>window.close();</script></body></html>');
          await request.response.close();
          break;
        } else if (request.uri.queryParameters.containsKey('error')) {
          request.response
            ..statusCode = 400
            ..write('Authentication Failed');
          await request.response.close();
          break;
        }
      }
      await server.close();

      if (code == null) {
        throw Exception('Authorization flow cancelled or failed: No code received.');
      }

      final client = http.Client();
      final tokenResponse = await client.post(
        Uri.https('oauth2.googleapis.com', '/token'),
        body: {
          'client_id': clientId.identifier,
          'code': code,
          'grant_type': 'authorization_code',
          'redirect_uri': redirectUri,
          'client_secret': clientId.secret ?? '',
        },
      );

      if (tokenResponse.statusCode != 200) {
        _logger.severe('Token exchange failed: ${tokenResponse.body}');
        throw Exception('Failed to exchange code for token: ${tokenResponse.body}');
      }

      final tokenData = json.decode(tokenResponse.body);
      final accessToken = AccessToken(
        'Bearer',
        tokenData['access_token'],
        DateTime.now().toUtc().add(Duration(seconds: tokenData['expires_in'])),
      );

      final credentials = AccessCredentials(
        accessToken,
        tokenData['refresh_token'],
        scopes,
        idToken: tokenData['id_token'],
      );

      final authClient = autoRefreshingClient(clientId, credentials, http.Client());
      
      // Get email
      final gmailApi = GmailApi(authClient);
      final profile = await gmailApi.users.getProfile('me');
      final email = profile.emailAddress;

      if (email != null) {
        _clients[email] = authClient;
        _connectedEmails.add(email);
        
        await _saveDesktopCredentials(credentials, email);
        await _saveAccountsState();
        
        notifyListeners();
        _logger.info('Desktop login successful: $email');
        return email;
      } else {
        throw Exception('Could not retrieve email from Gmail profile.');
      }

    } catch (e, stack) {
      _logger.severe('Desktop Sign-In failed', e, stack);
      rethrow;
    }
  }

  // --- Sign Out ---

  Future<void> signOut({String? email}) async {
    if (email != null) {
      _connectedEmails.remove(email);
      final client = _clients.remove(email);
      client?.close();
      
      if (_isMobile) {
        // Unfortunately GoogleSignIn doesn't support signing out of a single specific account easily
        // if we use the default account tracking. For now, we sign out of the main session.
        await _googleSignIn.signOut();
      }
      
      await _storage.delete(key: 'desktop_credentials_$email');
      await _storage.delete(key: 'sync_time_$email');
    } else {
      for (final client in _clients.values) {
        client.close();
      }
      _clients.clear();
      _connectedEmails.clear();
      
      if (_isMobile) {
        await _googleSignIn.signOut();
      }
      await _storage.deleteAll();
    }
    
    await _saveAccountsState();
    notifyListeners();
    _logger.info('User signed out: ${email ?? "All accounts"}');
  }

  // --- Sync Time Tracking ---

  Future<DateTime?> getLastSyncTime(String email) async {
    try {
      final syncTimeText = await _storage.read(key: 'sync_time_$email');
      if (syncTimeText != null) {
        return DateTime.parse(syncTimeText);
      }
    } catch (e) {
      _logger.warning('Failed to read sync time for $email', e);
    }
    return null;
  }

  Future<void> setLastSyncTime(String email, DateTime time) async {
    try {
      await _storage.write(key: 'sync_time_$email', value: time.toIso8601String());
      notifyListeners();
    } catch (e) {
      _logger.severe('Failed to save sync time for $email', e);
    }
  }

  // --- State Persistence ---

  Future<void> _saveAccountsState() async {
    try {
      final List<String> emails = _connectedEmails.toList();
      await _storage.write(key: 'connected_emails', value: json.encode(emails));
    } catch (e) {
      _logger.severe('Failed to save accounts to storage', e);
    }
  }

  Future<void> _saveDesktopCredentials(AccessCredentials credentials, String email) async {
    try {
      final data = {
        'accessToken': credentials.accessToken.data,
        'expiry': credentials.accessToken.expiry.toIso8601String(),
        'refreshToken': credentials.refreshToken,
        'scopes': credentials.scopes,
        'email': email,
        'idToken': credentials.idToken,
      };
      await _storage.write(key: 'desktop_credentials_$email', value: json.encode(data));
    } catch (e) {
      _logger.severe('Failed to save desktop credentials', e);
    }
  }

  Future<void> _restoreAccounts() async {
    try {
      final emailsJson = await _storage.read(key: 'connected_emails');
      if (emailsJson != null) {
        final List<dynamic> emails = json.decode(emailsJson);
        _connectedEmails.addAll(emails.cast<String>());
      }

      if (_isMobile) {
        try {
           final account = await _googleSignIn.signInSilently();
           if (account != null) {
             _connectedEmails.add(account.email);
             final client = _GoogleSignInHttpClient(account);
             _clients[account.email] = client;
           }
        } catch (e) {
          _logger.warning('Mobile silent sign-in failed', e);
        }
      } else {
        // Desktop Restore for ALL accounts
        for (final email in _connectedEmails) {
          try {
            final credsJson = await _storage.read(key: 'desktop_credentials_$email');
            if (credsJson != null) {
              final data = json.decode(credsJson);
              
              final accessToken = AccessToken(
                'Bearer',
                data['accessToken'],
                DateTime.parse(data['expiry']),
              );
              
              final credentials = AccessCredentials(
                accessToken,
                data['refreshToken'],
                (data['scopes'] as List).cast<String>(),
                idToken: data['idToken'],
              );
              
              final authClient = autoRefreshingClient(_oauthClientId, credentials, http.Client());
              _clients[email] = authClient;
              _logger.info('Restored desktop session for $email');
            }
          } catch (e) {
             _logger.severe('Failed to restore desktop credentials for $email', e);
          }
        }
      }
      notifyListeners();
    } catch (e) {
      _logger.severe('Failed to restore accounts', e);
    }
  }

  // --- API Access ---

  Future<http.Client?> getClientForEmail(String email) async {
    // 1. Check current memory cache
    if (_clients.containsKey(email)) {
      return _clients[email];
    }

    // 2. Platform-specific recovery
    if (_isMobile) {
      final account = await _googleSignIn.signInSilently();
      if (account?.email == email) {
        final client = _GoogleSignInHttpClient(account!);
        _clients[email] = client;
        return client;
      }
    } else {
      // Desktop: Try to load from storage if not in memory
      try {
        final credsJson = await _storage.read(key: 'desktop_credentials_$email');
        if (credsJson != null) {
          final data = json.decode(credsJson);
          final accessToken = AccessToken('Bearer', data['accessToken'], DateTime.parse(data['expiry']));
          final credentials = AccessCredentials(accessToken, data['refreshToken'], (data['scopes'] as List).cast<String>(), idToken: data['idToken']);
          
          final client = autoRefreshingClient(_oauthClientId, credentials, http.Client());
          _clients[email] = client;
          return client;
        }
      } catch (e) {
        _logger.warning('Failed to load desktop client for $email', e);
      }
    }
    return null;
  }

  Future<String?> getAccessToken(String email) async {
    if (_isMobile) {
      // For mobile, we usually need the account instance
      final account = await _googleSignIn.signInSilently();
      if (account?.email == email) {
         final auth = await account!.authentication;
         return auth.accessToken;
      }
    } else if (_clients.containsKey(email)) {
       final client = _clients[email];
       if (client is AutoRefreshingAuthClient) {
         return client.credentials.accessToken.data;
       }
    }
    return null;
  }
}

/// A custom HTTP client that adds the Google Sign-In authentication header.
class _GoogleSignInHttpClient extends http.BaseClient {
  final GoogleSignInAccount _account;
  final http.Client _inner = http.Client();

  _GoogleSignInHttpClient(this._account);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final auth = await _account.authentication;
    request.headers['Authorization'] = 'Bearer ${auth.accessToken}';
    return _inner.send(request);
  }
  
  @override
  void close() {
    _inner.close();
    super.close();
  }
}


