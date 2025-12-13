import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/models/receipt_line_item_model.dart';
import 'package:pennypilot/src/data/models/extraction_metadata_model.dart';
import 'package:pennypilot/src/services/merchant_normalization_service.dart';

class ReceiptExtractionService {
  final Isar _isar;
  final MerchantNormalizationService _merchantService;
  final _logger = Logger('ReceiptExtractionService');

  ReceiptExtractionService(this._isar, this._merchantService);

  /// Extract receipt data from email content
  Future<ExtractionResult> extractReceiptData({
    required String emailBody,
    required String emailSubject,
    required String emailSender,
    String? emailId,
  }) async {
    _logger.info('Extracting receipt from email: $emailSubject');

    final result = ExtractionResult();

    // Extract merchant name
    final merchantExtraction = _extractMerchant(emailSubject, emailSender, emailBody);
    result.rawMerchantName = merchantExtraction.name;
    result.merchantConfidence = merchantExtraction.confidence;

    // Normalize merchant name
    result.merchantName = await _merchantService.normalizeMerchantName(result.rawMerchantName);

    // Extract amounts
    final amountExtraction = _extractAmounts(emailBody, emailSubject);
    result.totalAmount = amountExtraction.total;
    result.subtotalAmount = amountExtraction.subtotal;
    result.taxAmount = amountExtraction.tax;
    result.discountAmount = amountExtraction.discount;
    result.tipAmount = amountExtraction.tip;
    result.amountConfidence = amountExtraction.confidence;

    // Extract date
    final dateExtraction = _extractDate(emailBody, emailSubject);
    result.date = dateExtraction.date;
    result.dateConfidence = dateExtraction.confidence;

    // Extract line items (optional)
    final lineItems = _extractLineItems(emailBody);
    result.lineItems = lineItems;
    result.hasLineItems = lineItems.isNotEmpty;

    // Calculate overall confidence
    result.overallConfidence = _calculateOverallConfidence(
      result.merchantConfidence,
      result.amountConfidence,
      result.dateConfidence,
    );

    result.emailSubject = emailSubject;
    result.emailSender = emailSender;
    result.emailId = emailId;

    return result;
  }

  /// Extract merchant name from email
  MerchantExtraction _extractMerchant(String subject, String sender, String body) {
    // Try to extract from sender email
    final senderMatch = RegExp(r'@([a-zA-Z0-9-]+)\.')
        .firstMatch(sender.toLowerCase());
    
    if (senderMatch != null) {
      final domain = senderMatch.group(1)!;
      // Common merchant domains
      if (!['gmail', 'yahoo', 'outlook', 'hotmail', 'icloud'].contains(domain)) {
        return MerchantExtraction(
          name: _capitalize(domain),
          confidence: ConfidenceLevel.medium,
        );
      }
    }

    // Try to extract from subject
    final subjectPatterns = [
      RegExp(r'receipt from (.+?)(?:\s|$)', caseSensitive: false),
      RegExp(r'your (.+?) order', caseSensitive: false),
      RegExp(r'thank you for shopping at (.+?)(?:\s|$)', caseSensitive: false),
      RegExp(r'order confirmation - (.+?)(?:\s|$)', caseSensitive: false),
    ];

    for (var pattern in subjectPatterns) {
      final match = pattern.firstMatch(subject);
      if (match != null && match.group(1) != null) {
        return MerchantExtraction(
          name: match.group(1)!.trim(),
          confidence: ConfidenceLevel.high,
        );
      }
    }

    // Fallback to sender display name
    final displayNameMatch = RegExp(r'^([^<]+)').firstMatch(sender);
    if (displayNameMatch != null) {
      return MerchantExtraction(
        name: displayNameMatch.group(1)!.trim(),
        confidence: ConfidenceLevel.low,
      );
    }

    return MerchantExtraction(
      name: 'Unknown Merchant',
      confidence: ConfidenceLevel.low,
    );
  }

