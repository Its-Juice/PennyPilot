import 'package:isar/isar.dart';

part 'extraction_metadata_model.g.dart';

@collection
class ExtractionMetadataModel {
  Id id = Isar.autoIncrement;

  /// Reference to parent transaction
  @Index(unique: true)
  late int transactionId;

  /// Overall confidence in the extraction
  @Enumerated(EnumType.ordinal)
  late ConfidenceLevel overallConfidence;

  /// Confidence in merchant name extraction
  @Enumerated(EnumType.ordinal)
  late ConfidenceLevel merchantConfidence;

  /// Confidence in amount extraction
  @Enumerated(EnumType.ordinal)
  late ConfidenceLevel amountConfidence;

  /// Confidence in date extraction
  @Enumerated(EnumType.ordinal)
  late ConfidenceLevel dateConfidence;

  /// Whether line items were detected
  late bool hasLineItems;

  /// Number of line items found
  late int lineItemCount;

  /// Raw email subject (for reference)
  String? emailSubject;

  /// Raw email sender
  String? emailSender;

  /// Extraction method used
  String? extractionMethod;

  /// Any notes or warnings about the extraction
  String? notes;

  /// Whether user has manually verified this
  late bool userVerified;

  @Index()
  late DateTime extractedAt;
}

enum ConfidenceLevel {
  high,    // 90-100% confidence
  medium,  // 60-89% confidence
  low,     // Below 60% confidence
}
