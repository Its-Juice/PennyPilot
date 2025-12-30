# Android OAuth Setup Guide

To resolve `PlatformException(10)` and ensure Google Sign-In works correctly on Android, follow these steps to register your SHA-1 fingerprint.

## 1. Locate your SHA-1 Fingerprint

You need the SHA-1 fingerprint of your signing certificate. For development, you use the debug certificate.

### On Linux/macOS:
Run the following command in your terminal:
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

### On Windows:
Run the following command in PowerShell:
```powershell
keytool -list -v -keystore "$env:USERPROFILE\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
```

Look for the line that starts with `SHA1:`. It will look something like this:
`SHA1: AA:BB:CC:DD:EE:FF:11:22:33:44:55:66:77:88:99:00:AA:BB:CC:DD`

## 2. Register in Google Cloud Console

1.  Go to the [Google Cloud Console](https://console.cloud.google.com/).
2.  Select your project.
3.  Navigate to **APIs & Services > Credentials**.
4.  Find your **OAuth 2.0 Client IDs**. You should have one for Android.
    - If you don't have one, click **Create Credentials > OAuth client ID**, select **Android**.
5.  Edit the Android Client ID.
6.  Ensure the **Package name** is exactly `com.example.pennypilot` (or whatever is in your `AndroidManifest.xml`).
7.  Add your **SHA-1 certificate fingerprint** in the corresponding field.
8.  Save the changes.

## 3. Register in Firebase Console (Highly Recommended)

If you are using Firebase (recommended for Android Google Sign-In even if you don't use other Firebase features):

1.  Go to the [Firebase Console](https://console.firebase.google.com/).
2.  Select your project.
3.  Click the gear icon (Project settings) and go to **General**.
4.  Scroll down to **Your apps** and select the Android app.
5.  Click **Add fingerprint** and paste your SHA-1.
6.  Download the updated `google-services.json`.
7.  Place it in `android/app/google-services.json`.

## 4. Reset the Application

After making changes in the console:

1.  Stop the app if it's running.
2.  Run `flutter clean`.
3.  Run `flutter pub get`.
4.  If on a physical device, consider uninstalling the old version of the app.
5.  Run `flutter run`.

## Troubleshooting `PlatformException(10)`

- **Wrong SHA-1**: Ensure you are using the fingerprint from the same machine where you are building the APK.
- **Wrong Package Name**: Double-check `android/app/build.gradle` for `applicationId`.
- **OAuth Consent Screen**: Ensure your app status is "Testing" and you have added your email as a "Test user" in the OAuth consent screen settings.
