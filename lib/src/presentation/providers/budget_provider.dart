import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/services/budget_service.dart';
import 'package:pennypilot/src/presentation/providers/database_provider.dart';

final budgetServiceProvider = Provider<BudgetService>((ref) {
  final isar = ref.watch(isarProvider);
  return BudgetService(isar);
});

final safeToSpendProvider = FutureProvider<SafeToSpendResult>((ref) async {
  final service = ref.watch(budgetServiceProvider);
  return await service.calculateSafeToSpend();
});
