import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/services/email_service.dart';
import 'package:pennypilot/src/presentation/providers/auth_provider.dart';

final emailServiceProvider = Provider<EmailService>((ref) {
  final authService = ref.watch(authServiceProvider);
  return EmailService(authService.googleSignIn);
});
