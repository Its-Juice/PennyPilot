import 'package:isar/isar.dart';

part 'subscription_model.g.dart';

@collection
class SubscriptionModel {
  Id id = Isar.autoIncrement;

  /// Service/merchant name
  @Index()
  late String serviceName;

  /// Current amount
  late double amount;

  /// Next expected renewal date
  late DateTime nextRenewalDate;

  /// Billing frequency
  @Enumerated(EnumType.ordinal)
  late SubscriptionFrequency frequency;

  /// Lifecycle state
  @Enumerated(EnumType.ordinal)
  late SubscriptionLifecycleState lifecycleState;

  /// Category ID reference
  int? categoryId;

  /// Category name (deprecated - use categoryId)
  String? category;

  /// First time this subscription was detected
  @Index()
  late DateTime firstSeenDate;

  /// Last time we saw a charge for this subscription
  DateTime? lastChargedDate;

  /// Price history (JSON encoded list of {date, amount})
  String? priceHistoryJson;

  /// Billing cycle history (JSON encoded list of {date, frequency})
  String? cycleHistoryJson;

  /// Frequency consistency score (0-100)
  /// 100 = perfectly consistent, 0 = highly irregular
  late int frequencyConsistency;

  /// How this subscription was detected
  @Enumerated(EnumType.ordinal)
  late SubscriptionDetectionSource detectionSource;

  /// Whether this is currently in a trial period
  bool isTrial = false;

  /// Trial end date (if applicable)
  DateTime? trialEndDate;

  /// Number of charges detected for this subscription
  late int chargeCount;

  /// Average days between charges
  double? averageDaysBetweenCharges;

  /// Currency code
  String currency = 'USD';

  /// User notes
  String? notes;

  /// Whether user has confirmed this is a subscription
  bool userConfirmed = false;

  @Index()
  late DateTime createdAt;

  DateTime? updatedAt;
}

enum SubscriptionFrequency {
  weekly,
  biweekly,
  monthly,
  quarterly,
  semiannual,
  yearly,
  unknown,
}

enum SubscriptionLifecycleState {
  active,      // Currently active, recent charges
  trial,       // In trial period
  paused,      // No recent charges but not ended
  ended,       // No charges for extended period
  cancelled,   // User marked as cancelled
}

enum SubscriptionDetectionSource {
  email,       // Detected from email patterns
  manual,      // User manually added
  pattern,     // Detected from transaction patterns
  keyword,     // Detected from merchant keywords
}

