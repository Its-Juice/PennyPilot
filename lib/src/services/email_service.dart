import 'dart:convert';
import 'package:googleapis/gmail/v1.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:pennypilot/src/services/auth_service.dart';
import 'package:pennypilot/src/services/receipt_extraction_service.dart';
import 'package:pennypilot/src/services/subscription_intelligence_service.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/models/receipt_line_item_model.dart';

class EmailService {
  final AuthService _authService;
  final ReceiptExtractionService _receiptExtractionService;
  final SubscriptionIntelligenceService _subscriptionService;
  final Isar _isar;
  final _logger = Logger('EmailService');

  EmailService(
    this._authService,
    this._receiptExtractionService,
    this._subscriptionService,
    this._isar,
  );

  /// Scan connected email accounts for receipts and invoices
  Future<void> scanEmails() async {
    final emails = _authService.connectedEmails;
    if (emails.isEmpty) {
      _logger.warning('No connected email accounts to scan');
      return;
    }

    try {
      for (final email in emails) {
        await scanAccount(email);
        await _authService.setLastSyncTime(email, DateTime.now());
      }
      
      // After scanning all accounts, run subscription intelligence
      await _subscriptionService.detectSubscriptions();
      
    } catch (e, stack) {
      _logger.severe('Error scanning emails', e, stack);
      rethrow;
    }
  }

  Future<List<TransactionModel>> previewScan({int limit = 5}) async {
    final emails = _authService.connectedEmails;
    if (emails.isEmpty) return [];

    final results = <TransactionModel>[];
    
    for (final email in emails) {
      final accountResults = await scanAccount(email, dryRun: true, limit: limit);
      results.addAll(accountResults);
      if (results.length >= limit) break;
    }
    
    return results.take(limit).toList();
  }

  Future<List<TransactionModel>> scanAccount(String email, {bool dryRun = false, int? limit}) async {
    final results = <TransactionModel>[];
    try {
      _logger.info('Scanning account: $email (dryRun: $dryRun)');
      final httpClient = await _authService.getClientForEmail(email);
      if (httpClient == null) {
        _logger.warning('Could not get authenticated client for $email');
        return [];
      }

      final gmailApi = GmailApi(httpClient);
      
      String? nextPageToken;
      int processedCount = 0;
      final maxResults = limit ?? 100;
      
      final query = 'subject:(receipt OR invoice OR subscription OR order OR confirmation OR payment OR statement OR bill) -in:trash -in:spam after:2024/01/01';

      do {
        final response = await gmailApi.users.messages.list(
          'me', 
          q: query, 
          pageToken: nextPageToken,
          maxResults: 20 
        );
        
        nextPageToken = response.nextPageToken;
        
        if (response.messages == null || response.messages!.isEmpty) {
           break;
        }
        
        for (final msgHeader in response.messages!) {
          if (!dryRun) {
            // Check if already processed
            final existing = await _isar.transactionModels
                .filter()
                .originalEmailIdEqualTo(msgHeader.id)
                .findFirst();
                
            if (existing != null) continue;
          }
          
          final transaction = await _processMessage(gmailApi, msgHeader.id!, dryRun: dryRun);
          if (transaction != null) {
            results.add(transaction);
            processedCount++;
          }
          
          if (processedCount >= maxResults) break;
        }
        
        if (processedCount >= maxResults) break;
        
      } while (nextPageToken != null);
      
      _logger.info('Finished scanning $email. Processed $processedCount new emails.');

    } catch (e, stack) {
      _logger.severe('Error scanning email account: $email', e, stack);
    }
    return results;
  }

