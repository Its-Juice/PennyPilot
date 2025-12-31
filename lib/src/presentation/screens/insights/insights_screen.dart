import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/models/category_model.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/presentation/providers/app_state_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final appCurrency = ref.watch(appStateProvider).currencyCode;
    final currencySymbol = CurrencyInfo.getSymbol(appCurrency);
    
    final currencyFormat = NumberFormat.currency(
      symbol: currencySymbol,
      decimalDigits: 2,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.spendingInsights),
      ),
      body: transactionsAsync.when(
        data: (transactions) => categoriesAsync.when(
          data: (categories) => _buildInsights(context, transactions, categories, currencyFormat),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text(AppLocalizations.of(context)!.errorLoadingCategories(e.toString()))),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(AppLocalizations.of(context)!.errorLoadingTransactions(e.toString()))),
      ),
    );
  }

  Widget _buildInsights(
    BuildContext context,
    List<TransactionModel> transactions,
    List<CategoryModel> categories,
    NumberFormat currencyFormat,
  ) {
    final l10n = AppLocalizations.of(context)!;
    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics_outlined, size: 64, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 16),
            Text(l10n.notEnoughDataForInsights),
            const SizedBox(height: 8),
            Text(l10n.connectEmailInsights),
          ],
        ),
      );
    }

    // Calculate stats
    final totalSpent = transactions.fold<double>(0, (sum, t) => sum + t.amount);
    final categoryTotals = <int, double>{};
    final merchantTotals = <String, double>{};
    
    for (final t in transactions) {
      if (t.categoryId != null) {
        categoryTotals[t.categoryId!] = (categoryTotals[t.categoryId!] ?? 0) + t.amount;
      }
      merchantTotals[t.merchantName] = (merchantTotals[t.merchantName] ?? 0) + t.amount;
    }

    // Sort merchants by spending
    final topMerchants = merchantTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Get time-based series (last 6 months)
    final monthlyData = _getMonthlyData(transactions);

    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: Text(l10n.spendingInsights),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildSummaryRow(context, totalSpent, transactions, currencyFormat),
              const SizedBox(height: 32),
              
              _sectionHeader(context, l10n.spendingByCategory),
              const SizedBox(height: 12),
              _buildCategoryChart(context, categoryTotals, categories, totalSpent),
              
              const SizedBox(height: 32),
              _sectionHeader(context, l10n.monthlyTrend),
              const SizedBox(height: 12),
              _buildMonthlyChart(context, monthlyData, currencyFormat),
              
              const SizedBox(height: 32),
              _sectionHeader(context, l10n.topMerchants),
              const SizedBox(height: 12),
              _buildTopMerchantsList(context, topMerchants.take(5).toList(), currencyFormat),
              const SizedBox(height: 48),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, double total, List<TransactionModel> transactions, NumberFormat format) {
    final l10n = AppLocalizations.of(context)!;
    final avgPerDay = transactions.isEmpty ? 0.0 : total / (DateTime.now().difference(transactions.last.date).inDays.abs() + 1);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withAlpha(51),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.primary.withAlpha(26)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.totalVolume, style: theme.textTheme.labelMedium),
                const SizedBox(height: 4),
                Text(
                  format.format(total),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 40, width: 1, color: theme.colorScheme.primary.withAlpha(51)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.avgPerDay, style: theme.textTheme.labelMedium),
                  const SizedBox(height: 4),
                  Text(
                    format.format(avgPerDay),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChart(BuildContext context, Map<int, double> totals, List<CategoryModel> categories, double grandTotal) {
    final theme = Theme.of(context);
    
    final sections = totals.entries.map((e) {
      final l10n = AppLocalizations.of(context)!;
      final cat = categories.firstWhere((c) => c.id == e.key, orElse: () => CategoryModel()..name = l10n.other..color = '#888888');
      final percentage = (e.value / grandTotal) * 100;
      
      return PieChartSectionData(
        color: _parseColor(cat.color),
        value: e.value,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: 60,
        titleStyle: theme.textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      );
    }).toList();

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withAlpha(51)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 50,
                  sectionsSpace: 4,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: totals.entries.map((e) {
                final l10n = AppLocalizations.of(context)!;
                final cat = categories.firstWhere((c) => c.id == e.key, orElse: () => CategoryModel()..name = l10n.other..color = '#888888');
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 8, height: 8, decoration: BoxDecoration(color: _parseColor(cat.color), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Text(cat.name, style: theme.textTheme.bodySmall),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyChart(BuildContext context, List<_MonthData> data, NumberFormat format) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withAlpha(51)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 24, 16),
        child: SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: data.isEmpty ? 100 : data.map((d) => d.total).reduce((a, b) => a > b ? a : b) * 1.2,
              barGroups: data.asMap().entries.map((e) {
                return BarChartGroupData(
                  x: e.key,
                  barRods: [
                    BarChartRodData(
                      toY: e.value.total,
                      color: theme.colorScheme.primary,
                      width: 14,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    ),
                  ],
                );
              }).toList(),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= 0 && value.toInt() < data.length) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(data[value.toInt()].label, style: theme.textTheme.labelSmall),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopMerchantsList(BuildContext context, List<MapEntry<String, double>> topMerchants, NumberFormat format) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withAlpha(51)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 8),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: topMerchants.length,
        separatorBuilder: (context, index) => Divider(
          indent: 72, 
          endIndent: 16, 
          height: 1, 
          color: Theme.of(context).colorScheme.outlineVariant.withAlpha(51)
        ),
        itemBuilder: (context, index) {
          final entry = topMerchants[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Text(entry.key[0].toUpperCase()),
            ),
            title: Text(entry.key, style: Theme.of(context).textTheme.titleSmall),
            trailing: Text(
              format.format(entry.value), 
              style: const TextStyle(fontWeight: FontWeight.bold)
            ),
          );
        },
      ),
    );
  }

  List<_MonthData> _getMonthlyData(List<TransactionModel> transactions) {
     final data = <String, double>{};
     final now = DateTime.now();
     
     for (int i = 5; i >= 0; i--) {
       final date = DateTime(now.year, now.month - i, 1);
       final key = DateFormat('MMM').format(date);
       data[key] = 0;
     }

     for (final t in transactions) {
       final key = DateFormat('MMM').format(t.date);
       if (data.containsKey(key)) {
         data[key] = (data[key] ?? 0) + t.amount;
       }
     }

     return data.entries.map((e) => _MonthData(e.key, e.value)).toList();
  }

  Color _parseColor(String? colorStr) {
    if (colorStr == null || !colorStr.startsWith('#')) return Colors.grey;
    try {
      return Color(int.parse(colorStr.substring(1), radix: 16) + 0xFF000000);
    } catch (e) {
      return Colors.grey;
    }
  }
}

class _MonthData {
  final String label;
  final double total;
  _MonthData(this.label, this.total);
}

