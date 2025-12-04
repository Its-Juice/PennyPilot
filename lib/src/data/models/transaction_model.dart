import 'package:isar/isar.dart';

part 'transaction_model.g.dart';

@collection
class TransactionModel {
  Id id = Isar.autoIncrement;

  late String merchantName;

  late double amount;

  late DateTime date;

  late String category;

  bool isSubscription = false;

  String? originalEmailId; // ID of the email this was parsed from

  @Index()
  late DateTime createdAt;
}
