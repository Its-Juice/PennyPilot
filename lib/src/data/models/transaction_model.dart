import 'package:isar/isar.dart';

part 'transaction_model.g.dart';

@collection
class TransactionModel {
  Id id = Isar.autoIncrement;

  /// Normalized merchant name (clean, standardized)
  @Index()
  late String merchantName;

  /// Raw merchant name as it appeared in the source
  String? rawMerchantName;

  /// Total transaction amount
  late double amount;

  /// Subtotal before tax (if available)
  double? subtotalAmount;

  /// Tax amount (if available)
  double? taxAmount;

  /// Discount amount (if available)
  double? discountAmount;

  /// Tip amount (if available)
  double? tipAmount;

  /// Transaction date
  @Index()
  late DateTime date;

  /// Category name (deprecated - use categoryId instead)
  String? category;

  /// Category ID reference
  int? categoryId;

  /// Whether this is part of a subscription
  bool isSubscription = false;

  /// Reference to subscription if applicable
  int? subscriptionId;

  /// Transaction type (income or expense)
  @Enumerated(EnumType.ordinal)
  TransactionKind kind = TransactionKind.expense;

  /// Origin of the transaction
  @Enumerated(EnumType.ordinal)
  TransactionOrigin origin = TransactionOrigin.emailDetected;

  /// Whether this is a recurring transaction
  bool isRecurring = false;
  
  /// Overall extraction confidence level
  @Enumerated(EnumType.ordinal)
  ConfidenceLevel extractionConfidence = ConfidenceLevel.low;

  /// Whether line items are available
  bool hasLineItems = false;

  /// ID of the email this was parsed from
  String? originalEmailId;

  /// Currency code (ISO 4217)
  String currency = 'USD';

  /// User notes
  String? notes;

  /// Whether user has manually verified this transaction
  bool userVerified = false;

  /// Whether this transaction has splits
  bool hasSplits = false;

  /// Whether this transaction has been manually edited by the user
  bool isManuallyEdited = false;

  /// Timestamp of when the transaction was manually edited
  DateTime? manualEditTimestamp;

  @Index()
  late DateTime createdAt;

  DateTime? updatedAt;
}

enum ConfidenceLevel {
  high,    // 90-100% confidence
  medium,  // 60-89% confidence
  low,     // Below 60% confidence
}

enum TransactionKind {
  income,
  expense,
}

enum TransactionOrigin {
  emailDetected,
  manual,
  imported,
}

