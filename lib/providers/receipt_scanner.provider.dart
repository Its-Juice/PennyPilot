import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Placeholder for Receipt model
class Receipt {
  final String merchant;
  final DateTime date;
  final List<ReceiptItem> items;
  final double tax;
  final String paymentMethod;
  final String category;

  Receipt({
    required this.merchant,
    required this.date,
    required this.items,
    required this.tax,
    required this.paymentMethod,
    required this.category,
  });
}

class ReceiptItem {
  final String name;
  final double price;

  ReceiptItem(this.name, this.price);
}

// Placeholder for OCR Service
abstract class OCRService {
  Future<String> scanEmail(String email);
}

// Placeholder for Receipt Parser
abstract class ReceiptParser {
  Future<List<Receipt>> parseReceipts(String text);
}

// Provider definitions
final ocrServiceProvider = Provider<OCRService>((ref) {
  throw UnimplementedError();
});

final receiptParserProvider = Provider<ReceiptParser>((ref) {
  throw UnimplementedError();
});

final receiptScannerProvider = FutureProvider.family<List<Receipt>, String>((
  ref,
  email,
) async {
  final ocr = ref.watch(ocrServiceProvider);
  final parser = ref.watch(receiptParserProvider);
  return ocr.scanEmail(email).then(parser.parseReceipts);
});
