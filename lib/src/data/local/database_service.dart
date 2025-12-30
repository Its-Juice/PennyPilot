import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logging/logging.dart';

import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/models/subscription_model.dart';
import 'package:pennypilot/src/data/models/receipt_line_item_model.dart';
import 'package:pennypilot/src/data/models/extraction_metadata_model.dart';
import 'package:pennypilot/src/data/models/merchant_normalization_rule_model.dart';
import 'package:pennypilot/src/data/models/email_sender_preference_model.dart';
import 'package:pennypilot/src/data/models/category_model.dart';
import 'package:pennypilot/src/data/models/budget_model.dart';


class DatabaseService {
  late Future<Isar> db;
  final String? _directory;
  final _logger = Logger('DatabaseService');

  DatabaseService([this._directory]) {
    db = _initDb();
  }

  Future<Isar> _initDb() async {
    final path = _directory ?? (await getApplicationDocumentsDirectory()).path;
    
    // Note: Isar v3.1.0 does not support encryption for the default engine.
    // Encryption will be enabled when upgrading to Isar v4 or by switching to SQLite engine.
    // For now, we rely on OS-level sandbox protection.
    
    return await Isar.open(
      [
        TransactionModelSchema,
        SubscriptionModelSchema,
        ReceiptLineItemModelSchema,
        ExtractionMetadataModelSchema,
        MerchantNormalizationRuleModelSchema,
        EmailSenderPreferenceModelSchema,
        CategoryModelSchema,
        MerchantCategoryMappingModelSchema,
        BudgetModelSchema,
        SpendingSplitModelSchema,
      ],
      directory: path,
    );
  }

  Future<void> wipeData() async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.clear();
    });
    _logger.info('Database wiped');
  }

  /// Reset only financial data, preserving categories and settings
  /// This does NOT remove auth tokens - those are in secure storage
  Future<void> resetFinancialData() async {
    final isar = await db;
    await isar.writeTxn(() async {
      // Clear financial data
      await isar.transactionModels.clear();
      await isar.subscriptionModels.clear();
      await isar.receiptLineItemModels.clear();
      await isar.extractionMetadataModels.clear();
      
      // Clear system-generated merchant rules (keep user-defined ones)
      await isar.merchantNormalizationRuleModels
          .where()
          .filter()
          .isUserDefinedEqualTo(false)
          .deleteAll();
      
      // Clear email sender preferences
      await isar.emailSenderPreferenceModels.clear();
      
      // Categories are preserved
      // Auth tokens in secure storage are NOT touched
    });
    _logger.info('Financial data reset - categories and auth preserved');
  }
  
  Future<void> resetAIUnderstanding() async {
    final isar = await db;
    await isar.writeTxn(() async {
      // Clear derived metadata but keep raw transaction data
      await isar.extractionMetadataModels.clear();
      await isar.merchantNormalizationRuleModels.where().filter().isUserDefinedEqualTo(false).deleteAll();
      
      // Reset confidence scores in transactions
      final transactions = await isar.transactionModels.where().findAll();
      for (var transaction in transactions) {
        transaction.extractionConfidence = ConfidenceLevel.low;
        transaction.hasLineItems = false;
        await isar.transactionModels.put(transaction);
      }
    });
    _logger.info('AI understanding reset - raw data preserved');
  }
  
  Future<String> getDatabasePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/default.isar';
  }
}

