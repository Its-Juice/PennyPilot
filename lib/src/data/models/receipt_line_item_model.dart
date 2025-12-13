import 'package:isar/isar.dart';

part 'receipt_line_item_model.g.dart';

@collection
class ReceiptLineItemModel {
  Id id = Isar.autoIncrement;

  /// Reference to parent transaction
  late int transactionId;

  /// Item description
  late String description;

  /// Item amount
  late double amount;

  /// Type of line item
  @Enumerated(EnumType.ordinal)
  late LineItemType type;

  /// Order in the receipt
  late int order;

  @Index()
  late DateTime createdAt;
}

enum LineItemType {
  item,      // Regular purchase item
  tax,       // Tax amount
  discount,  // Discount or coupon
  fee,       // Service fee, delivery fee, etc.
  tip,       // Gratuity
  subtotal,  // Subtotal before tax
  total,     // Final total
}
