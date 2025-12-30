import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'dart:convert';
import 'dart:math' as math;
import 'package:pennypilot/src/services/categorization_service.dart';
import 'package:pennypilot/src/data/models/subscription_model.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';

class SubscriptionIntelligenceService {
  final Isar _isar;
  final CategorizationService? _categorizationService;
  final _logger = Logger('SubscriptionIntelligenceService');

  // Thresholds for subscription detection
  static const int minChargesForDetection = 2;
  static const int maxDaysBetweenCharges = 45; // For monthly subscriptions
  static const double consistencyThreshold = 80.0; // 80% consistency

  SubscriptionIntelligenceService(this._isar, [this._categorizationService]);

  Future<void> evaluateSubscription(SubscriptionModel subscription) async {
    subscription.anomalies.clear();

    // Price change detection
    if (subscription.priceHistoryJson != null) {
      final priceHistory = jsonDecode(subscription.priceHistoryJson!) as List<dynamic>;
      if (priceHistory.length >= 2) {
        final lastPrice = priceHistory[priceHistory.length - 1] as double;
        final previousPrice = priceHistory[priceHistory.length - 2] as double;

        if (lastPrice > previousPrice) {
          subscription.anomalies.add(SubscriptionAnomaly.priceHike.name);
        } else if (lastPrice < previousPrice) {
          subscription.anomalies.add(SubscriptionAnomaly.priceDrop.name);
        }
      }
    }

    // Zombie subscription detection
    if (subscription.lifecycleState == SubscriptionLifecycleState.active) {
      final recentTransactions = await _isar.transactionModels
          .filter()
          .merchantNameContains(subscription.serviceName, caseSensitive: false)
          .dateGreaterThan(DateTime.now().subtract(const Duration(days: 90)))
          .findAll();

      if (recentTransactions.isEmpty) {
        subscription.anomalies.add(SubscriptionAnomaly.zombie.name);
      }
    }

    await _isar.writeTxn(() async {
      await _isar.subscriptionModels.put(subscription);
    });
  }

  /// Detect subscriptions from transaction patterns
  Future<List<SubscriptionModel>> detectSubscriptions() async {
    _logger.info('Analyzing transactions for subscription patterns...');

    final transactions = await _isar.transactionModels
        .where()
        .sortByDate()
        .findAll();

    // Group transactions by merchant
    final merchantGroups = <String, List<TransactionModel>>{};
    for (var transaction in transactions) {
      final merchant = transaction.merchantName;
      merchantGroups.putIfAbsent(merchant, () => []).add(transaction);
    }

    final detectedSubscriptions = <SubscriptionModel>[];

    for (var entry in merchantGroups.entries) {
      final merchant = entry.key;
      final merchantTransactions = entry.value;

      if (merchantTransactions.length < minChargesForDetection) continue;

      final subscription = await _analyzeForSubscription(
        merchant,
        merchantTransactions,
      );

      if (subscription != null) {
        detectedSubscriptions.add(subscription);
      }
    }

    // Persist to database
    await _isar.writeTxn(() async {
      for (var subscription in detectedSubscriptions) {
        // Check if subscription already exists for this service
        final existing = await _isar.subscriptionModels
            .filter()
            .serviceNameEqualTo(subscription.serviceName)
            .findFirst();

        if (existing != null) {
          // Update existing subscription but preserve user customizations
          subscription.id = existing.id;
          subscription.userConfirmed = existing.userConfirmed;
          subscription.notes = existing.notes;
          // Preserve category if user set one
          if (existing.categoryId != null) {
            subscription.categoryId = existing.categoryId;
          }
        }

        await _isar.subscriptionModels.put(subscription);
      }
    });

    _logger.info('Detected ${detectedSubscriptions.length} potential subscriptions');
    return detectedSubscriptions;
  }

