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

  /// Extract receipt data from raw OCR text (from physical receipt scan)
  Future<ExtractionResult> extractReceiptFromOCRText(String ocrText) async {
    _logger.info('Extracting receipt from OCR text');
    
    final result = ExtractionResult();
    
    // For OCR text, we use the first few non-empty lines as potential merchant candidates
    final lines = ocrText.split('\n').where((l) => l.trim().isNotEmpty).toList();
    result.rawMerchantName = lines.isNotEmpty ? lines.first.trim() : 'Unknown Merchant';
    result.merchantConfidence = lines.isNotEmpty ? ConfidenceLevel.medium : ConfidenceLevel.low;
    
    // Normalize merchant
    result.merchantName = await _merchantService.normalizeMerchantName(result.rawMerchantName);
    
    // Extract amounts (reuse existing regex logic)
    final amountExtraction = _extractAmounts(ocrText, '');
    result.totalAmount = amountExtraction.total;
    result.subtotalAmount = amountExtraction.subtotal;
    result.taxAmount = amountExtraction.tax;
    result.amountConfidence = amountExtraction.confidence;
    
    // Extract date
    final dateExtraction = _extractDate(ocrText, '');
    result.date = dateExtraction.date;
    result.dateConfidence = dateExtraction.confidence;
    
    // Extract line items
    final lineItems = _extractLineItems(ocrText);
    result.lineItems = lineItems;
    result.hasLineItems = lineItems.isNotEmpty;
    
    result.overallConfidence = _calculateOverallConfidence(
      result.merchantConfidence,
      result.amountConfidence,
      result.dateConfidence,
    );
    
    return result;
  }

  /// Extract merchant name from email
  MerchantExtraction _extractMerchant(String subject, String sender, String body) {
    final senderLower = sender.toLowerCase();
    
    // 1. Check for known "Trust List" domains
    final trustList = {
      'uber.com': 'Uber',
      'lyft.com': 'Lyft',
      'amazon': 'Amazon',
      'steampowered.com': 'Steam',
      'netflix.com': 'Netflix',
      'spotify.com': 'Spotify',
      'apple.com': 'Apple',
      'microsoft.com': 'Microsoft',
      'google.com': 'Google',
      'starbucks.com': 'Starbucks',
      'doordash.com': 'DoorDash',
      'ubereats.com': 'Uber Eats',
      'grubhub.com': 'Grubhub',
      'deliveroo.com': 'Deliveroo',
      'railway.app': 'Railway',
      'digitalocean.com': 'DigitalOcean',
      'heroku.com': 'Heroku',
      'vercel.com': 'Vercel',
      'github.com': 'GitHub',
      'stripe.com': 'Stripe',
      'paypal.com': 'PayPal',
      'ebay.com': 'eBay',
      'walmart.com': 'Walmart',
      'target.com': 'Target',
      'bestbuy.com': 'Best Buy',
      'costco.com': 'Costco',
      'bolt.eu': 'Bolt',
      'wolt.com': 'Wolt',
      'foodpanda': 'Foodpanda',
      'airbnb.com': 'Airbnb',
      'booking.com': 'Booking.com',
      'expedia.com': 'Expedia',
      'delta.com': 'Delta Air Lines',
      'united.com': 'United Airlines',
      'ryanair.com': 'Ryanair',
      'easyjet.com': 'EasyJet',
      'openai.com': 'OpenAI',
      'anthropic.com': 'Anthropic',
      'midjourney.com': 'Midjourney',
      'adobe.com': 'Adobe',
      'zoom.us': 'Zoom',
      'slack.com': 'Slack',
      'atlassian.com': 'Atlassian',
      'figma.com': 'Figma',
      'canva.com': 'Canva',
    };

    for (final entry in trustList.entries) {
      if (senderLower.contains(entry.key)) {
        return MerchantExtraction(
          name: entry.value,
          confidence: ConfidenceLevel.high,
        );
      }
    }

    // 2. Try to extract from sender display name
    final nameAndEmailMatch = RegExp(r'^"?([^"<]+)"?\s*<([^>]+)>').firstMatch(sender);
    if (nameAndEmailMatch != null) {
      var displayName = nameAndEmailMatch.group(1)!.trim();
      // Clean up quotes
      displayName = displayName.replaceAll('"', '').replaceAll("'", '').trim();
      
      if (displayName.isNotEmpty && 
          !displayName.contains('@') && 
          !['no-reply', 'noreply', 'support', 'billing', 'customer', 'notifications', 'orders'].contains(displayName.toLowerCase())) {
        return MerchantExtraction(
          name: displayName,
          confidence: ConfidenceLevel.medium,
        );
      }
    }

    // 3. Try to extract from subject
    final subjectPatterns = [
      RegExp(r'receipt from (.*)', caseSensitive: false),
      RegExp(r'your (.*) order', caseSensitive: false),
      RegExp(r'thank you for shopping at (.*)', caseSensitive: false),
      RegExp(r'order confirmation - (.*)', caseSensitive: false),
      RegExp(r'invoice from (.*)', caseSensitive: false),
      RegExp(r'your (.*) invoice', caseSensitive: false),
      RegExp(r'payment to (.*)', caseSensitive: false),
      RegExp(r'^Order #\d+ at (.*)$', caseSensitive: false),
    ];

    for (var pattern in subjectPatterns) {
      final match = pattern.firstMatch(subject);
      if (match != null && match.group(1) != null) {
        var name = match.group(1)!.split('|')[0].split('-')[0].trim();
        name = name.replaceAll(RegExp(r'\s*#\d+.*$'), '').trim();
        
        if (name.isNotEmpty && name.length < 50) {
          return MerchantExtraction(
            name: name,
            confidence: ConfidenceLevel.high,
          );
        }
      }
    }

    // 4. Fallback to sender domain
    final domainMatch = RegExp(r'@([a-zA-Z0-9-]+)\.').firstMatch(senderLower);
    if (domainMatch != null) {
      final domain = domainMatch.group(1)!;
      if (!['gmail', 'yahoo', 'outlook', 'hotmail', 'icloud', 'me', 'live', 'msn', 'protonmail', 'zoho'].contains(domain)) {
        return MerchantExtraction(
          name: _capitalize(domain),
          confidence: ConfidenceLevel.medium,
        );
      }
    }

    return MerchantExtraction(
      name: 'Unknown Merchant',
      confidence: ConfidenceLevel.low,
    );
  }

  /// Extract amounts from email body
  AmountExtraction _extractAmounts(String body, String subject) {
    final extraction = AmountExtraction();
    
    // Support for multiple currencies: $, €, £, or currency codes like USD, EUR, GBP
    const currencyPattern = r'(?:\$|€|£|USD|EUR|GBP|total\s*(?:amount)?\D{0,3})';
    const amountValPattern = r'([0-9,]+\.[0-9]{2})';

    // 1. Look for total amount in body with broader patterns
    final totalPatterns = [
      RegExp('$currencyPattern\\s*$amountValPattern', caseSensitive: false),
      RegExp(r'total:?\s*(?:\$|€|£)?\s*([0-9,]+\.[0-9]{2})', caseSensitive: false),
      RegExp(r'amount:?\s*(?:\$|€|£)?\s*([0-9,]+\.[0-9]{2})', caseSensitive: false),
      RegExp(r'grand total:?\s*(?:\$|€|£)?\s*([0-9,]+\.[0-9]{2})', caseSensitive: false),
      RegExp(r'order total:?\s*(?:\$|€|£)?\s*([0-9,]+\.[0-9]{2})', caseSensitive: false),
      RegExp(r'charged:?\s*(?:\$|€|£)?\s*([0-9,]+\.[0-9]{2})', caseSensitive: false),
      RegExp(r'total\s+(?:due|paid|amount):?\s*(?:\$|€|£)?\s*([0-9,]+\.[0-9]{2})', caseSensitive: false),
      RegExp(r'summary\s+total:?\s*(?:\$|€|£)?\s*([0-9,]+\.[0-9]{2})', caseSensitive: false),
    ];

    double bestTotal = 0.0;
    
    // Check subject first as it's often high signal
    final subjectAmount = RegExp(r'(?:\$|€|£)\s*([0-9,]+\.[0-9]{2})').firstMatch(subject);
    if (subjectAmount != null) {
      bestTotal = _parseAmount(subjectAmount.group(1)!);
      extraction.confidence = ConfidenceLevel.medium;
    }

    for (var pattern in totalPatterns) {
      final matches = pattern.allMatches(body);
      if (matches.isNotEmpty) {
        // Take the LAST match for "Total" usually, as it appears near the bottom
        final lastMatch = matches.last;
        final val = _parseAmount(lastMatch.group(1)!);
        if (val > 0) {
          extraction.total = val;
          extraction.confidence = ConfidenceLevel.high;
          break; 
        }
      }
    }

    if (extraction.total == 0 && bestTotal > 0) {
      extraction.total = bestTotal;
    }

    // 2. Heuristic: Look for the LARGEST amount in the body if it's near "Total" or at bottom
    if (extraction.total == 0) {
      final allAmounts = RegExp(r'(?:\$|€|£)\s*([0-9,]+\.[0-9]{2})|([0-9,]+\.[0-9]{2})\s*(?:\$|€|£|USD|EUR|GBP)').allMatches(body);
      if (allAmounts.isNotEmpty) {
        double maxAmount = 0;
        for (var m in allAmounts) {
          final amtStr = m.group(1) ?? m.group(2);
          if (amtStr != null) {
            final amt = _parseAmount(amtStr);
            if (amt > maxAmount) maxAmount = amt;
          }
        }
        
        if (maxAmount > 0 && (body.toLowerCase().contains('total') || subject.toLowerCase().contains('receipt'))) {
          extraction.total = maxAmount;
          extraction.confidence = ConfidenceLevel.medium;
        }
      }
    }

    // Look for subtotal/tax/discount/tip
    extraction.subtotal = _extractValueNear(body, ['subtotal', 'sub-total', 'items total']);
    extraction.tax = _extractValueNear(body, ['tax', 'vat', 'gst', 'sales tax']);
    extraction.discount = _extractValueNear(body, ['discount', 'promo', 'savings', 'coupon', 'off']);
    extraction.tip = _extractValueNear(body, ['tip', 'gratuity']);

    return extraction;
  }

  double? _extractValueNear(String body, List<String> keywords) {
    for (var kw in keywords) {
      final pattern = RegExp('$kw:?\\s*(?:\\\$|€|£)?\\s*(-?[0-9,]+\\.[0-9]{2})', caseSensitive: false);
      final match = pattern.firstMatch(body);
      if (match != null) {
        return _parseAmount(match.group(1)!);
      }
    }
    return null;
  }

  /// Extract date from email
  DateExtraction _extractDate(String body, String subject) {
    // Try to find dates in both subject and body, subject often has the actual "Order Date"
    final searchArea = '$subject\n$body';
    
    final datePatterns = [
      RegExp(r'(\d{1,2})/(\d{1,2})/(\d{2,4})'), // MM/DD/YYYY or DD/MM/YYYY
      RegExp(r'(\d{4})-(\d{2})-(\d{2})'), // YYYY-MM-DD
      RegExp(r'(\w{3,9})\s+(\d{1,2}),?\s+(\d{4})'), // Month DD, YYYY
      RegExp(r'(\d{1,2})\s+(\w{3,9})\s+(\d{4})'), // DD Month YYYY
      RegExp(r'(\d{1,2})-(\w{3,9})-(\d{4})'), // DD-Mon-YYYY
    ];

    for (var pattern in datePatterns) {
      final matches = pattern.allMatches(searchArea);
      for (var match in matches) {
        try {
          final date = _parseDate(match.group(0)!);
          if (date != null) {
            // Basic sanity check: date shouldn't be in the far future
            if (date.isBefore(DateTime.now().add(const Duration(days: 1)))) {
              return DateExtraction(
                date: date,
                confidence: ConfidenceLevel.high,
              );
            }
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
      final cleaned = dateStr.replaceAll(RegExp(r'\s+'), ' ').trim();
      
      // 1. Try ISO format
      if (RegExp(r'^\d{4}-\d{2}-\d{2}').hasMatch(cleaned)) {
        return DateTime.parse(cleaned.substring(0, 10));
      }

      // 2. Try MM/DD/YYYY or DD/MM/YYYY (assuming US if / is used and MM < 13)
      final slashMatch = RegExp(r'(\d{1,2})/(\d{1,2})/(\d{2,4})').firstMatch(cleaned);
      if (slashMatch != null) {
        var day = int.parse(slashMatch.group(1)!);
        var month = int.parse(slashMatch.group(2)!);
        var year = int.parse(slashMatch.group(3)!);
        if (year < 100) year += 2000;
        
        // Simple swap if it looks like DD/MM
        if (day > 12 && month <= 12) {
          final tmp = day; day = month; month = tmp;
        }
        
        if (month <= 12 && day <= 31) {
          return DateTime(year, month, day);
        }
      }

      // 3. Try "Month DD, YYYY" or "DD Month YYYY"
      const months = {
        'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6,
        'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12,
        'january': 1, 'february': 2, 'march': 3, 'april': 4, 'june': 6,
        'july': 7, 'august': 8, 'september': 9, 'october': 10, 'november': 11, 'december': 12,
      };

      final monthNameMatch = RegExp(r'(\w{3,9})\s+(\d{1,2}),?\s+(\d{4})|(\d{1,2})\s+(\w{3,9})\s+(\d{4})').firstMatch(cleaned);
      if (monthNameMatch != null) {
        String? mName = monthNameMatch.group(1) ?? monthNameMatch.group(5);
        String? dStr = monthNameMatch.group(2) ?? monthNameMatch.group(4);
        String? yStr = monthNameMatch.group(3) ?? monthNameMatch.group(6);
        
        if (mName != null && dStr != null && yStr != null) {
          final mVal = months[mName.toLowerCase()];
          if (mVal != null) {
            return DateTime(int.parse(yStr), mVal, int.parse(dStr));
          }
        }
      }

    } catch (e) {
      _logger.fine('Date parse error: $e');
    }
    return null;
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