  /// Extract amounts from email body
  AmountExtraction _extractAmounts(String body, String subject) {
    final extraction = AmountExtraction();

    // Look for total amount
    final totalPatterns = [
      RegExp(r'total:?\s*\$?([0-9,]+\.[0-9]{2})', caseSensitive: false),
      RegExp(r'amount:?\s*\$?([0-9,]+\.[0-9]{2})', caseSensitive: false),
      RegExp(r'grand total:?\s*\$?([0-9,]+\.[0-9]{2})', caseSensitive: false),
      RegExp(r'order total:?\s*\$?([0-9,]+\.[0-9]{2})', caseSensitive: false),
    ];

    for (var pattern in totalPatterns) {
      final match = pattern.firstMatch(body);
      if (match != null) {
        extraction.total = _parseAmount(match.group(1)!);
        extraction.confidence = ConfidenceLevel.high;
        break;
      }
    }

    // Look for subtotal
    final subtotalMatch = RegExp(
      r'subtotal:?\s*\$?([0-9,]+\.[0-9]{2})',
      caseSensitive: false,
    ).firstMatch(body);
    if (subtotalMatch != null) {
      extraction.subtotal = _parseAmount(subtotalMatch.group(1)!);
    }

    // Look for tax
    final taxMatch = RegExp(
      r'tax:?\s*\$?([0-9,]+\.[0-9]{2})',
      caseSensitive: false,
    ).firstMatch(body);
    if (taxMatch != null) {
      extraction.tax = _parseAmount(taxMatch.group(1)!);
    }

    // Look for discount
    final discountPatterns = [
      RegExp(r'discount:?\s*-?\$?([0-9,]+\.[0-9]{2})', caseSensitive: false),
      RegExp(r'savings:?\s*-?\$?([0-9,]+\.[0-9]{2})', caseSensitive: false),
    ];
    for (var pattern in discountPatterns) {
      final match = pattern.firstMatch(body);
      if (match != null) {
        extraction.discount = _parseAmount(match.group(1)!);
        break;
      }
    }

    // Look for tip
    final tipMatch = RegExp(
      r'tip:?\s*\$?([0-9,]+\.[0-9]{2})',
      caseSensitive: false,
    ).firstMatch(body);
    if (tipMatch != null) {
      extraction.tip = _parseAmount(tipMatch.group(1)!);
    }

    // If no total found, try subject line
    if (extraction.total == 0.0) {
      final subjectAmount = RegExp(r'\$([0-9,]+\.[0-9]{2})').firstMatch(subject);
      if (subjectAmount != null) {
        extraction.total = _parseAmount(subjectAmount.group(1)!);
        extraction.confidence = ConfidenceLevel.medium;
      }
    }

    return extraction;
  }

  /// Extract date from email
  DateExtraction _extractDate(String body, String subject) {
    // Try common date patterns
    final datePatterns = [
      RegExp(r'(\d{1,2})/(\d{1,2})/(\d{4})'), // MM/DD/YYYY
      RegExp(r'(\d{4})-(\d{2})-(\d{2})'), // YYYY-MM-DD
      RegExp(r'(\w+)\s+(\d{1,2}),\s+(\d{4})'), // Month DD, YYYY
    ];

    for (var pattern in datePatterns) {
      final match = pattern.firstMatch(body);
      if (match != null) {
        try {
          final date = _parseDate(match.group(0)!);
          if (date != null) {
            return DateExtraction(
              date: date,
              confidence: ConfidenceLevel.high,
            );
          }
        } catch (e) {
          _logger.fine('Failed to parse date: ${match.group(0)}');
        }
      }
    }

    // Fallback to current date
    return DateExtraction(
      date: DateTime.now(),
      confidence: ConfidenceLevel.low,
    );
  }

