import 'package:isar/isar.dart';

part 'budget_model.g.dart';

@collection
class BudgetModel {
  Id id = Isar.autoIncrement;

  /// Category ID this budget applies to (null for total budget)
  @Index(unique: true)
  int? categoryId;

  /// Monthly limit amount
  late double limitAmount;

  /// Currency code
  String currency = 'USD';

  /// Whether this budget is active
  bool isActive = true;

  @Index()
  late DateTime createdAt;

  DateTime? updatedAt;
}

@collection
class SpendingSplitModel {
  Id id = Isar.autoIncrement;

  /// Parent transaction ID
  @Index()
  late int transactionId;

  /// Amount for this split
  late double amount;

  /// Participant name (e.g., 'Roommate', 'Personal', 'Work')
  late String participant;

  /// Whether this split has been reimbursed
  bool isReimbursed = false;

  /// Notes for the split
  String? notes;

  @Index()
  late DateTime createdAt;
}
