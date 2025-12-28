import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pennypilot/src/data/models/subscription_model.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/services/subscription_intelligence_service.dart';

// Mocks
class MockIsar extends Mock implements Isar {}

class MockSubscriptionModels extends Mock
    implements IsarCollection<SubscriptionModel> {}

class MockTransactionModels extends Mock
    implements IsarCollection<TransactionModel> {}

class MockQueryBuilder<T, R, S> extends Mock implements QueryBuilder<T, R, S> {}

void main() {
  late SubscriptionIntelligenceService service;
  late MockIsar mockIsar;
  late MockSubscriptionModels mockSubscriptionModels;
  late MockTransactionModels mockTransactionModels;

  // A bit complex to mock the whole builder chain. Let's create a reusable setup function.
  void setupMockForZombieCheck({required bool isZombie}) {
    final queryBuilder =
        MockQueryBuilder<TransactionModel, TransactionModel, QStart>();
    final queryBuilderAfterFilter =
        MockQueryBuilder<TransactionModel, TransactionModel, QAfterFilterCondition>();

    when(() => mockTransactionModels.filter()).thenReturn(queryBuilder);
    when(() => queryBuilder.merchantNameContains(any(), caseSensitive: false))
        .thenReturn(queryBuilderAfterFilter);
    when(() => queryBuilderAfterFilter.dateGreaterThan(any()))
        .thenReturn(queryBuilderAfterFilter);

    if (isZombie) {
      when(() => queryBuilderAfterFilter.findAll()).thenAnswer((_) async => []);
    } else {
      when(() => queryBuilderAfterFilter.findAll())
          .thenAnswer((_) async => [TransactionModel()]);
    }
  }

  setUp(() {
    mockIsar = MockIsar();
    mockSubscriptionModels = MockSubscriptionModels();
    mockTransactionModels = MockTransactionModels();

    when(() => mockIsar.subscriptionModels).thenReturn(mockSubscriptionModels);
    when(() => mockIsar.transactionModels).thenReturn(mockTransactionModels);

    // Mock write transaction to execute the passed function
    when(() => mockIsar.writeTxn<dynamic>(any())).thenAnswer((invocation) async {
      final callback = invocation.positionalArguments[0] as Function;
      return await callback();
    });

    when(() => mockSubscriptionModels.put(any())).thenAnswer((_) async => 1);

    service = SubscriptionIntelligenceService(mockIsar);
  });

  group('SubscriptionIntelligenceService Tests', () {
    test('detects price hike', () async {
      final sub = SubscriptionModel()
        ..serviceName = 'Netflix'
        ..amount = 15.99
        ..priceHistoryJson = '[10.99, 15.99]'
        ..lifecycleState = SubscriptionLifecycle.active;

      setupMockForZombieCheck(isZombie: false); // Assume not a zombie for this test

      await service.evaluateSubscription(sub);

      expect(sub.anomalies, contains(SubscriptionAnomaly.priceHike.name));
      expect(sub.anomalies, isNot(contains(SubscriptionAnomaly.priceDrop.name)));
    });

    test('detects price drop', () async {
      final sub = SubscriptionModel()
        ..serviceName = 'Netflix'
        ..amount = 10.99
        ..priceHistoryJson = '[15.99, 10.99]'
        ..lifecycleState = SubscriptionLifecycle.active;

      setupMockForZombieCheck(isZombie: false);

      await service.evaluateSubscription(sub);

      expect(sub.anomalies, contains(SubscriptionAnomaly.priceDrop.name));
      expect(sub.anomalies, isNot(contains(SubscriptionAnomaly.priceHike.name)));
    });

    test('detects no price change when history is short', () async {
      final sub = SubscriptionModel()
        ..serviceName = 'Netflix'
        ..amount = 15.99
        ..priceHistoryJson = '[15.99]'
        ..lifecycleState = SubscriptionLifecycle.active;

      setupMockForZombieCheck(isZombie: false);

      await service.evaluateSubscription(sub);

      expect(sub.anomalies, isEmpty);
    });

    test('detects zombie subscription (active but no recent transactions)',
        () async {
      final sub = SubscriptionModel()
        ..serviceName = 'Amazon Prime'
        ..amount = 14.99
        ..priceHistoryJson = '[]'
        ..lifecycleState = SubscriptionLifecycle.active;

      setupMockForZombieCheck(isZombie: true);

      await service.evaluateSubscription(sub);

      expect(sub.anomalies, contains(SubscriptionAnomaly.zombie.name));
    });

    test('does not detect zombie subscription if inactive', () async {
      final sub = SubscriptionModel()
        ..serviceName = 'Old Gym'
        ..amount = 25.00
        ..priceHistoryJson = '[]'
        ..lifecycleState = SubscriptionLifecycle.cancelled;

      // No need to call setupMockForZombieCheck, as the code should short-circuit

      await service.evaluateSubscription(sub);

      expect(sub.anomalies, isEmpty);
      verifyNever(() => mockTransactionModels.filter()); // Ensure Isar isn't queried
    });

    test(
        'does not detect zombie subscription if there are recent transactions',
        () async {
      final sub = SubscriptionModel()
        ..serviceName = 'Spotify'
        ..amount = 9.99
        ..priceHistoryJson = '[]'
        ..lifecycleState = SubscriptionLifecycle.active;

      setupMockForZombieCheck(isZombie: false);

      await service.evaluateSubscription(sub);

      expect(sub.anomalies, isNot(contains(SubscriptionAnomaly.zombie.name)));
    });

    test('detects both price hike and zombie status', () async {
      final sub = SubscriptionModel()
        ..serviceName = 'Netflix'
        ..amount = 15.99
        ..priceHistoryJson = '[10.99, 15.99]' // Price hike
        ..lifecycleState = SubscriptionLifecycle.active;

      setupMockForZombieCheck(isZombie: true); // Is a zombie

      await service.evaluateSubscription(sub);

      expect(
          sub.anomalies,
          containsAll([
            SubscriptionAnomaly.priceHike.name,
            SubscriptionAnomaly.zombie.name
          ]));
    });
  });
}