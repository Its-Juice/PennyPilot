import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:pennypilot/src/data/local/database_service.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/models/category_model.dart';

void main() {
  late DatabaseService service;
  late Isar isar;
  late Directory tempDir;

  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    tempDir = await Directory.systemTemp.createTemp('pennypilot_db_test');
    service = DatabaseService(tempDir.path);
    isar = await service.db;
  });

  tearDown(() async {
    await isar.close();
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('DatabaseService Tests', () {
    test('wipeData clears all collections', () async {
      // Add some data
      await isar.writeTxn(() async {
        await isar.transactionModels.put(TransactionModel()..merchantName = 'Test'..amount = 10..date = DateTime.now()..createdAt = DateTime.now());
        await isar.categoryModels.put(CategoryModel()..name = 'Test'..icon = 'test'..color = '#FF0000'..isSystem = true..order = 0..isActive = true..transactionCount = 0..createdAt = DateTime.now());
      });

      expect(await isar.transactionModels.count(), 1);
      expect(await isar.categoryModels.count(), 1);

      await service.wipeData();

      expect(await isar.transactionModels.count(), 0);
      expect(await isar.categoryModels.count(), 0);
    });

    test('resetFinancialData preserves categories', () async {
      await isar.writeTxn(() async {
        await isar.transactionModels.put(TransactionModel()..merchantName = 'Test'..amount = 10..date = DateTime.now()..createdAt = DateTime.now());
        await isar.categoryModels.put(CategoryModel()..name = 'Test'..icon = 'test'..color = '#FF0000'..isSystem = true..order = 0..isActive = true..transactionCount = 0..createdAt = DateTime.now());
      });

      await service.resetFinancialData();

      expect(await isar.transactionModels.count(), 0);
      expect(await isar.categoryModels.count(), 1);
    });

    test('resetAIUnderstanding resets confidence levels', () async {
      final t = TransactionModel()
        ..merchantName = 'Test'
        ..amount = 10
        ..date = DateTime.now()
        ..createdAt = DateTime.now()
        ..extractionConfidence = ConfidenceLevel.high;

      await isar.writeTxn(() async {
        await isar.transactionModels.put(t);
      });

      expect((await isar.transactionModels.get(t.id))!.extractionConfidence, ConfidenceLevel.high);

      await service.resetAIUnderstanding();

      final result = await isar.transactionModels.get(t.id);
      expect(result!.extractionConfidence, ConfidenceLevel.low);
    });
  });
}
