import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/presentation/providers/navigation_provider.dart';
import 'package:pennypilot/src/presentation/screens/auth/connect_email_screen.dart';
import 'package:pennypilot/src/presentation/widgets/categories_scroller.dart';
import 'package:pennypilot/src/presentation/widgets/safe_to_spend.dart';
import 'package:pennypilot/src/presentation/widgets/spending_pulse_chart.dart';
import 'package:pennypilot/src/presentation/widgets/spending_summary_card.dart';
import 'package:pennypilot/src/presentation/widgets/category_pie_chart.dart';
import 'package:pennypilot/src/localization/generated/app_localizations.dart';
import 'package:pennypilot/src/presentation/widgets/transaction_card.dart';
import 'package:pennypilot/src/presentation/widgets/amount_display.dart';

class OverviewTab extends ConsumerWidget {
  final bool isDemoMode;

  const OverviewTab({super.key, required this.isDemoMode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(recentTransactionsProvider);
    final subscriptionsAsync = ref.watch(activeSubscriptionsProvider);
    // final appCurrency = ref.watch(appStateProvider).currencyCode;
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 140,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _getGreeting(context),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              titlePadding:
                  const EdgeInsetsDirectional.only(start: 16, bottom: 16),
            ),
            actions: [
              if (isDemoMode)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Chip(
                    label: Text(l10n.demo),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: theme.colorScheme.tertiaryContainer,
                    labelStyle:
                        TextStyle(color: theme.colorScheme.onTertiaryContainer),
                  ),
                ),
              const SizedBox(width: 8),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                const SpendingSummaryCard(),
                const SizedBox(height: 16),
                const SafeToSpend(),

                const SizedBox(height: 40),
                _sectionHeader(context, l10n.spendingByCategory),
                const SizedBox(height: 16),
                const CategoryPieChart(),
                const SizedBox(height: 20),
                const CategoriesScroller(),

                const SizedBox(height: 40),
                _sectionHeader(context, l10n.spendingPulse),
                const SizedBox(height: 16),
                const SpendingPulseChart(),

                const SizedBox(height: 40),
                _sectionHeader(
                  context,
                  l10n.recentTransactions,
                  trailing: TextButton(
                    onPressed: () =>
                        ref.read(dashboardIndexProvider.notifier).state = 1,
                    child: Text(l10n.viewAll),
                  ),
                ),
                const SizedBox(height: 12),
                transactionsAsync.when(
                  data: (transactions) {
                    if (transactions.isEmpty) {
                      return _buildEmptyTransactions(context);
                    }
                    final displayTransactions = transactions.take(3).toList();
                    return Column(
                      children: displayTransactions
                          .map<Widget>((t) => TransactionCard(
                                transaction: t,
                                expandable: false,
                                showConfidence: false,
                                onTap: () => ref
                                    .read(dashboardIndexProvider.notifier)
                                    .state = 1,
                              ))
                          .toList(),
                    );
                  },
                  loading: () => const Center(
                      child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator())),
                  error: (e, s) =>
                      Text(l10n.errorLoadingTransactions(e.toString())),
                ),

                const SizedBox(height: 40),
                _sectionHeader(
                  context,
                  l10n.upcomingSubscriptions,
                  trailing: TextButton(
                    onPressed: () =>
                        ref.read(dashboardIndexProvider.notifier).state = 2,
                    child: Text(l10n.viewAll),
                  ),
                ),
                const SizedBox(height: 12),
                subscriptionsAsync.when(
                  data: (subscriptions) {
                    if (subscriptions.isEmpty) {
                      return _buildEmptyStateCard(
                        context,
                        icon: Icons.subscriptions_outlined,
                        message: l10n.noActiveSubscriptions,
                      );
                    }
                    final topSubs = subscriptions.take(3).toList();
                    return _buildListCard(
                      context,
                      topSubs.map((s) {
                        final daysUntil = s.nextRenewalDate
                                .difference(DateTime.now())
                                .inDays +
                            1;
                        return ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer
                                  .withAlpha(51),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.event_repeat,
                                size: 20, color: theme.colorScheme.primary),
                          ),
                          title: Text(s.serviceName,
                              style: theme.textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          subtitle: Text(l10n
                              .renewingInDays(daysUntil > 0 ? daysUntil : 0)),
                          trailing: AmountDisplay(
                            amount: s.amount,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const Center(
                      child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator())),
                  error: (e, s) =>
                      Text(l10n.errorLoadingSubscriptions(e.toString())),
                ),
                const SizedBox(height: 100), // Space for FAB
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  Widget _sectionHeader(BuildContext context, String title,
      {Widget? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildListCard(BuildContext context, List<Widget> children) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant.withAlpha(51)),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildEmptyStateCard(BuildContext context,
      {required IconData icon, required String message}) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant.withAlpha(51)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(icon,
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withAlpha(128),
                size: 32),
            const SizedBox(height: 12),
            Text(message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyTransactions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant.withAlpha(51)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withAlpha(51),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.email_outlined,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noTransactionsYet,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.connectEmailDescription,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const ConnectEmailScreen()),
                );
              },
              icon: const Icon(Icons.email),
              label: Text(l10n.connectEmail),
            ),
          ],
        ),
      ),
    );
  }
}
