import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:pennypilot/src/services/budget_service.dart';
import 'package:pennypilot/src/data/models/budget_model.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/models/subscription_model.dart';

void main() {
  late Isar isar;
  late BudgetService service;
  late Directory tempDir;

  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    tempDir = await Directory.systemTemp.createTemp('pennypilot_budget_test');
    isar = await Isar.open(
      [BudgetModelSchema, TransactionModelSchema, SubscriptionModelSchema, SpendingSplitModelSchema],
      directory: tempDir.path,
    );
    service = BudgetService(isar);
  });

  tearDown(() async {
    await isar.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('BudgetService Tests', () {
    test('Set and get total budget', () async {
      await service.setBudget(limitAmount: 1000);
      final budget = await service.getBudget(null);
      expect(budget?.limitAmount, 1000);
    });

    test('calculateSafeToSpend returns correct values', () async {
      final now = DateTime.now();
      final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
      final remainingDays = daysInMonth - now.day + 1;

      await service.setBudget(limitAmount: 1000);

      // Add spending
      await isar.writeTxn(() async {
        await isar.transactionModels.put(TransactionModel()
          ..merchantName = 'Groceries'
          ..amount = 100
          ..date = now
          ..createdAt = now);
      });

      // Add upcoming subscription
      await isar.writeTxn(() async {
        await isar.subscriptionModels.put(SubscriptionModel(
          serviceName: 'Netflix',
          amount: 20,
          nextRenewalDate: now.add(const Duration(days: 1)),
          firstSeenDate: now,
          createdAt: now,
        )..lifecycleState = SubscriptionLifecycleState.active);
      });

      final result = await service.calculateSafeToSpend();

      expect(result.isBudgetSet, isTrue);
      expect(result.spentSoFar, 100);
      expect(result.upcomingSubs, 20);
      expect(result.remainingMonthly, 1000 - 100 - 20);
      expect(result.dailySafeAmount, (1000 - 100 - 20) / remainingDays);
    });

    test('calculateSafeToSpend returns isBudgetSet false when no budget', () async {
      final result = await service.calculateSafeToSpend();
      expect(result.isBudgetSet, isFalse);
    });
  });
}
