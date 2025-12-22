import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/presentation/providers/email_provider.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/models/category_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/presentation/providers/app_state_provider.dart';
import 'package:pennypilot/src/presentation/providers/budget_provider.dart';
import 'package:pennypilot/src/services/budget_service.dart';

class OverviewTab extends ConsumerWidget {
  final bool isDemoMode;

  const OverviewTab({super.key, required this.isDemoMode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(recentTransactionsProvider);
    final subscriptionsAsync = ref.watch(activeSubscriptionsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final safeToSpendAsync = ref.watch(safeToSpendProvider);
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Scanning emails...')),
                );
                await ref.read(emailServiceProvider).scanEmails();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Scan complete')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
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
            _buildBalanceHeader(context, transactionsAsync, currencyFormat),
            const SizedBox(height: 16),
            _buildSafeToSpend(context, safeToSpendAsync, currencyFormat),
            const SizedBox(height: 24),
            
            _buildCategoriesScroller(context, ref, transactionsAsync, categoriesAsync),
            const SizedBox(height: 24),

            Text(
              'Spending Pulse',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildPulseChart(context, transactionsAsync),
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
                    // Navigation handled by TabController in Dashboard
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

  Widget _buildSafeToSpend(BuildContext context, AsyncValue<SafeToSpendResult> safeToSpendAsync, NumberFormat format) {
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
                        format.format(result.dailySafeAmount),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${format.format(result.remainingMonthly)} left this month',
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

  Widget _buildBalanceHeader(BuildContext context, AsyncValue<List<TransactionModel>> transactionsAsync, NumberFormat format) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'MONTHLY SPEND',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
                    letterSpacing: 1.2,
                  ),
                ),
                Icon(Icons.trending_up, color: Theme.of(context).colorScheme.primary),
              ],
            ),
            const SizedBox(height: 8),
            transactionsAsync.when(
              data: (transactions) {
                final total = transactions.fold<double>(0, (sum, t) => sum + t.amount);
                return Text(
                  format.format(total),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (e, s) => const Text('---'),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.check_circle, size: 16, color: Colors.green),
                SizedBox(width: 4),
                Text('All data local & encrypted', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesScroller(BuildContext context, WidgetRef ref, AsyncValue<List<TransactionModel>> transactionsAsync, AsyncValue<List<CategoryModel>> categoriesAsync) {
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
                      Text(NumberFormat.compactCurrency(symbol: CurrencyInfo.getSymbol(ref.watch(appStateProvider).currencyCode)).format(amount), style: TextStyle(color: Theme.of(context).colorScheme.primary)),
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

  Widget _buildPulseChart(BuildContext context, AsyncValue<List<TransactionModel>> transactionsAsync) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 120,
          child: transactionsAsync.when(
            data: (transactions) {
              final daily = <int, double>{};
              final now = DateTime.now();
              for (int i = 0; i < 7; i++) {
                final d = now.subtract(Duration(days: i));
                daily[d.day] = 0;
              }
              for (final t in transactions) {
                if (daily.containsKey(t.date.day)) {
                  daily[t.date.day] = (daily[t.date.day] ?? 0) + t.amount;
                }
              }
              final data = daily.entries.toList().reversed.toList();
              
              return BarChart(
                BarChartData(
                  maxY: data.isEmpty ? 100 : (data.map((e) => e.value).reduce((a, b) => a > b ? a : b) * 1.2).clamp(100, double.infinity),
                  barGroups: data.asMap().entries.map((e) => BarChartGroupData(
                    x: e.key,
                    barRods: [
                      BarChartRodData(
                        toY: e.value.value,
                        color: Theme.of(context).colorScheme.primary,
                        width: 12,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  )).toList(),
                  titlesData: const FlTitlesData(show: false),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => const Center(child: Text('Chart error')),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyTransactions(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Icon(Icons.receipt_long_outlined, size: 48, color: Theme.of(context).colorScheme.outline.withOpacity(0.5)),
            const SizedBox(height: 16),
            const Text('No transactions yet.', style: TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text('Scan your email to begin.', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

