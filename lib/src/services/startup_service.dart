import 'package:logging/logging.dart';
import 'package:pennypilot/src/services/merchant_normalization_service.dart';
import 'package:pennypilot/src/services/categorization_service.dart';
import 'package:pennypilot/src/services/llm_extraction_service.dart';

class StartupService {
  final MerchantNormalizationService _merchantService;
  final CategorizationService _categorizationService;
  final LLMExtractionService _llmService;
  final _logger = Logger('StartupService');

  StartupService(
    this._merchantService,
    this._categorizationService,
    this._llmService,
  );

  /// Run all initialization tasks
  Future<void> initializeApp() async {
    _logger.info('Initializing application services...');
    
    try {
      // 1. Initialize default merchant normalization rules
      await _merchantService.initializeDefaultRules();
      
      // 2. Initialize default categories and their mappings
      await _categorizationService.initializeDefaultCategories();
      
      // 3. Initialize LLM engine (optional/local)
      await _llmService.initialize();
      
      _logger.info('Application services initialized successfully.');
    } catch (e, stack) {
      _logger.severe('Failed to initialize application services', e, stack);
    }
  }
}
