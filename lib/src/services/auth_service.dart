import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'dart:io';
import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:http/http.dart' as http;

import 'package:googleapis/gmail/v1.dart';
import '../config/google_oauth_config.dart';

class AuthService extends ChangeNotifier {
  // Mobile Only
  GoogleSignIn? _googleSignIn;

  // Desktop Only
  AutoRefreshingAuthClient? _desktopClient;
  String? _desktopEmail;

  final bool _isMobile = Platform.isAndroid || Platform.isIOS;
  final Set<String> _connectedEmails = {};

  final _storage = const FlutterSecureStorage();
  final _logger = Logger('AuthService');

  AuthService() {
    if (_isMobile) {
      _googleSignIn = GoogleSignIn(
        clientId: Platform.isIOS ? GoogleOAuthConfig.mobileClientId : null,
        scopes: GoogleOAuthConfig.gmailReadOnlyScopes,
      );
    }
    _initialize();
  }

  // --- Getters ---

  Set<String> get connectedEmails => _connectedEmails;

  // Returns the GoogleSignIn instance for mobile widgets, null on desktop.
  GoogleSignIn? get googleSignIn => _googleSignIn;

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
      if (_googleSignIn == null) return null;
      final GoogleSignInAccount? account = await _googleSignIn!.signIn();

