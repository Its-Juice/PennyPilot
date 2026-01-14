import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/services/receipt_extraction_service.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:isar/isar.dart';

class ReceiptScanScreen extends ConsumerStatefulWidget {
  const ReceiptScanScreen({super.key});

  @override
  ConsumerState<ReceiptScanScreen> createState() => _ReceiptScanScreenState();
}

class _ReceiptScanScreenState extends ConsumerState<ReceiptScanScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer = TextRecognizer();
  
  bool _isProcessing = false;
  ExtractionResult? _result;
  File? _image;

  @override
  void dispose() {
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? photo = await _picker.pickImage(source: source);
    if (photo == null) return;

    setState(() {
      _image = File(photo.path);
      _isProcessing = true;
      _result = null;
    });

    try {
      final inputImage = InputImage.fromFilePath(photo.path);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      
      final extractionService = ref.read(receiptExtractionServiceProvider);
      final result = await extractionService.extractReceiptFromOCRText(recognizedText.text);
      
      setState(() {
        _result = result;
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error processing receipt: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Receipt'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_image != null)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: FileImage(_image!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.receipt_long, size: 64, color: Colors.grey),
              ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                ),
                FilledButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (_isProcessing)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Analyzing receipt locally...'),
                ],
              )
            else if (_result != null)
              _buildResultCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context) {
    final format = NumberFormat.currency(symbol: '\$'); // Should use app currency
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detected Information', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            _buildResultRow('Merchant', _result!.merchantName),
            _buildResultRow('Date', DateFormat.yMMMd().format(_result!.date)),
            _buildResultRow('Total', format.format(_result!.totalAmount)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  try {
                    final isar = ref.read(isarProvider);
                    final categorizationService = ref.read(categorizationServiceProvider);
                    
                    final categoryId = await categorizationService.categorizeMerchant(_result!.merchantName);
                    
                    final newTransaction = TransactionModel()
                      ..merchantName = _result!.merchantName
                      ..rawMerchantName = _result!.rawMerchantName
                      ..amount = _result!.totalAmount
                      ..subtotalAmount = _result!.subtotalAmount
                      ..taxAmount = _result!.taxAmount
                      ..tipAmount = _result!.tipAmount
                      ..discountAmount = _result!.discountAmount
                      ..date = _result!.date
                      ..createdAt = DateTime.now()
                      ..origin = TransactionOrigin.imported
                      ..kind = TransactionKind.expense
                      ..extractionConfidence = _result!.overallConfidence
                      ..hasLineItems = _result!.hasLineItems
                      ..categoryId = categoryId;
                      
                    await isar.writeTxn(() async {
                      await isar.transactionModels.put(newTransaction);
                    });

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Transaction saved successfully!')),
                      );
                      Navigator.of(context).pop();
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error saving transaction: $e')),
                      );
                    }
                  }
                },
                child: const Text('Import Transaction'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