  /// Extract line items from email body
  List<LineItemData> _extractLineItems(String body) {
    final items = <LineItemData>[];
    
    // This is a simplified version - real implementation would be more sophisticated
    // Look for patterns like "Item Name ... $XX.XX"
    final itemPattern = RegExp(
      r'(.+?)\s+\$?([0-9,]+\.[0-9]{2})',
      multiLine: true,
    );

    final matches = itemPattern.allMatches(body);
    var order = 0;

    for (var match in matches) {
      final description = match.group(1)?.trim();
      final amountStr = match.group(2);

      if (description != null && amountStr != null && description.length < 100) {
        items.add(LineItemData(
          description: description,
          amount: _parseAmount(amountStr),
          type: _inferLineItemType(description),
          order: order++,
        ));
      }
    }

    return items;
  }

  /// Infer line item type from description
  LineItemType _inferLineItemType(String description) {
    final lower = description.toLowerCase();

    if (lower.contains('tax')) return LineItemType.tax;
    if (lower.contains('discount') || lower.contains('coupon')) {
      return LineItemType.discount;
    }
    if (lower.contains('tip') || lower.contains('gratuity')) {
      return LineItemType.tip;
    }
    if (lower.contains('fee') || lower.contains('delivery')) {
      return LineItemType.fee;
    }
    if (lower.contains('subtotal')) return LineItemType.subtotal;
    if (lower.contains('total')) return LineItemType.total;

    return LineItemType.item;
  }

  /// Parse amount string to double
  double _parseAmount(String amount) {
    final cleaned = amount.replaceAll(',', '').replaceAll('\$', '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  /// Parse date string to DateTime
  DateTime? _parseDate(String dateStr) {
    try {
      // Try ISO format first
      return DateTime.parse(dateStr);
    } catch (e) {
      // Try other formats
      // This is simplified - real implementation would handle more formats
      return null;
    }
  }

  /// Capitalize first letter
  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Calculate overall confidence
  ConfidenceLevel _calculateOverallConfidence(
    ConfidenceLevel merchant,
    ConfidenceLevel amount,
    ConfidenceLevel date,
  ) {
    final scores = [
      _confidenceToScore(merchant),
      _confidenceToScore(amount),
      _confidenceToScore(date),
    ];

    final average = scores.reduce((a, b) => a + b) / scores.length;

    if (average >= 90) return ConfidenceLevel.high;
    if (average >= 60) return ConfidenceLevel.medium;
    return ConfidenceLevel.low;
  }

  int _confidenceToScore(ConfidenceLevel level) {
    switch (level) {
      case ConfidenceLevel.high:
        return 95;
      case ConfidenceLevel.medium:
        return 75;
      case ConfidenceLevel.low:
        return 50;
    }
  }
}

// Data classes for extraction results

class ExtractionResult {
  String merchantName = '';
  String rawMerchantName = '';
  double totalAmount = 0.0;
  double? subtotalAmount;
  double? taxAmount;
  double? discountAmount;
  double? tipAmount;
  DateTime date = DateTime.now();
  List<LineItemData> lineItems = [];
  bool hasLineItems = false;
  
  ConfidenceLevel merchantConfidence = ConfidenceLevel.low;
  ConfidenceLevel amountConfidence = ConfidenceLevel.low;
  ConfidenceLevel dateConfidence = ConfidenceLevel.low;
  ConfidenceLevel overallConfidence = ConfidenceLevel.low;
  
  String? emailSubject;
  String? emailSender;
  String? emailId;
}

class MerchantExtraction {
  final String name;
  final ConfidenceLevel confidence;

  MerchantExtraction({
    required this.name,
    required this.confidence,
  });
}

class AmountExtraction {
  double total = 0.0;
  double? subtotal;
  double? tax;
  double? discount;
  double? tip;
  ConfidenceLevel confidence = ConfidenceLevel.low;
}

class DateExtraction {
  final DateTime date;
  final ConfidenceLevel confidence;

  DateExtraction({
    required this.date,
    required this.confidence,
  });
}

class LineItemData {
  final String description;
  final double amount;
  final LineItemType type;
  final int order;

  LineItemData({
    required this.description,
    required this.amount,
    required this.type,
    required this.order,
  });
}
