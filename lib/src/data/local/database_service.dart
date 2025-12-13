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

class DatabaseService {
  late Future<Isar> db;
  final _logger = Logger('DatabaseService');

  DatabaseService() {
    db = _initDb();
  }

  Future<Isar> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();
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
      ],
      directory: dir.path,
    );
  }

  Future<void> wipeData() async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.clear();
    });
    _logger.info('Database wiped');
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

