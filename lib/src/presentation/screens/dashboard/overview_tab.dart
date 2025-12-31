import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/presentation/providers/email_provider.dart';
import 'package:pennypilot/src/presentation/providers/navigation_provider.dart';
import 'package:pennypilot/src/presentation/screens/auth/connect_email_screen.dart';
import 'package:pennypilot/src/presentation/widgets/categories_scroller.dart';
import 'package:pennypilot/src/presentation/widgets/safe_to_spend.dart';
import 'package:pennypilot/src/presentation/widgets/spending_pulse_chart.dart';
import 'package:pennypilot/src/presentation/widgets/spending_summary_card.dart';
import 'package:pennypilot/src/presentation/widgets/category_pie_chart.dart';
import 'package:pennypilot/src/presentation/widgets/status_dialogs.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/presentation/providers/app_state_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OverviewTab extends ConsumerWidget {
  final bool isDemoMode;

  const OverviewTab({super.key, required this.isDemoMode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(recentTransactionsProvider);
    final subscriptionsAsync = ref.watch(activeSubscriptionsProvider);
    final appCurrency = ref.watch(appStateProvider).currencyCode;
    final currencySymbol = CurrencyInfo.getSymbol(appCurrency);
    final currencyFormat = NumberFormat.currency(
      symbol: currencySymbol,
      decimalDigits: 2,
    );
    final l10n = AppLocalizations.of(context)!;


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(l10n.appName),
            actions: [
              if (isDemoMode)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Chip(
                    label: Text(l10n.demo),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              IconButton(
                icon: const Icon(Icons.sync),
                tooltip: l10n.scanEmails,
                onPressed: () async {
                  try {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const ScanningDialog(),
                    );
                    
                    final count = await ref.read(emailServiceProvider).scanEmails();
                    
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) => SuccessDialog(count: count),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.errorScanning(e.toString())), backgroundColor: Colors.red),
                      );
                    }
                  }
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SpendingSummaryCard(),
                const SizedBox(height: 16),
                const SafeToSpend(),
                
                const SizedBox(height: 32),
                _sectionHeader(context, l10n.spendingByCategory),
                const SizedBox(height: 12),
                const CategoryPieChart(),
                const SizedBox(height: 16),
                const CategoriesScroller(),

                const SizedBox(height: 32),
                _sectionHeader(context, l10n.spendingPulse),
                const SizedBox(height: 12),
                const SpendingPulseChart(),

                const SizedBox(height: 32),
                _sectionHeader(
                  context, 
                  l10n.recentTransactions,
                  trailing: TextButton(
                    onPressed: () => ref.read(dashboardIndexProvider.notifier).state = 1,
                    child: Text(l10n.viewAll),
                  ),
                ),
                const SizedBox(height: 8),
                transactionsAsync.when(
                  data: (transactions) {
                    if (transactions.isEmpty) return _buildEmptyTransactions(context);
                    final displayTransactions = transactions.take(5).toList();
                    return Card(
                      child: Column(
                        children: [
                          ...displayTransactions.map((t) => ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                              child: Text(t.merchantName[0].toUpperCase()),
                            ),
                            title: Text(t.merchantName, style: Theme.of(context).textTheme.titleSmall),
                            subtitle: Text(DateFormat.yMMMd().format(t.date)),
                            trailing: Text(
                              currencyFormat.format(t.amount),
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          )),
                        ],
                      ),
                    );
                  },
                  loading: () => const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator())),
                  error: (e, s) => Text(l10n.errorLoadingTransactions(e.toString())),
                ),

                const SizedBox(height: 32),
                _sectionHeader(context, l10n.upcomingSubscriptions),
                const SizedBox(height: 12),
                subscriptionsAsync.when(
                  data: (subscriptions) {
                    if (subscriptions.isEmpty) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(l10n.noActiveSubscriptions, textAlign: TextAlign.center),
                        ),
                      );
                    }
                    final topSubs = subscriptions.take(3).toList();
                    return Card(
                      child: Column(
                        children: [
                          ...topSubs.map((s) {
                            final daysUntil = s.nextRenewalDate.difference(DateTime.now()).inDays + 1;
                            return ListTile(
                              leading: const CircleAvatar(child: Icon(Icons.event_repeat)),
                              title: Text(s.serviceName, style: Theme.of(context).textTheme.titleSmall),
                              subtitle: Text(l10n.renewingInDays(daysUntil > 0 ? daysUntil : 0)),
                              trailing: Text(
                                currencyFormat.format(s.amount),
                                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                  loading: () => const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator())),
                  error: (e, s) => Text(l10n.errorLoadingSubscriptions(e.toString())),
                ),
                const SizedBox(height: 48),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title, {Widget? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildEmptyTransactions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.email_outlined,
                size: 32,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                  MaterialPageRoute(builder: (context) => const ConnectEmailScreen()),
                );
              },
              icon: const Icon(Icons.add),
              label: Text(l10n.connectEmail),
            ),
          ],
        ),
      ),
    );
  }
}