  /// Analyze transactions for a specific merchant to detect subscription
  Future<SubscriptionModel?> _analyzeForSubscription(
    String merchant,
    List<TransactionModel> transactions,
  ) async {
    if (transactions.length < minChargesForDetection) return null;

    // Sort by date
    transactions.sort((a, b) => a.date.compareTo(b.date));

    // Calculate days between charges
    final daysBetween = <int>[];
    for (var i = 1; i < transactions.length; i++) {
      final days = transactions[i].date.difference(transactions[i - 1].date).inDays;
      daysBetween.add(days);
    }

    // Calculate average and consistency
    final avgDays = daysBetween.reduce((a, b) => a + b) / daysBetween.length;
    final consistency = _calculateConsistency(daysBetween, avgDays);

    // Check if it looks like a subscription
    if (consistency < consistencyThreshold) return null;

    // Determine frequency
    final frequency = _determineFrequency(avgDays);
    if (frequency == SubscriptionFrequency.unknown) return null;

    // Get most recent amount
    final latestTransaction = transactions.last;
    final amount = latestTransaction.amount;

    // Detect price changes
    final priceHistory = _buildPriceHistory(transactions);
    final cycleHistory = _buildCycleHistory(daysBetween, transactions);

    // Calculate next renewal date
    final nextRenewal = latestTransaction.date.add(
      Duration(days: avgDays.round()),
    );

    // Determine lifecycle state
    final lifecycleState = _determineLifecycleState(
      latestTransaction.date,
      avgDays,
    );

    // Check if it's a trial
    final isTrial = _detectTrial(transactions, daysBetween);

    // Detect Zombie state & Price Hikes
    bool isZombie = false;
    String? zombieReason;
    double? priceHikePercent;

    if (transactions.length >= 2) {
      final lastAmount = transactions.last.amount;
      final prevAmount = transactions[transactions.length - 2].amount;
      
      if (lastAmount > prevAmount && prevAmount > 0) {
        priceHikePercent = ((lastAmount - prevAmount) / prevAmount) * 100;
        if (priceHikePercent > 10) {
          isZombie = true;
          zombieReason = 'Significant price increase detected (${priceHikePercent.toStringAsFixed(1)}%)';
        }
      }
      
      // Trial to paid transition
      if (transactions.first.amount < lastAmount * 0.1 && lastAmount > 0) {
        if (transactions.length >= 2 && transactions.last.amount > transactions.first.amount) {
          isZombie = true;
          zombieReason = 'Free trial ended; now charging full price';
        }
      }
    }

    final subscription = SubscriptionModel(
      serviceName: merchant,
      amount: amount,
      nextRenewalDate: nextRenewal,
      frequency: frequency,
      lifecycleState: lifecycleState,
      firstSeenDate: transactions.first.date,
      createdAt: DateTime.now(),
      lastChargedDate: latestTransaction.date,
      priceHistoryJson: jsonEncode(priceHistory),
      cycleHistoryJson: jsonEncode(cycleHistory),
      frequencyConsistency: consistency.round(),
      detectionSource: SubscriptionDetectionSource.pattern,
      isTrial: isTrial,
      chargeCount: transactions.length,
      averageDaysBetweenCharges: avgDays,
      currency: latestTransaction.currency,
      userConfirmed: false,
      isZombie: isZombie,
      zombieReason: zombieReason,
      lastPriceHikePercent: priceHikePercent,
    );

    if (_categorizationService != null) {
      subscription.categoryId = await _categorizationService.categorizeMerchant(merchant);
    }

    return subscription;
  }

  /// Calculate consistency score (0-100)
  int _calculateConsistency(List<int> daysBetween, double average) {
    if (daysBetween.isEmpty) return 0;

    // Calculate standard deviation
    final variance = daysBetween.map((days) {
      final diff = days - average;
      return diff * diff;
    }).reduce((a, b) => a + b) / daysBetween.length;

    final stdDev = math.sqrt(variance);

    // Convert to consistency score (lower stdDev = higher consistency)
    // If stdDev is 0, consistency is 100
    // If stdDev is > average/2, consistency is low
    final maxStdDev = average / 2;
    final consistency = 100 - ((stdDev / maxStdDev) * 100).clamp(0, 100);

    return consistency.round();
  }

