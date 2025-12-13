import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
