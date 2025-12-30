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

    return Scaffold(
      appBar: AppBar(
        title: const Text('PennyPilot'),
        actions: [
          if (isDemoMode)
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Chip(
                label: Text('DEMO'),
                visualDensity: VisualDensity.compact,
              ),
            ),
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'Scan Emails',
            onPressed: () async {
              try {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const ScanningDialog(),
                );
                
                final count = await ref.read(emailServiceProvider).scanEmails();
                
                if (context.mounted) {
                  Navigator.of(context).pop(); // Close scanning dialog
                  showDialog(
                    context: context,
                    builder: (context) => SuccessDialog(count: count),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.of(context).pop(); // Close scanning dialog if open
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error scanning: $e'), backgroundColor: Colors.red),
                  );
                }
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpendingSummaryCard(),
            const SizedBox(height: 24),
            const SafeToSpend(),
            const SizedBox(height: 24),
            Text(
              'Spending by Category',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const CategoryPieChart(),
            const SizedBox(height: 24),
            const CategoriesScroller(),
            const SizedBox(height: 24),
            Text(
              'Spending Pulse',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const SpendingPulseChart(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    ref.read(dashboardIndexProvider.notifier).state = 1; // Transactions tab
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            transactionsAsync.when(
              data: (transactions) {
                if (transactions.isEmpty) {
                  return _buildEmptyTransactions(context);
                }
                final displayTransactions = transactions.take(5).toList();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayTransactions.length,
                  itemBuilder: (context, index) {
                    final t = displayTransactions[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                        child: Text(t.merchantName[0].toUpperCase()),
                      ),
                      title: Text(t.merchantName),
                      subtitle: Text(DateFormat.yMMMd().format(t.date)),
                      trailing: Text(
                        currencyFormat.format(t.amount),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Text('Error loading transactions: $e'),
            ),
            const SizedBox(height: 24),
            Text(
              'Upcoming Subscriptions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            subscriptionsAsync.when(
              data: (subscriptions) {
                if (subscriptions.isEmpty) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('No active subscriptions detected.'),
                    ),
                  );
                }
                final topSubs = subscriptions.take(3).toList();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: topSubs.length,
                  itemBuilder: (context, index) {
                    final s = topSubs[index];
                    final daysUntil = s.nextRenewalDate.difference(DateTime.now()).inDays + 1;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(child: Icon(Icons.event_repeat)),
                      title: Text(s.serviceName),
                      subtitle: Text('Renewing in ${daysUntil > 0 ? daysUntil : 0} days'),
                      trailing: Text(
                        currencyFormat.format(s.amount),
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Text('Error loading subscriptions: $e'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyTransactions(BuildContext context) {
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
              'No Transactions Yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Connect your email to automatically scan for receipts and track your spending.',
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
              label: const Text('Connect Email'),
            ),
          ],
        ),
      ),
    );
  }
}
