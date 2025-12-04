import 'package:isar/isar.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final Isar isar;

  TransactionRepositoryImpl(this.isar);

  @override
  Future<List<TransactionModel>> getTransactions() async {
    return await isar.transactionModels.where().findAll();
  }

  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    await isar.writeTxn(() async {
      await isar.transactionModels.put(transaction);
    });
  }

  @override
  Future<void> deleteTransaction(int id) async {
    await isar.writeTxn(() async {
      await isar.transactionModels.delete(id);
    });
  }

  @override
  Stream<List<TransactionModel>> watchTransactions() {
    return isar.transactionModels.where().watch(fireImmediately: true);
  }
}
