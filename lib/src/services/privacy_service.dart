import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logging/logging.dart';

class PrivacyService {
  final SharedPreferences _prefs;
  final LocalAuthentication _auth = LocalAuthentication();
  final _logger = Logger('PrivacyService');

  PrivacyService(this._prefs);

  // --- Local-Only Mode ---
  
  bool get isLocalOnlyMode => _prefs.getBool('isLocalOnlyMode') ?? false;

  Future<void> setLocalOnlyMode(bool enabled) async {
    await _prefs.setBool('isLocalOnlyMode', enabled);
  }

  // --- Biometric Lock ---

  bool get isBiometricEnabled => _prefs.getBool('isBiometricEnabled') ?? false;

  Future<void> setBiometricEnabled(bool enabled) async {
    await _prefs.setBool('isBiometricEnabled', enabled);
  }

  Future<bool> canCheckBiometrics() async {
    return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    if (!isBiometricEnabled) return true;

    try {
      return await _auth.authenticate(
        localizedReason: 'Please authenticate to access PennyPilot',
      );
    } catch (e) {
      _logger.severe('Biometric authentication failed', e);
      return false;
    }
  }
}
