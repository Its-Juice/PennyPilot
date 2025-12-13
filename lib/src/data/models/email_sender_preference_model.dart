import 'package:isar/isar.dart';

part 'email_sender_preference_model.g.dart';

@collection
class EmailSenderPreferenceModel {
  Id id = Isar.autoIncrement;

  /// Email address of the sender
  @Index(unique: true)
  late String senderEmail;

  /// Domain of the sender (e.g., "amazon.com")
  @Index()
  late String senderDomain;

  /// Display name of the sender
  String? senderDisplayName;

  /// Whether to scan emails from this sender
  late bool scanEnabled;

  /// Last time we scanned emails from this sender
  DateTime? lastScannedDate;

  /// Total emails processed from this sender
  late int totalEmailsProcessed;

  /// Total transactions extracted from this sender
  late int totalTransactionsExtracted;

  /// Average confidence score for this sender's emails
  double? averageConfidence;

  /// Whether this sender is recognized as a merchant
  late bool isRecognizedMerchant;

  /// User notes about this sender
  String? userNotes;

  @Index()
  late DateTime createdAt;

  DateTime? updatedAt;
}
