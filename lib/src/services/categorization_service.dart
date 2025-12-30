import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:pennypilot/src/data/models/category_model.dart';
import 'package:pennypilot/src/data/defaults/default_categories.dart';

class CategorizationService {
  final Isar _isar;
  final _logger = Logger('CategorizationService');

  CategorizationService(this._isar);

  /// Initialize default categories in the database
  Future<void> initializeDefaultCategories() async {
    final count = await _isar.categoryModels.count();
    if (count > 0) return;

    await _isar.writeTxn(() async {
      int order = 0;
      for (var catData in DefaultCategories.categories) {
        final category = CategoryModel()
          ..name = catData.name
          ..icon = catData.icon
          ..color = catData.color
          ..isSystem = true
          ..order = order++
          ..isActive = true
          ..transactionCount = 0
          ..createdAt = DateTime.now();

        await _isar.categoryModels.put(category);

        // Also seed mappings for default keywords
        for (var keyword in catData.keywords) {
          final mapping = MerchantCategoryMappingModel()
            ..merchantName = keyword
            ..categoryId = category.id
            ..isAutomatic = true
            ..confidence = 90
            ..userConfirmed = false
            ..createdAt = DateTime.now();
          
          await _isar.merchantCategoryMappingModels.put(mapping);
        }
      }
    });

    _logger.info('Initialized ${DefaultCategories.categories.length} default categories.');
  }

  /// Categorize a merchant name
  Future<int?> categorizeMerchant(String merchantName) async {
    final merchantUpper = merchantName.toUpperCase();

    // 1. Check for exact mapping first
    final exactMapping = await _isar.merchantCategoryMappingModels
        .filter()
        .merchantNameEqualTo(merchantName, caseSensitive: false)
        .findFirst();
    
    if (exactMapping != null) return exactMapping.categoryId;

    // 2. Check for keyword matches (substring)
    // We get all mappings and check if the merchant name contains any of the mapped names
    final allMappings = await _isar.merchantCategoryMappingModels.where().findAll();
    
    MerchantCategoryMappingModel? bestMatch;
    for (var mapping in allMappings) {
      if (merchantUpper.contains(mapping.merchantName.toUpperCase())) {
        // If we find a match, we prefer mappings with more specific (longer) names
        if (bestMatch == null || mapping.merchantName.length > bestMatch.merchantName.length) {
          bestMatch = mapping;
        }
      }
    }

    if (bestMatch != null) return bestMatch.categoryId;

    // 3. Fallback: Search in default categories keywords directly (if not indexed)
    // Actually, we already indexed them in step 1.

    return null;
  }

  /// Update mapping after user manually changes a transaction's category
  Future<void> updateUserMapping(String merchantName, int categoryId) async {
    await _isar.writeTxn(() async {
      final existing = await _isar.merchantCategoryMappingModels
          .filter()
          .merchantNameEqualTo(merchantName, caseSensitive: false)
          .findFirst();

      final mapping = existing ?? MerchantCategoryMappingModel();
      mapping.merchantName = merchantName;
      mapping.categoryId = categoryId;
      mapping.isAutomatic = false;
      mapping.userConfirmed = true;
      mapping.updatedAt = DateTime.now();
      if (existing == null) mapping.createdAt = DateTime.now();

      await _isar.merchantCategoryMappingModels.put(mapping);
    });
  }
}
