import 'package:isar/isar.dart';

part 'subscription_model.g.dart';

enum SubscriptionAnomaly {
  priceHike, // Price went up
  priceDrop, // Price went down
  zombie, // Active but no recent transactions
}

@collection
class SubscriptionModel {
  Id id;

  /// Service/merchant name
  @Index()
  String serviceName;

  /// Current amount
  double amount;

  /// Next expected renewal date
  DateTime nextRenewalDate;

  /// Billing frequency
  @Enumerated(EnumType.ordinal)
  SubscriptionFrequency frequency;

  /// Lifecycle state
  @Enumerated(EnumType.ordinal)
  SubscriptionLifecycleState lifecycleState;

  /// Category ID reference
  int? categoryId;

  /// Category name (deprecated - use categoryId)
  String? category;

  /// First time this subscription was detected
  @Index()
  DateTime firstSeenDate;

  /// Last time we saw a charge for this subscription
  DateTime? lastChargedDate;

  /// Price history (JSON encoded list of {date, amount})
  String? priceHistoryJson;

  /// Billing cycle history (JSON encoded list of {date, frequency})
  String? cycleHistoryJson;

  /// Frequency consistency score (0-100)
  /// 100 = perfectly consistent, 0 = highly irregular
  int frequencyConsistency;

  /// How this subscription was detected
  @Enumerated(EnumType.ordinal)
  SubscriptionDetectionSource detectionSource;

  /// Detected anomalies
  List<String> anomalies;

  /// Whether this is currently in a trial period
  bool isTrial;

  /// Trial end date (if applicable)
  DateTime? trialEndDate;

  /// Number of charges detected for this subscription
  int chargeCount;

  /// Average days between charges
  double? averageDaysBetweenCharges;

  /// Currency code
  String currency;

  /// User notes
  String? notes;

  /// Whether user has confirmed this is a subscription
  bool userConfirmed;

  /// Whether this is flagged as a "Zombie" subscription (unused or price hiked)
  bool isZombie;

  /// Reason for zombie flagging
  String? zombieReason;

  /// Last detected price hike percentage
  double? lastPriceHikePercent;

  @Index()
  DateTime createdAt;

  DateTime? updatedAt;

  SubscriptionModel({
    this.id = Isar.autoIncrement,
    required this.serviceName,
    required this.amount,
    required this.nextRenewalDate,
    this.frequency = SubscriptionFrequency.unknown,
    this.lifecycleState = SubscriptionLifecycleState.active,
    this.categoryId,
    this.category,
    required this.firstSeenDate,
    this.lastChargedDate,
    this.priceHistoryJson,
    this.cycleHistoryJson,
    this.frequencyConsistency = 100,
    this.detectionSource = SubscriptionDetectionSource.manual,
    List<String>? anomalies,
    this.isTrial = false,
    this.trialEndDate,
    this.chargeCount = 0,
    this.averageDaysBetweenCharges,
    this.currency = 'USD',
    this.notes,
    this.userConfirmed = false,
    this.isZombie = false,
    this.zombieReason,
    this.lastPriceHikePercent,
    required this.createdAt,
    this.updatedAt,
  }) : anomalies = anomalies ?? [];
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
  active, // Currently active, recent charges
  trial, // In trial period
  paused, // No recent charges but not ended
  ended, // No charges for extended period
  cancelled, // User marked as cancelled
}

enum SubscriptionDetectionSource {
  email, // Detected from email patterns
  manual, // User manually added
  pattern, // Detected from transaction patterns
  keyword, // Detected from merchant keywords
}
