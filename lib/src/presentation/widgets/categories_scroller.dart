import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/presentation/providers/app_state_provider.dart';

class CategoriesScroller extends ConsumerWidget {
  const CategoriesScroller({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(recentTransactionsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final appCurrency = ref.watch(appStateProvider).currencyCode;
    final currencySymbol = CurrencyInfo.getSymbol(appCurrency);

    return categoriesAsync.when(
      data: (categories) => transactionsAsync.when(
        data: (transactions) {
          final catMap = <int, double>{};
          for (final t in transactions) {
            if (t.categoryId != null) {
              catMap[t.categoryId!] = (catMap[t.categoryId!] ?? 0) + t.amount;
            }
          }

          final activeCats = categories.where((c) => catMap.containsKey(c.id)).toList()
            ..sort((a, b) => (catMap[b.id] ?? 0).compareTo(catMap[a.id] ?? 0));

          if (activeCats.isEmpty) return const SizedBox.shrink();

          return SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: activeCats.length,
              itemBuilder: (context, index) {
                final cat = activeCats[index];
                final amount = catMap[cat.id]!;
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(cat.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), maxLines: 1),
                      const SizedBox(height: 4),
                      Text(
                        NumberFormat.compactCurrency(
                          symbol: currencySymbol,
                        ).format(amount),
                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
        loading: () => const SizedBox.shrink(),
        error: (e, s) => const SizedBox.shrink(),
      ),
      loading: () => const SizedBox.shrink(),
      error: (e, s) => const SizedBox.shrink(),
    );
  }
}