      if (account == null) {
        debugPrint('Sign in returned null (user cancelled or failed)');
        return null;
      } else {
        debugPrint('Signed in as ${account.email}');
        _logger.info('User signed in: ${account.email}');

        _connectedEmails.add(account.email);
        await _saveAccountsState();
        notifyListeners();

        return account.email;
      }
    } catch (e, stack) {
      debugPrint('Google sign-in failed: $e');
      debugPrint(stack.toString());
      _logger.severe('Google Sign-In failed', e, stack);
      rethrow;
    }
  }

  Future<String?> _signInDesktop() async {
    try {
      // 1. Setup Client and Loopback Server
      // Explicitly using the Desktop Client ID which triggers the correct flow
      final clientId = ClientId(GoogleOAuthConfig.desktopClientId, GoogleOAuthConfig.desktopClientSecret);
      _logger.info('Starting Desktop OAuth flow with Client ID: ${clientId.identifier}');
      
      // Use only the requested scopes
      final scopes = [...GoogleOAuthConfig.gmailReadOnlyScopes];
      
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final redirectUri = 'http://localhost:${server.port}';

      // 2. Launch Auth URL
      final authUrl = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
        'client_id': clientId.identifier,
        'redirect_uri': redirectUri,
        'response_type': 'code',
        'scope': scopes.join(' '),
        'access_type': 'offline', // Required for refresh token
      });

      _logger.info('Launching auth URL: $authUrl');
      if (!await launchUrl(authUrl)) {
        throw Exception('Could not launch URL: $authUrl');
      }

      // 3. Listen for Code
      String? code;
      await for (final request in server) {
        if (request.uri.queryParameters.containsKey('code')) {
          code = request.uri.queryParameters['code'];
          request.response
            ..statusCode = 200
            ..headers.contentType = ContentType.html
            ..write('<html><head><title>Auth Success</title></head><body><h1>Authentication Successful</h1><p>You can close this window now and return to the application.</p><script>window.close();</script></body></html>');
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

      // 4. Exchange Code for Tokens
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

      _desktopClient = autoRefreshingClient(clientId, credentials, http.Client());

      // 5. Fetch User Info (Email) via Gmail API
      // Since we dropped 'email'/'profile' scopes, we use Gmail API to identify the user.
      final gmailApi = GmailApi(_desktopClient!);
      final profile = await gmailApi.users.getProfile('me');
      final email = profile.emailAddress;

      if (email != null) {
        _desktopEmail = email;
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
      
      // Mobile Sign out
      if (_isMobile && _googleSignIn?.currentUser?.email == email) {
        await _googleSignIn!.signOut();
      }
      
      // Desktop Sign out
      if (!_isMobile && _desktopEmail == email) {
        _desktopClient?.close();
        _desktopClient = null;
        _desktopEmail = null;
      }
      await _storage.delete(key: 'desktop_credentials_$email');
      await _storage.delete(key: 'sync_time_$email');
    } else {
      // Sign out all
      _connectedEmails.clear();
      
      if (_isMobile) {
        await _googleSignIn?.signOut();
      } else {
        _desktopClient?.close();
        _desktopClient = null;
        _desktopEmail = null;
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
      // Restore list of connected emails
      final emailsJson = await _storage.read(key: 'connected_emails');
      if (emailsJson != null) {
        final List<dynamic> emails = json.decode(emailsJson);
        _connectedEmails.addAll(emails.cast<String>());
      }

      if (_isMobile && _googleSignIn != null) {
        // Mobile Restore
        try {
          if (await _googleSignIn!.isSignedIn()) {
             final account = await _googleSignIn!.signInSilently();
             if (account != null) {
               _connectedEmails.add(account.email);
             }
          }
        } catch (e) {
          _logger.warning('Mobile silent sign-in failed', e);
        }
      } else if (!_isMobile) {
        // Desktop Restore
        try {
          // On desktop, we try to restore the first email from the connected list as the "active" client
          if (_connectedEmails.isNotEmpty) {
            final firstEmail = _connectedEmails.first;
            final credsJson = await _storage.read(key: 'desktop_credentials_$firstEmail');
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
              
              final clientId = ClientId(GoogleOAuthConfig.desktopClientId, GoogleOAuthConfig.desktopClientSecret);
              _desktopClient = autoRefreshingClient(clientId, credentials, http.Client());
              _desktopEmail = data['email'];
              
              _logger.info('Restored desktop session for $_desktopEmail');
            }
          }
        } catch (e) {
           _logger.severe('Failed to restore desktop credentials', e);
        }
      }
    } catch (e) {
      _logger.severe('Failed to restore accounts', e);
    }
  }

  // --- API Access ---

  Future<AuthClient?> getClientForEmail(String email) async {
    if (_isMobile && _googleSignIn != null) {
      // Check if the requested email matches the current GoogleSignIn user
      if (_googleSignIn!.currentUser?.email == email) {
        return await _googleSignIn!.authenticatedClient();
      }
    } else if (!_isMobile) {
       // On Desktop, if we have a client matching the email
       if (_desktopEmail == email) {
         return _desktopClient;
       } else {
         // Try to load credentials for this specific email if not active
         try {
           final credsJson = await _storage.read(key: 'desktop_credentials_$email');
           if (credsJson != null) {
             final data = json.decode(credsJson);
             final accessToken = AccessToken('Bearer', data['accessToken'], DateTime.parse(data['expiry']));
             final credentials = AccessCredentials(accessToken, data['refreshToken'], (data['scopes'] as List).cast<String>(), idToken: data['idToken']);
             final clientId = ClientId(GoogleOAuthConfig.desktopClientId, GoogleOAuthConfig.desktopClientSecret);
             
             // Optionally update active client
             final client = autoRefreshingClient(clientId, credentials, http.Client());
             _desktopClient = client;
             _desktopEmail = email;
             return client;
           }
         } catch (e) {
           _logger.warning('Failed to load desktop client for $email', e);
         }
       }
    }
    return null;
  }

  Future<String?> getAccessToken() async {
    if (_isMobile && _googleSignIn != null) {
      final account = _googleSignIn!.currentUser;
      if (account != null) {
         final auth = await account.authentication;
         return auth.accessToken;
      }
    } else if (!_isMobile && _desktopClient != null) {
      // autoRefreshingClient handles token refresh automatically
       return _desktopClient!.credentials.accessToken.data;
    }
    return null;
  }
}
