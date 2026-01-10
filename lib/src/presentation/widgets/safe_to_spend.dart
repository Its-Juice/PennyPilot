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
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final progress = result.monthlyBudget > 0 ? (result.remainingMonthly / result.monthlyBudget).clamp(0.0, 1.0) : 0.0;

        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withAlpha(12),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Stack(
              children: [
                Positioned(
                  top: -20,
                  right: -20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary.withAlpha(15),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: colorScheme.tertiaryContainer.withAlpha(51),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(Icons.auto_awesome, 
                                  size: 16, 
                                  color: colorScheme.tertiary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'SAFE TO SPEND',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: colorScheme.tertiary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'TODAY',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant.withAlpha(128),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        currencyFormat.format(result.dailySafeAmount),
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Month Progress',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            '${(progress * 100).toInt()}% left',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Stack(
                        children: [
                          Container(
                            height: 8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          AnimatedFractionallySizedBox(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOutCubic,
                            widthFactor: progress,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    colorScheme.tertiary,
                                    colorScheme.tertiary.withAlpha(150),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildMiniStat(context, 'BUDGET', currencyFormat.format(result.monthlyBudget)),
                          _buildMiniStat(context, 'REMAINING', currencyFormat.format(result.remainingMonthly)),
                        ],
                      ),
                    ],
                  ),
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

  Widget _buildMiniStat(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant.withAlpha(128),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
