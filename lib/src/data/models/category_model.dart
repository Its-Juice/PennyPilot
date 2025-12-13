import 'package:isar/isar.dart';

part 'category_model.g.dart';

@collection
class CategoryModel {
  Id id = Isar.autoIncrement;

  /// Category name
  @Index()
  late String name;

  /// Parent category ID (null for top-level categories)
  int? parentCategoryId;

  /// Icon identifier (Material Icons name or emoji)
  late String icon;

  /// Color in hex format (#RRGGBB)
  late String color;

  /// Whether this is a system-defined category
  late bool isSystem;

  /// Display order
  late int order;

  /// Whether this category is active
  late bool isActive;

  /// Number of transactions in this category
  late int transactionCount;

  @Index()
  late DateTime createdAt;

  DateTime? updatedAt;
}

@collection
class MerchantCategoryMappingModel {
  Id id = Isar.autoIncrement;

  /// Normalized merchant name
  @Index()
  late String merchantName;

  /// Category ID
  @Index()
  late int categoryId;

  /// Whether this mapping was automatically created
  late bool isAutomatic;

  /// Confidence score if automatic (0-100)
  int? confidence;

  /// Whether user has confirmed this mapping
  late bool userConfirmed;

  @Index()
  late DateTime createdAt;

  DateTime? updatedAt;
}
