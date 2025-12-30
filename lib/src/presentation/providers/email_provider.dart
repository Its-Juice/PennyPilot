import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/services/email_service.dart';
import 'package:pennypilot/src/presentation/providers/auth_provider.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/presentation/providers/privacy_provider.dart';

final emailServiceProvider = Provider<EmailService>((ref) {
  final authService = ref.watch(authServiceProvider);
  final receiptService = ref.watch(receiptExtractionServiceProvider);
  final subscriptionService = ref.watch(subscriptionIntelligenceServiceProvider);
  final categorizationService = ref.watch(categorizationServiceProvider);
  final privacyService = ref.watch(privacyServiceProvider);
  final isar = ref.watch(isarProvider);
  
  return EmailService(authService, receiptService, subscriptionService, categorizationService, privacyService, isar);
});
