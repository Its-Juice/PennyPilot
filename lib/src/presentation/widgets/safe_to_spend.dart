import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/presentation/providers/budget_provider.dart';
import 'package:pennypilot/src/presentation/providers/app_state_provider.dart';
import 'package:pennypilot/src/services/budget_service.dart';

class SafeToSpend extends ConsumerWidget {
  const SafeToSpend({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeToSpendAsync = ref.watch(safeToSpendProvider);
    final appCurrency = ref.watch(appStateProvider).currencyCode;
    final currencySymbol = CurrencyInfo.getSymbol(appCurrency);
    
    final currencyFormat = NumberFormat.currency(
      symbol: currencySymbol,
      decimalDigits: 2,
    );

    return safeToSpendAsync.when(
      data: (SafeToSpendResult result) {
        if (!result.isBudgetSet) {
          return const SizedBox.shrink();
        }
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                  child: Icon(Icons.bolt, color: Theme.of(context).colorScheme.onTertiaryContainer),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Safe-to-Spend Today',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                      Text(
                        currencyFormat.format(result.dailySafeAmount),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${currencyFormat.format(result.remainingMonthly)} left this month',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (e, s) => const SizedBox.shrink(),
    );
  }
}
