import 'package:isar/isar.dart';
import 'package:pennypilot/src/data/models/budget_model.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/models/subscription_model.dart';

class BudgetService {
  final Isar _isar;

  BudgetService(this._isar);

  /// Get budget for a specific category (or total if categoryId is null)
  Future<BudgetModel?> getBudget(int? categoryId) async {
    return await _isar.budgetModels
        .filter()
        .categoryIdEqualTo(categoryId)
        .findFirst();
  }

  /// Set or update budget
  Future<void> setBudget({
    int? categoryId,
    required double limitAmount,
    BudgetPeriod period = BudgetPeriod.monthly,
    bool rollover = false,
  }) async {
    await _isar.writeTxn(() async {
      final existing = await _isar.budgetModels
          .filter()
          .categoryIdEqualTo(categoryId)
          .findFirst();

      final budget = existing ?? BudgetModel()
        ..categoryId = categoryId
        ..createdAt = DateTime.now();

      budget.limitAmount = limitAmount;
      budget.period = period;
      budget.rollover = rollover;
      budget.updatedAt = DateTime.now();

      await _isar.budgetModels.put(budget);
    });
  }

  /// Process rollovers for a new period
  Future<void> processRollovers() async {
    final now = DateTime.now();
    // Logic to detect if we've entered a new period and apply carry-overs
    // For now, let's implement a trigger-based rollover for simplicity
    await _isar.writeTxn(() async {
      final allBudgets = await _isar.budgetModels.where().findAll();
      final budgets = allBudgets.where((b) => b.rollover).toList();
      for (var budget in budgets) {
        // Find spending in the previous period
        final startOfPrevPeriod = _getStartOfPreviousPeriod(budget.period, now);
        final endOfPrevPeriod = _getStartOfCurrentPeriod(budget.period, now).subtract(const Duration(seconds: 1));
        
        final transactions = await _isar.transactionModels
            .filter()
            .dateBetween(startOfPrevPeriod, endOfPrevPeriod)
            .categoryIdEqualTo(budget.categoryId)
            .findAll();
            
        final spent = transactions.fold<double>(0, (sum, t) => sum + t.amount);
        final remaining = budget.limitAmount + budget.carryOverAmount - spent;
        
        if (remaining > 0) {
          budget.carryOverAmount = remaining;
          budget.updatedAt = now;
          await _isar.budgetModels.put(budget);
        }
      }
    });
  }

  DateTime _getStartOfCurrentPeriod(BudgetPeriod period, DateTime now) {
    switch (period) {
      case BudgetPeriod.weekly:
        return now.subtract(Duration(days: now.weekday - 1));
      case BudgetPeriod.monthly:
        return DateTime(now.year, now.month, 1);
      default:
        return DateTime(now.year, now.month, 1);
    }
  }

  DateTime _getStartOfPreviousPeriod(BudgetPeriod period, DateTime now) {
    final currentStart = _getStartOfCurrentPeriod(period, now);
    switch (period) {
      case BudgetPeriod.weekly:
        return currentStart.subtract(const Duration(days: 7));
      case BudgetPeriod.monthly:
        return DateTime(currentStart.year, currentStart.month - 1, 1);
      default:
        return DateTime(currentStart.year, currentStart.month - 1, 1);
    }
  }

  /// Calculate "Safe-to-Spend" amount for the remainder of the month
  Future<SafeToSpendResult> calculateSafeToSpend() async {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final remainingDays = daysInMonth - now.day + 1;

    // Get total budget
    final totalBudget = await getBudget(null);
    if (totalBudget == null) {
      return SafeToSpendResult(
        isBudgetSet: false,
        dailySafeAmount: 0,
        remainingMonthly: 0,
      );
    }

    // Get spending so far this month
    final startOfMonth = DateTime(now.year, now.month, 1);
    final transactions = await _isar.transactionModels
        .filter()
        .dateGreaterThan(startOfMonth.subtract(const Duration(seconds: 1)))
        .findAll();
    
    final spentSoFar = transactions.fold<double>(0, (sum, t) => sum + t.amount);

    // Get upcoming subscriptions for the remainder of the month
    final subscriptions = await _isar.subscriptionModels
        .filter()
        .lifecycleStateEqualTo(SubscriptionLifecycleState.active)
        .nextRenewalDateBetween(now, DateTime(now.year, now.month, daysInMonth, 23, 59, 59))
        .findAll();

    final upcomingSubTotal = subscriptions.fold<double>(0, (sum, s) => sum + s.amount);

    final totalLimit = totalBudget.limitAmount + totalBudget.carryOverAmount;
    final remainingMonthly = (totalLimit - spentSoFar - upcomingSubTotal).clamp(0.0, double.infinity);
    final dailySafeAmount = remainingMonthly / remainingDays;

    return SafeToSpendResult(
      isBudgetSet: true,
      dailySafeAmount: dailySafeAmount,
      remainingMonthly: remainingMonthly,
      totalLimit: totalLimit,
      spentSoFar: spentSoFar,
      upcomingSubs: upcomingSubTotal,
    );
  }

  /// Create a split for a transaction
  Future<void> createSplit(int transactionId, List<SpendingSplitModel> splits) async {
    await _isar.writeTxn(() async {
      final transaction = await _isar.transactionModels.get(transactionId);
      if (transaction != null) {
        transaction.hasSplits = true;
        await _isar.transactionModels.put(transaction);

        // Delete old splits if any
        await _isar.spendingSplitModels
            .filter()
            .transactionIdEqualTo(transactionId)
            .deleteAll();

        // Save new splits
        for (var split in splits) {
          split.transactionId = transactionId;
          split.createdAt = DateTime.now();
          await _isar.spendingSplitModels.put(split);
        }
      }
    });
  }

  /// Get splits for a transaction
  Future<List<SpendingSplitModel>> getSplits(int transactionId) async {
    return await _isar.spendingSplitModels
        .filter()
        .transactionIdEqualTo(transactionId)
        .findAll();
  }
}

class SafeToSpendResult {
  final bool isBudgetSet;
  final double dailySafeAmount;
  final double remainingMonthly;
  final double totalLimit;
  final double spentSoFar;
  final double upcomingSubs;

  SafeToSpendResult({
    required this.isBudgetSet,
    required this.dailySafeAmount,
    required this.remainingMonthly,
    this.totalLimit = 0,
    this.spentSoFar = 0,
    this.upcomingSubs = 0,
  });

  double get monthlyBudget => totalLimit;
}
