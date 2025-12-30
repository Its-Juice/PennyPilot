import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/models/category_model.dart';
import 'package:pennypilot/src/data/models/subscription_model.dart';
import 'package:pennypilot/src/services/merchant_normalization_service.dart';
import 'package:pennypilot/src/services/subscription_intelligence_service.dart';
import 'package:pennypilot/src/services/receipt_extraction_service.dart';
import 'package:pennypilot/src/services/llm_extraction_service.dart';
import 'package:pennypilot/src/services/categorization_service.dart';
import 'package:pennypilot/src/services/startup_service.dart';

import 'package:pennypilot/src/presentation/providers/database_provider.dart';
export 'package:pennypilot/src/presentation/providers/database_provider.dart';

// Startup service provider
final startupServiceProvider = Provider<StartupService>((ref) {
  final merchantService = ref.watch(merchantNormalizationServiceProvider);
  final categorizationService = ref.watch(categorizationServiceProvider);
  final llmService = ref.watch(llmExtractionServiceProvider);
  
  return StartupService(merchantService, categorizationService, llmService);
});

// LLM Extraction service provider
final llmExtractionServiceProvider = Provider<LLMExtractionService>((ref) {
  return LLMExtractionService();
});

// Categorization service provider
final categorizationServiceProvider = Provider<CategorizationService>((ref) {
  final isar = ref.watch(isarProvider);
  return CategorizationService(isar);
});

// Merchant normalization service provider
final merchantNormalizationServiceProvider = Provider<MerchantNormalizationService>((ref) {
  final isar = ref.watch(isarProvider);
  return MerchantNormalizationService(isar);
});

// Subscription intelligence service provider
final subscriptionIntelligenceServiceProvider = Provider<SubscriptionIntelligenceService>((ref) {
  final isar = ref.watch(isarProvider);
  final categorizationService = ref.watch(categorizationServiceProvider);
  
  return SubscriptionIntelligenceService(isar, categorizationService);
});

// Receipt extraction service provider
final receiptExtractionServiceProvider = Provider<ReceiptExtractionService>((ref) {
  final merchantService = ref.watch(merchantNormalizationServiceProvider);
  final llmService = ref.watch(llmExtractionServiceProvider);
  
  return ReceiptExtractionService(merchantService, llmService);
});

// Transactions stream provider
final transactionsProvider = StreamProvider<List<TransactionModel>>((ref) {
  final isar = ref.watch(isarProvider);
  
  return isar.transactionModels
      .where()
      .sortByDateDesc()
      .watch(fireImmediately: true);
});

// Subscriptions stream provider
final subscriptionsProvider = StreamProvider<List<SubscriptionModel>>((ref) {
  final isar = ref.watch(isarProvider);
  
  return isar.subscriptionModels
      .where()
      .sortByNextRenewalDate()
      .watch(fireImmediately: true);
});

// Active subscriptions only
final activeSubscriptionsProvider = StreamProvider<List<SubscriptionModel>>((ref) {
  final isar = ref.watch(isarProvider);
  
  return isar.subscriptionModels
      .filter()
      .lifecycleStateEqualTo(SubscriptionLifecycleState.active)
      .watch(fireImmediately: true);
});

// Subscription statistics provider
final subscriptionStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final service = ref.watch(subscriptionIntelligenceServiceProvider);
  return await service.getStatistics();
});

// Transaction count provider
final transactionCountProvider = FutureProvider<int>((ref) async {
  final isar = ref.watch(isarProvider);
  return await isar.transactionModels.count();
});

// Categories stream provider
final categoriesProvider = StreamProvider<List<CategoryModel>>((ref) {
  final isar = ref.watch(isarProvider);
  
  return isar.categoryModels
      .where()
      .sortByOrder()
      .watch(fireImmediately: true);
});

// Recent transactions (last 30 days)
final recentTransactionsProvider = StreamProvider<List<TransactionModel>>((ref) {
  final isar = ref.watch(isarProvider);
  final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
  
  return isar.transactionModels
      .filter()
      .dateGreaterThan(thirtyDaysAgo)
      .sortByDateDesc()
      .watch(fireImmediately: true);
});
