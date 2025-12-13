import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:pennypilot/src/data/local/database_service.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/models/subscription_model.dart';
import 'package:pennypilot/src/services/merchant_normalization_service.dart';
import 'package:pennypilot/src/services/subscription_intelligence_service.dart';

// Database service provider
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

// Isar instance provider
final isarProvider = FutureProvider<Isar>((ref) async {
  final dbService = ref.watch(databaseServiceProvider);
  return await dbService.db;
});

// Merchant normalization service provider
final merchantNormalizationServiceProvider = Provider<MerchantNormalizationService>((ref) {
  final isar = ref.watch(isarProvider).value;
  if (isar == null) throw Exception('Database not initialized');
  return MerchantNormalizationService(isar);
});

// Subscription intelligence service provider
final subscriptionIntelligenceServiceProvider = Provider<SubscriptionIntelligenceService>((ref) {
  final isar = ref.watch(isarProvider).value;
  if (isar == null) throw Exception('Database not initialized');
  return SubscriptionIntelligenceService(isar);
});

// Transactions stream provider
final transactionsProvider = StreamProvider<List<TransactionModel>>((ref) async* {
  final isar = await ref.watch(isarProvider.future);
  
  yield* isar.transactionModels
      .where()
      .sortByDateDesc()
      .watch(fireImmediately: true);
});

// Subscriptions stream provider
final subscriptionsProvider = StreamProvider<List<SubscriptionModel>>((ref) async* {
  final isar = await ref.watch(isarProvider.future);
  
  yield* isar.subscriptionModels
      .where()
      .sortByNextRenewalDate()
      .watch(fireImmediately: true);
});

// Active subscriptions only
final activeSubscriptionsProvider = StreamProvider<List<SubscriptionModel>>((ref) async* {
  final isar = await ref.watch(isarProvider.future);
  
  yield* isar.subscriptionModels
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
  final isar = await ref.watch(isarProvider.future);
  return await isar.transactionModels.count();
});

// Recent transactions (last 30 days)
final recentTransactionsProvider = StreamProvider<List<TransactionModel>>((ref) async* {
  final isar = await ref.watch(isarProvider.future);
  final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
  
  yield* isar.transactionModels
      .filter()
      .dateGreaterThan(thirtyDaysAgo)
      .sortByDateDesc()
      .watch(fireImmediately: true);
});
