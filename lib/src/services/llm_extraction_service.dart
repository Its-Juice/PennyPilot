import 'dart:io';
import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mediapipe_genai/mediapipe_genai.dart';

class LLMExtractionService {
  final _logger = Logger('LLMExtractionService');
  LlmInferenceEngine? _engine;
  bool _isInitialized = false;

  /// Initialize the LLM engine with a model file
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      final modelPath = await _getModelPath();
      if (!await File(modelPath).exists()) {
        _logger.warning(
            'LLM model file not found at $modelPath. LLM extraction will be disabled.');
        return;
      }

      // In version 0.0.1, it seems options are handled differently or using named constructors
      final options = LlmInferenceOptions.gpu(
        modelPath: modelPath,
        maxTokens: 512,
        temperature: 0.1,
        topK: 40,
        sequenceBatchSize: 1,
      );

      _engine = LlmInferenceEngine(options);
      _isInitialized = true;
      _logger.info('LLM Extraction Service initialized successfully.');
    } catch (e) {
      _logger.severe('Failed to initialize LLM Extraction Service', e);
    }
  }

  Future<String> _getModelPath() async {
    final directory = await getApplicationSupportDirectory();
    return '${directory.path}/models/gemma-2b-it-gpu-int4.bin';
  }

  /// Extract transaction data from text using the LLM
  Future<LLMExtractionResult?> extractFromText(String text) async {
    if (!_isInitialized || _engine == null) {
      _logger.fine('LLM not initialized, skipping LLM extraction.');
      return null;
    }

    try {
      final prompt = _buildPrompt(text);
      final responseStream = _engine!.generateResponse(prompt);
      final response = await responseStream.first;

      return _parseLLMResponse(response);
    } catch (e) {
      _logger.warning('LLM extraction failed', e);
      return null;
    }
  }

  String _buildPrompt(String text) {
    return '''
Extract transaction details from the following receipt or email text. 
Return ONLY a JSON object with these fields:
- merchant: (string) name of the store or service provider
- amount: (number) the FINAL total amount paid
- date: (string) YYYY-MM-DD
- currency: (string) 3-letter code or symbol
- tax: (number) total tax amount if present
- items: (list of {description: string, price: number})

Rules:
1. If a field is unknown, use null.
2. Return ONLY the JSON object, NO other text.
3. Be careful with OCR noise; look for patterns that look like prices and store names.

Input Text:
---
${text.length > 2000 ? text.substring(0, 2000) : text}
---

JSON Response:
''';
  }

  LLMExtractionResult? _parseLLMResponse(String response) {
    try {
      // Find JSON block in response
      final jsonMatch = RegExp(r'\{.*\}', dotAll: true).stringMatch(response);
      if (jsonMatch == null) {
        _logger.warning('No JSON found in LLM response: $response');
        return null;
      }

      final Map<String, dynamic> data = jsonDecode(jsonMatch);

      return LLMExtractionResult(
        merchant: data['merchant'] as String?,
        amount: (data['amount'] as num?)?.toDouble(),
        date: data['date'] != null ? DateTime.tryParse(data['date']) : null,
        currency: data['currency'] as String?,
        tax: (data['tax'] as num?)?.toDouble(),
        items: (data['items'] as List?)
            ?.map((e) => {
                  'description': e['description'] as String? ?? '',
                  'price': (e['price'] as num?)?.toDouble() ?? 0.0,
                })
            .toList(),
      );
    } catch (e) {
      _logger.warning('Failed to parse LLM response: $e\nResponse: $response');
      return null;
    }
  }
}

class LLMExtractionResult {
  final String? merchant;
  final double? amount;
  final DateTime? date;
  final String? currency;
  final double? tax;
  final List<Map<String, dynamic>>? items;

  LLMExtractionResult({
    this.merchant,
    this.amount,
    this.date,
    this.currency,
    this.tax,
    this.items,
  });
}