  Future<TransactionModel?> _processMessage(GmailApi gmailApi, String messageId, {required bool dryRun}) async {
    try {
      final message = await gmailApi.users.messages.get(
        'me', 
        messageId, 
        format: 'full'
      );
      
      final subject = _getHeader(message, 'Subject') ?? 'Unknown Subject';
      final from = _getHeader(message, 'From') ?? 'Unknown Sender';
      final dateMillis = int.tryParse(message.internalDate ?? '0') ?? 0;
      final date = dateMillis > 0 
          ? DateTime.fromMillisecondsSinceEpoch(dateMillis) 
          : DateTime.now();
          
      final body = _extractBody(message);
      
      // Extract data
      final extraction = await _receiptExtractionService.extractReceiptData(
        emailBody: body,
        emailSubject: subject,
        emailSender: from,
        emailId: messageId,
      );
      
      // Filter out low confidence results unless they are very likely correct based on sender/subject
      if (extraction.overallConfidence == ConfidenceLevel.low && extraction.totalAmount == 0) {
        return null;
      }
      
      // Create Transaction Model
      final transaction = TransactionModel()
        ..merchantName = extraction.merchantName
        ..rawMerchantName = extraction.rawMerchantName
        ..amount = extraction.totalAmount
        ..subtotalAmount = extraction.subtotalAmount
        ..taxAmount = extraction.taxAmount
        ..discountAmount = extraction.discountAmount
        ..tipAmount = extraction.tipAmount
        ..date = extraction.date.year == DateTime.now().year && extraction.date.month == DateTime.now().month && extraction.date.day == DateTime.now().day && dateMillis > 0
            ? date 
            : extraction.date
        ..category = null // To be categorized later
        ..origin = TransactionOrigin.emailDetected
        ..extractionConfidence = extraction.overallConfidence
        ..hasLineItems = extraction.hasLineItems
        ..originalEmailId = messageId
        ..createdAt = DateTime.now()
        ..userVerified = false;
        
      if (dryRun) {
        return transaction;
      }
        
      // Save to database
      await _isar.writeTxn(() async {
        await _isar.transactionModels.put(transaction);
        
        if (extraction.hasLineItems) {
           for (var item in extraction.lineItems) {
             final lineItem = ReceiptLineItemModel()
               ..description = item.description
               ..amount = item.amount
               ..type = item.type
               ..order = item.order
               ..transactionId = transaction.id;
             
             await _isar.receiptLineItemModels.put(lineItem);
           }
        }
      });
      
      _logger.info('Saved transaction: ${transaction.merchantName} - \$${transaction.amount}');
      return transaction;
      
    } catch (e) {
      _logger.warning('Failed to process message $messageId', e);
      return null;
    }
  }
  
  String? _getHeader(Message message, String name) {
    return message.payload?.headers?.firstWhere(
      (h) => h.name?.toLowerCase() == name.toLowerCase(),
      orElse: () => MessagePartHeader(name: name, value: null),
    ).value;
  }
  
  String _extractBody(Message message) {
    if (message.payload == null) return '';
    
    // First try to find text/plain
    String? body = _findPart(message.payload!, 'text/plain');
    if (body != null) return body;
    
    // Fallback to text/html
    body = _findPart(message.payload!, 'text/html');
    
    if (body != null) {
      return _stripHtml(body);
    }

    return '';
  }

  String _stripHtml(String html) {
    // Remove style and script tags first
    var processed = html.replaceAll(RegExp(r'<(style|script)[^<>]*>.*?</\1>', multiLine: true, caseSensitive: false, dotAll: true), '');
    
    // Replace <br>, <p>, <div>, <tr> with newlines to preserve structure
    processed = processed.replaceAll(RegExp(r'<(br|p|div|tr)[^>]*>', caseSensitive: false), '\n');
    
    // Replace <td> and <th> with tabs or spaces to preserve column structure
    processed = processed.replaceAll(RegExp(r'<(td|th)[^>]*>', caseSensitive: false), '  ');
    
    // Remove all other tags
    processed = processed.replaceAll(RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true), ' ');
    
    // Decode HTML entities
    processed = processed
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&apos;', "'")
        .replaceAll('&#36;', '\$')
        .replaceAll('&#163;', '£')
        .replaceAll('&#128;', '€');
        
    // Collapse multiple horizontal spaces but preserve newlines
    processed = processed.replaceAll(RegExp(r'[ \t]+'), ' ');
    
    // Collapse multiple newlines to max 2
    processed = processed.replaceAll(RegExp(r'\n\s*\n'), '\n\n');
    
    return processed.trim();
  }
  
  String? _findPart(MessagePart part, String mimeType) {
    if (part.mimeType == mimeType && part.body?.data != null) {
      try {
        return utf8.decode(base64.decode(base64Url.normalize(part.body!.data!)));
      } catch (e) {
        return null;
      }
    }
    
    if (part.parts != null) {
      for (final subPart in part.parts!) {
        final result = _findPart(subPart, mimeType);
        if (result != null) return result;
      }
    }
    return null;
  }

  Future<void> signIn() async {
    await _authService.signInWithGoogle();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}