  /// Determine subscription frequency from average days
  SubscriptionFrequency _determineFrequency(double avgDays) {
    if (avgDays >= 6 && avgDays <= 8) return SubscriptionFrequency.weekly;
    if (avgDays >= 13 && avgDays <= 15) return SubscriptionFrequency.biweekly;
    if (avgDays >= 28 && avgDays <= 32) return SubscriptionFrequency.monthly;
    if (avgDays >= 88 && avgDays <= 95) return SubscriptionFrequency.quarterly;
    if (avgDays >= 178 && avgDays <= 185) return SubscriptionFrequency.semiannual;
    if (avgDays >= 360 && avgDays <= 370) return SubscriptionFrequency.yearly;

    return SubscriptionFrequency.unknown;
  }

  /// Determine lifecycle state
  SubscriptionLifecycleState _determineLifecycleState(
    DateTime lastCharge,
    double avgDays,
  ) {
    final daysSinceLastCharge = DateTime.now().difference(lastCharge).inDays;

    // If last charge was very recent, it's active
    if (daysSinceLastCharge <= avgDays * 1.5) {
      return SubscriptionLifecycleState.active;
    }

    // If it's been 2x the normal cycle, it's paused
    if (daysSinceLastCharge <= avgDays * 2.5) {
      return SubscriptionLifecycleState.paused;
    }

    // Otherwise it's ended
    return SubscriptionLifecycleState.ended;
  }

  /// Detect if subscription is in trial period
  bool _detectTrial(List<TransactionModel> transactions, List<int> daysBetween) {
    // Trial detection: first charge is significantly different from others
    if (transactions.length < 2) return false;

    final firstAmount = transactions.first.amount;
    final secondAmount = transactions[1].amount;

    // If first charge is very small or zero, might be trial
    if (firstAmount < secondAmount * 0.1) return true;

    return false;
  }

  /// Build price history
  List<Map<String, dynamic>> _buildPriceHistory(List<TransactionModel> transactions) {
    final history = <Map<String, dynamic>>[];
    double? lastAmount;

    for (var transaction in transactions) {
      if (lastAmount == null || transaction.amount != lastAmount) {
        history.add({
          'date': transaction.date.toIso8601String(),
          'amount': transaction.amount,
        });
        lastAmount = transaction.amount;
      }
    }

    return history;
  }

  /// Build billing cycle history
  List<Map<String, dynamic>> _buildCycleHistory(
    List<int> daysBetween,
    List<TransactionModel> transactions,
  ) {
    final history = <Map<String, dynamic>>[];
    SubscriptionFrequency? lastFrequency;

    for (var i = 0; i < daysBetween.length; i++) {
      final frequency = _determineFrequency(daysBetween[i].toDouble());
      if (lastFrequency == null || frequency != lastFrequency) {
        history.add({
          'date': transactions[i + 1].date.toIso8601String(),
          'frequency': frequency.toString(),
          'days': daysBetween[i],
        });
        lastFrequency = frequency;
      }
    }

    return history;
  }

  /// Update subscription lifecycle states
  Future<void> updateLifecycleStates() async {
    final subscriptions = await _isar.subscriptionModels.where().findAll();

    await _isar.writeTxn(() async {
      for (var subscription in subscriptions) {
        final newState = _determineLifecycleState(
          subscription.lastChargedDate ?? subscription.firstSeenDate,
          subscription.averageDaysBetweenCharges ?? 30,
        );

        if (newState != subscription.lifecycleState) {
          subscription.lifecycleState = newState;
          subscription.updatedAt = DateTime.now();
          await _isar.subscriptionModels.put(subscription);
          
          _logger.info(
            'Updated ${subscription.serviceName} lifecycle: ${newState.toString()}',
          );
        }
      }
    });
  }

