import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/repositories/transaction_repository_impl.dart';
import 'package:pennypilot/src/domain/repositories/transaction_repository.dart';
import 'package:pennypilot/src/presentation/providers/database_provider.dart';

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final isar = ref.watch(isarProvider).valueOrNull;
  if (isar == null) {
    throw UnimplementedError('Database not initialized');
  }
  return TransactionRepositoryImpl(isar);
});

final transactionListProvider = StreamProvider<List<TransactionModel>>((ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return repository.watchTransactions();
});
