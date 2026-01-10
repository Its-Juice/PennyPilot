import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/presentation/providers/app_state_provider.dart';

class SpendingSummaryCard extends ConsumerWidget {
  const SpendingSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(recentTransactionsProvider);
    final appCurrency = ref.watch(appStateProvider).currencyCode;
    final currencySymbol = CurrencyInfo.getSymbol(appCurrency);
    final currencyFormat = NumberFormat.currency(
      symbol: currencySymbol,
      decimalDigits: 2,
    );

    return transactionsAsync.when(
      data: (transactions) {
        final totalSpent = transactions.fold<double>(0, (sum, t) => sum + t.amount);
        final monthName = DateFormat.MMMM().format(DateTime.now());
        final theme = Theme.of(context);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primary.withAlpha(200),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withAlpha(60),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Spent in $monthName',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onPrimary.withAlpha(200),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.trending_up,
                    color: theme.colorScheme.onPrimary.withAlpha(200),
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                currencyFormat.format(totalSpent),
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary.withAlpha(40),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.receipt_long,
                      size: 14,
                      color: theme.colorScheme.onPrimary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${transactions.length} Transactions',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox(height: 150, child: Center(child: CircularProgressIndicator())),
      error: (e, s) => const SizedBox(height: 150, child: Center(child: Icon(Icons.error))),
    );
  }
}
