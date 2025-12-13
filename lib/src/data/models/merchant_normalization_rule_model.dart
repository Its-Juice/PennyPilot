import 'package:isar/isar.dart';

part 'merchant_normalization_rule_model.g.dart';

@collection
class MerchantNormalizationRuleModel {
  Id id = Isar.autoIncrement;

  /// Raw merchant name as it appears in receipts/statements
  @Index()
  late String rawName;

  /// Normalized/clean merchant name
  late String normalizedName;

  /// Confidence score (0-100)
  late int confidence;

  /// Whether this rule was created by the user
  late bool isUserDefined;

  /// Whether this is a system default rule
  late bool isSystemRule;

  /// Number of times this rule has been applied
  late int usageCount;

  /// Pattern matching type
  @Enumerated(EnumType.ordinal)
  late MatchType matchType;

  @Index()
  late DateTime createdAt;

  DateTime? lastUsedAt;
}

enum MatchType {
  exact,      // Exact string match
  contains,   // Contains substring
  startsWith, // Starts with pattern
  regex,      // Regular expression
}