  /// Detect price changes for a subscription
  Future<List<PriceChange>> detectPriceChanges(int subscriptionId) async {
    final subscription = await _isar.subscriptionModels.get(subscriptionId);
    if (subscription == null) return [];

    if (subscription.priceHistoryJson == null) return [];

    final history = (jsonDecode(subscription.priceHistoryJson!) as List)
        .cast<Map<String, dynamic>>();

    final changes = <PriceChange>[];
    for (var i = 1; i < history.length; i++) {
      final prev = history[i - 1];
      final curr = history[i];

      final prevAmount = (prev['amount'] as num).toDouble();
      final currAmount = (curr['amount'] as num).toDouble();
      final changePercent = ((currAmount - prevAmount) / prevAmount) * 100;

      changes.add(PriceChange(
        date: DateTime.parse(curr['date'] as String),
        oldAmount: prevAmount,
        newAmount: currAmount,
        changePercent: changePercent,
      ));
    }

    return changes;
  }

  /// Detect billing cycle changes
  Future<List<CycleChange>> detectCycleChanges(int subscriptionId) async {
    final subscription = await _isar.subscriptionModels.get(subscriptionId);
    if (subscription == null) return [];

    if (subscription.cycleHistoryJson == null) return [];

    final history = (jsonDecode(subscription.cycleHistoryJson!) as List)
        .cast<Map<String, dynamic>>();

    final changes = <CycleChange>[];
    for (var i = 1; i < history.length; i++) {
      final prev = history[i - 1];
      final curr = history[i];

      changes.add(CycleChange(
        date: DateTime.parse(curr['date'] as String),
        oldFrequency: _parseFrequency(prev['frequency'] as String),
        newFrequency: _parseFrequency(curr['frequency'] as String),
      ));
    }

    return changes;
  }

  SubscriptionFrequency _parseFrequency(String freqStr) {
    return SubscriptionFrequency.values.firstWhere(
      (f) => f.toString() == freqStr,
      orElse: () => SubscriptionFrequency.unknown,
    );
  }

  /// Get subscription statistics
  Future<Map<String, dynamic>> getStatistics() async {
    final allSubscriptions = await _isar.subscriptionModels.where().findAll();

    final active = allSubscriptions
        .where((s) => s.lifecycleState == SubscriptionLifecycleState.active)
        .length;
    final trial = allSubscriptions
        .where((s) => s.lifecycleState == SubscriptionLifecycleState.trial)
        .length;
    final paused = allSubscriptions
        .where((s) => s.lifecycleState == SubscriptionLifecycleState.paused)
        .length;
    final ended = allSubscriptions
        .where((s) => s.lifecycleState == SubscriptionLifecycleState.ended)
        .length;

    final totalMonthlySpend = allSubscriptions
        .where((s) => s.lifecycleState == SubscriptionLifecycleState.active)
        .map((s) => _convertToMonthly(s.amount, s.frequency))
        .fold<double>(0, (sum, amount) => sum + amount);

    return {
      'total': allSubscriptions.length,
      'active': active,
      'trial': trial,
      'paused': paused,
      'ended': ended,
      'totalMonthlySpend': totalMonthlySpend,
    };
  }

  double _convertToMonthly(double amount, SubscriptionFrequency frequency) {
    switch (frequency) {
      case SubscriptionFrequency.weekly:
        return amount * 4.33;
      case SubscriptionFrequency.biweekly:
        return amount * 2.17;
      case SubscriptionFrequency.monthly:
        return amount;
      case SubscriptionFrequency.quarterly:
        return amount / 3;
      case SubscriptionFrequency.semiannual:
        return amount / 6;
      case SubscriptionFrequency.yearly:
        return amount / 12;
      case SubscriptionFrequency.unknown:
        return 0;
    }
  }
}

class PriceChange {
  final DateTime date;
  final double oldAmount;
  final double newAmount;
  final double changePercent;

  PriceChange({
    required this.date,
    required this.oldAmount,
    required this.newAmount,
    required this.changePercent,
  });
}

class CycleChange {
  final DateTime date;
  final SubscriptionFrequency oldFrequency;
  final SubscriptionFrequency newFrequency;

  CycleChange({
    required this.date,
    required this.oldFrequency,
    required this.newFrequency,
  });
}
