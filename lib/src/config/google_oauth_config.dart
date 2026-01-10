import 'secrets.dart';

class GoogleOAuthConfig {
  // Desktop OAuth client ID (Linux / macOS / Windows)
  static const String desktopClientId = Secrets.googleDesktopClientId;

  // Secret is required for "installed" client type even on desktop loopback
  static const String desktopClientSecret = Secrets.googleDesktopClientSecret;

  // Mobile OAuth client ID (Android / iOS)
  static const String mobileClientId = Secrets.googleMobileClientId;

  // Web OAuth client ID (Required for Android serverClientId)
  // For security, you should move this to Secrets class in secrets.dart
  static const String webClientId = 'REPLACE_ME_WITH_REAL_WEB_CLIENT_ID.apps.googleusercontent.com';

  static const List<String> gmailReadOnlyScopes = [
    'email',
    'https://www.googleapis.com/auth/gmail.readonly',
  ];
}
