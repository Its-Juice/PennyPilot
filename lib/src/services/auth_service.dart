import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/gmail.readonly',
    ],
  );
  
  final _storage = const FlutterSecureStorage();
  final _logger = Logger('AuthService');

  GoogleSignIn get googleSignIn => _googleSignIn;

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication auth = await account.authentication;
        
        // Store tokens securely
        await _storage.write(key: 'google_access_token', value: auth.accessToken);
        if (auth.idToken != null) {
          await _storage.write(key: 'google_id_token', value: auth.idToken);
        }
        
        _logger.info('User signed in: ${account.email}');
        return account;
      }
    } catch (error) {
      _logger.severe('Google Sign-In failed', error);
      rethrow;
    }
    return null;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _storage.deleteAll();
    _logger.info('User signed out and tokens cleared');
  }

  Future<String?> getAccessToken() async {
    // Check if token is valid or refresh it (simplified for now)
    // In a real app, we'd handle token refresh via the GoogleSignIn instance silently
    final account = _googleSignIn.currentUser;
    if (account != null) {
       final auth = await account.authentication;
       return auth.accessToken;
    }
    return await _storage.read(key: 'google_access_token');
  }
}
