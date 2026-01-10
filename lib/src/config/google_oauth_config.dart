import 'secrets.dart';

class GoogleOAuthConfig {
  // Desktop OAuth client ID (Linux / macOS / Windows)
  static const String desktopClientId = Secrets.googleDesktopClientId;

  // Secret is required for "installed" client type even on desktop loopback
  static const String desktopClientSecret = Secrets.googleDesktopClientSecret;

  // Mobile OAuth client ID (Android / iOS)
  static const String mobileClientId = Secrets.googleMobileClientId;

  // Web OAuth client ID (Required for Android serverClientId)
  static const String webClientId = Secrets.googleWebClientId;

  static const List<String> gmailReadOnlyScopes = [
    'email',
    'https://www.googleapis.com/auth/gmail.readonly',
  ];
}
