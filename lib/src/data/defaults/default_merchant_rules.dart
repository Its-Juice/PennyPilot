import 'package:pennypilot/src/data/models/merchant_normalization_rule_model.dart';

/// Default merchant normalization rules
/// These are common merchant name variations that should be normalized
class DefaultMerchantRules {
  static final List<MerchantNormalizationRuleData> rules = [
    // Amazon
    MerchantNormalizationRuleData(
      rawName: 'AMZN MKTP',
      normalizedName: 'Amazon',
      matchType: MatchType.startsWith,
    ),
    MerchantNormalizationRuleData(
      rawName: 'AMAZON.COM',
      normalizedName: 'Amazon',
      matchType: MatchType.startsWith,
    ),
    MerchantNormalizationRuleData(
      rawName: 'Amazon EU',
      normalizedName: 'Amazon',
      matchType: MatchType.startsWith,
    ),
    MerchantNormalizationRuleData(
      rawName: 'Amazon Prime',
      normalizedName: 'Amazon Prime',
      matchType: MatchType.exact,
    ),
    MerchantNormalizationRuleData(
      rawName: 'PRIME VIDEO',
      normalizedName: 'Amazon Prime Video',
      matchType: MatchType.contains,
    ),

    // Netflix
    MerchantNormalizationRuleData(
      rawName: 'NETFLIX',
      normalizedName: 'Netflix',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'NETFLIX.COM',
      normalizedName: 'Netflix',
      matchType: MatchType.contains,
    ),

    // Spotify
    MerchantNormalizationRuleData(
      rawName: 'SPOTIFY',
      normalizedName: 'Spotify',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'Spotify USA',
      normalizedName: 'Spotify',
      matchType: MatchType.startsWith,
    ),

    // Apple
    MerchantNormalizationRuleData(
      rawName: 'APPLE.COM/BILL',
      normalizedName: 'Apple',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'APL*APPLE',
      normalizedName: 'Apple',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'ITUNES',
      normalizedName: 'Apple iTunes',
      matchType: MatchType.contains,
    ),

    // Google
    MerchantNormalizationRuleData(
      rawName: 'GOOGLE*',
      normalizedName: 'Google',
      matchType: MatchType.startsWith,
    ),
    MerchantNormalizationRuleData(
      rawName: 'GOOGLE STORAGE',
      normalizedName: 'Google One',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'GOOGLE PLAY',
      normalizedName: 'Google Play',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'YOUTUBE PREMIUM',
      normalizedName: 'YouTube Premium',
      matchType: MatchType.contains,
    ),

    // Microsoft
    MerchantNormalizationRuleData(
      rawName: 'MICROSOFT*',
      normalizedName: 'Microsoft',
      matchType: MatchType.startsWith,
    ),
    MerchantNormalizationRuleData(
      rawName: 'MSFT*',
      normalizedName: 'Microsoft',
      matchType: MatchType.startsWith,
    ),
    MerchantNormalizationRuleData(
      rawName: 'XBOX',
      normalizedName: 'Xbox',
      matchType: MatchType.contains,
    ),

    // Adobe
    MerchantNormalizationRuleData(
      rawName: 'ADOBE',
      normalizedName: 'Adobe',
      matchType: MatchType.contains,
    ),

    // Dropbox
    MerchantNormalizationRuleData(
      rawName: 'DROPBOX',
      normalizedName: 'Dropbox',
      matchType: MatchType.contains,
    ),

    // PayPal
    MerchantNormalizationRuleData(
      rawName: 'PAYPAL *',
      normalizedName: 'PayPal',
      matchType: MatchType.startsWith,
    ),

    // Uber
    MerchantNormalizationRuleData(
      rawName: 'UBER *',
      normalizedName: 'Uber',
      matchType: MatchType.startsWith,
    ),
    MerchantNormalizationRuleData(
      rawName: 'UBER EATS',
      normalizedName: 'Uber Eats',
      matchType: MatchType.contains,
    ),

    // Starbucks
    MerchantNormalizationRuleData(
      rawName: 'STARBUCKS',
      normalizedName: 'Starbucks',
      matchType: MatchType.contains,
    ),

    // McDonald's
    MerchantNormalizationRuleData(
      rawName: "MCDONALD'S",
      normalizedName: "McDonald's",
      matchType: MatchType.contains,
    ),

    // Walmart
    MerchantNormalizationRuleData(
      rawName: 'WALMART',
      normalizedName: 'Walmart',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'WAL-MART',
      normalizedName: 'Walmart',
      matchType: MatchType.contains,
    ),

    // Target
    MerchantNormalizationRuleData(
      rawName: 'TARGET',
      normalizedName: 'Target',
      matchType: MatchType.contains,
    ),

    // Costco
    MerchantNormalizationRuleData(
      rawName: 'COSTCO',
      normalizedName: 'Costco',
      matchType: MatchType.contains,
    ),

    // Whole Foods
    MerchantNormalizationRuleData(
      rawName: 'WHOLE FOODS',
      normalizedName: 'Whole Foods',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'WFM',
      normalizedName: 'Whole Foods',
      matchType: MatchType.exact,
    ),

    // Trader Joe's
    MerchantNormalizationRuleData(
      rawName: "TRADER JOE'S",
      normalizedName: "Trader Joe's",
      matchType: MatchType.contains,
    ),

    // CVS
    MerchantNormalizationRuleData(
      rawName: 'CVS',
      normalizedName: 'CVS Pharmacy',
      matchType: MatchType.contains,
    ),

    // Walgreens
    MerchantNormalizationRuleData(
      rawName: 'WALGREENS',
      normalizedName: 'Walgreens',
      matchType: MatchType.contains,
    ),

    // Gas Stations
    MerchantNormalizationRuleData(
      rawName: 'SHELL OIL',
      normalizedName: 'Shell',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'CHEVRON',
      normalizedName: 'Chevron',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'EXXON',
      normalizedName: 'Exxon',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'BP#',
      normalizedName: 'BP',
      matchType: MatchType.startsWith,
    ),

    // Airlines
    MerchantNormalizationRuleData(
      rawName: 'SOUTHWEST AIR',
      normalizedName: 'Southwest Airlines',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'DELTA AIR',
      normalizedName: 'Delta Airlines',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'AMERICAN AIR',
      normalizedName: 'American Airlines',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'UNITED AIRLINES',
      normalizedName: 'United Airlines',
      matchType: MatchType.contains,
    ),

    // Hotels
    MerchantNormalizationRuleData(
      rawName: 'MARRIOTT',
      normalizedName: 'Marriott',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'HILTON',
      normalizedName: 'Hilton',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'AIRBNB',
      normalizedName: 'Airbnb',
      matchType: MatchType.contains,
    ),

    // Utilities (common patterns)
    MerchantNormalizationRuleData(
      rawName: 'ELECTRIC',
      normalizedName: 'Electric Utility',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'WATER DEPT',
      normalizedName: 'Water Utility',
      matchType: MatchType.contains,
    ),
    MerchantNormalizationRuleData(
      rawName: 'GAS COMPANY',
      normalizedName: 'Gas Utility',
      matchType: MatchType.contains,
    ),
  ];
}

/// Data class for merchant normalization rules
class MerchantNormalizationRuleData {
  final String rawName;
  final String normalizedName;
  final MatchType matchType;
  final int confidence;

  MerchantNormalizationRuleData({
    required this.rawName,
    required this.normalizedName,
    required this.matchType,
    this.confidence = 95,
  });
}
