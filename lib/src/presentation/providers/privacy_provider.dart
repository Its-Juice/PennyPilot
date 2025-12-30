import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/services/privacy_service.dart';
import 'package:pennypilot/src/presentation/providers/theme_provider.dart';

final privacyServiceProvider = Provider<PrivacyService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return PrivacyService(prefs);
});

final isLocalOnlyModeProvider = StateProvider<bool>((ref) {
  final service = ref.watch(privacyServiceProvider);
  return service.isLocalOnlyMode;
});

final isBiometricEnabledProvider = StateProvider<bool>((ref) {
  final service = ref.watch(privacyServiceProvider);
  return service.isBiometricEnabled;
});
