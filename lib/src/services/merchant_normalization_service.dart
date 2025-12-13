import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:pennypilot/src/data/models/merchant_normalization_rule_model.dart';
import 'package:pennypilot/src/data/defaults/default_merchant_rules.dart';

class MerchantNormalizationService {
  final Isar _isar;
  final _logger = Logger('MerchantNormalizationService');
  bool _defaultRulesLoaded = false;

  MerchantNormalizationService(this._isar);

  /// Initialize default merchant normalization rules
  Future<void> initializeDefaultRules() async {
    if (_defaultRulesLoaded) return;

    final existingRulesCount = await _isar.merchantNormalizationRuleModels
        .filter()
        .isSystemRuleEqualTo(true)
        .count();

    if (existingRulesCount > 0) {
      _defaultRulesLoaded = true;
      _logger.info('Default rules already loaded');
      return;
    }

    await _isar.writeTxn(() async {
      for (var ruleData in DefaultMerchantRules.rules) {
        final rule = MerchantNormalizationRuleModel()
          ..rawName = ruleData.rawName
          ..normalizedName = ruleData.normalizedName
          ..matchType = ruleData.matchType
          ..confidence = ruleData.confidence
          ..isUserDefined = false
          ..isSystemRule = true
          ..usageCount = 0
          ..createdAt = DateTime.now();

        await _isar.merchantNormalizationRuleModels.put(rule);
      }
    });

    _defaultRulesLoaded = true;
    _logger.info('Loaded ${DefaultMerchantRules.rules.length} default merchant rules');
  }

  /// Normalize a merchant name using available rules
  Future<String> normalizeMerchantName(String rawName) async {
    if (rawName.trim().isEmpty) return rawName;

    final cleanedRaw = rawName.trim();

    // Try to find a matching rule
    final rules = await _isar.merchantNormalizationRuleModels
        .where()
        .sortByConfidence()
        .findAll();

    for (var rule in rules.reversed) {
      // Reversed to get highest confidence first
      if (_matchesRule(cleanedRaw, rule)) {
        // Update usage count
        await _isar.writeTxn(() async {
          rule.usageCount++;
          rule.lastUsedAt = DateTime.now();
          await _isar.merchantNormalizationRuleModels.put(rule);
        });

        _logger.fine('Normalized "$rawName" to "${rule.normalizedName}"');
        return rule.normalizedName;
      }
    }

    // No rule found, return cleaned raw name
    return _cleanMerchantName(cleanedRaw);
  }

  /// Check if a raw name matches a rule
  bool _matchesRule(String rawName, MerchantNormalizationRuleModel rule) {
    final rawUpper = rawName.toUpperCase();
    final ruleUpper = rule.rawName.toUpperCase();

    switch (rule.matchType) {
      case MatchType.exact:
        return rawUpper == ruleUpper;
      case MatchType.contains:
        return rawUpper.contains(ruleUpper);
      case MatchType.startsWith:
        return rawUpper.startsWith(ruleUpper);
      case MatchType.regex:
        try {
          final regex = RegExp(rule.rawName, caseSensitive: false);
          return regex.hasMatch(rawName);
        } catch (e) {
          _logger.warning('Invalid regex in rule: ${rule.rawName}');
          return false;
        }
    }
  }

  /// Clean merchant name (remove common prefixes, extra spaces, etc.)
  String _cleanMerchantName(String name) {
    var cleaned = name;

    // Remove common transaction prefixes
    final prefixes = [
      'SQ *',
      'TST* ',
      'POS ',
      'DEBIT CARD ',
      'CREDIT CARD ',
      'PURCHASE ',
    ];

    for (var prefix in prefixes) {
      if (cleaned.toUpperCase().startsWith(prefix.toUpperCase())) {
        cleaned = cleaned.substring(prefix.length);
      }
    }

    // Remove extra spaces
    cleaned = cleaned.replaceAll(RegExp(r'\s+'), ' ').trim();

    // Capitalize properly
    cleaned = _toTitleCase(cleaned);

    return cleaned;
  }

  /// Convert to title case
  String _toTitleCase(String text) {
    if (text.isEmpty) return text;
    
    // If already mixed case, keep it
    if (text != text.toUpperCase() && text != text.toLowerCase()) {
      return text;
    }

    // Otherwise convert to title case
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  /// Add a user-defined normalization rule
  Future<void> addUserRule({
    required String rawName,
    required String normalizedName,
    MatchType matchType = MatchType.exact,
  }) async {
    await _isar.writeTxn(() async {
      final rule = MerchantNormalizationRuleModel()
        ..rawName = rawName
        ..normalizedName = normalizedName
        ..matchType = matchType
        ..confidence = 100 // User rules have highest confidence
        ..isUserDefined = true
        ..isSystemRule = false
        ..usageCount = 0
        ..createdAt = DateTime.now();

      await _isar.merchantNormalizationRuleModels.put(rule);
    });

    _logger.info('Added user rule: "$rawName" -> "$normalizedName"');
  }

  /// Get all user-defined rules
  Future<List<MerchantNormalizationRuleModel>> getUserRules() async {
    return await _isar.merchantNormalizationRuleModels
        .filter()
        .isUserDefinedEqualTo(true)
        .findAll();
  }

  /// Delete a normalization rule
  Future<void> deleteRule(int ruleId) async {
    await _isar.writeTxn(() async {
      await _isar.merchantNormalizationRuleModels.delete(ruleId);
    });
    _logger.info('Deleted rule $ruleId');
  }

  /// Suggest normalization for a merchant name
  /// Returns a list of possible normalized names with confidence scores
  Future<List<NormalizationSuggestion>> suggestNormalization(String rawName) async {
    final suggestions = <NormalizationSuggestion>[];
    
    final rules = await _isar.merchantNormalizationRuleModels
        .where()
        .findAll();

    for (var rule in rules) {
      if (_matchesRule(rawName, rule)) {
        suggestions.add(NormalizationSuggestion(
          normalizedName: rule.normalizedName,
          confidence: rule.confidence,
          isUserDefined: rule.isUserDefined,
        ));
      }
    }

    // Sort by confidence
    suggestions.sort((a, b) => b.confidence.compareTo(a.confidence));

    return suggestions;
  }

  /// Get normalization statistics
  Future<Map<String, dynamic>> getStatistics() async {
    final totalRules = await _isar.merchantNormalizationRuleModels.count();
    final userRules = await _isar.merchantNormalizationRuleModels
        .filter()
        .isUserDefinedEqualTo(true)
        .count();
    final systemRules = await _isar.merchantNormalizationRuleModels
        .filter()
        .isSystemRuleEqualTo(true)
        .count();

    final mostUsedRules = await _isar.merchantNormalizationRuleModels
        .where()
        .sortByUsageCountDesc()
        .limit(10)
        .findAll();

    return {
      'totalRules': totalRules,
      'userRules': userRules,
      'systemRules': systemRules,
      'mostUsedRules': mostUsedRules,
    };
  }
}

class NormalizationSuggestion {
  final String normalizedName;
  final int confidence;
  final bool isUserDefined;

  NormalizationSuggestion({
    required this.normalizedName,
    required this.confidence,
    required this.isUserDefined,
  });
}
