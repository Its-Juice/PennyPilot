import 'package:isar/isar.dart';

part 'subscription_model.g.dart';

@collection
class SubscriptionModel {
  Id id = Isar.autoIncrement;

  late String serviceName;

  late double amount;

  late DateTime nextRenewalDate;

  @Enumerated(EnumType.ordinal)
  late SubscriptionFrequency frequency;

  String? category;
}

enum SubscriptionFrequency {
  monthly,
  yearly,
  weekly,
  unknown
}
