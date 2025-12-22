import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/models/category_model.dart';
import 'package:intl/intl.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final currencyFormat = NumberFormat.simpleCurrency();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spending Insights'),
      ),
      body: transactionsAsync.when(
        data: (transactions) => categoriesAsync.when(
          data: (categories) => _buildInsights(context, transactions, categories, currencyFormat),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('Error loading categories: $e')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error loading transactions: $e')),
      ),
    );
  }

  Widget _buildInsights(
    BuildContext context,
    List<TransactionModel> transactions,
    List<CategoryModel> categories,
    NumberFormat currencyFormat,
  ) {
    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics_outlined, size: 64, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 16),
            const Text('Not enough data for insights yet.'),
            const SizedBox(height: 8),
            const Text('Connect your email to see your spending patterns.'),
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCards(context, totalSpent, transactions, currencyFormat),
          const SizedBox(height: 24),
          
          Text('Spending by Category', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          _buildCategoryChart(context, categoryTotals, categories, totalSpent),
          const SizedBox(height: 24),
          
          Text('Monthly Trend', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          _buildMonthlyChart(context, monthlyData, currencyFormat),
          const SizedBox(height: 24),
          
          Text('Top Merchants', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          _buildTopMerchantsList(context, topMerchants.take(5).toList(), currencyFormat),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context, double total, List<TransactionModel> transactions, NumberFormat format) {
    final theme = Theme.of(context);
    final avgPerDay = transactions.isEmpty ? 0 : total / (DateTime.now().difference(transactions.last.date).inDays.abs() + 1);

    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Total Volume', style: theme.textTheme.labelMedium),
                   const SizedBox(height: 4),
                   Text(format.format(total), style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Avg. / Day', style: theme.textTheme.labelMedium),
                   const SizedBox(height: 4),
                   Text(format.format(avgPerDay), style: theme.textTheme.titleLarge),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChart(BuildContext context, Map<int, double> totals, List<CategoryModel> categories, double grandTotal) {
    final theme = Theme.of(context);
    
    final sections = totals.entries.map((e) {
      final cat = categories.firstWhere((c) => c.id == e.key, orElse: () => CategoryModel()..name = 'Other'..color = '#888888');
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
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: totals.entries.map((e) {
                final cat = categories.firstWhere((c) => c.id == e.key, orElse: () => CategoryModel()..name = 'Other'..color = '#888888');
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 12, height: 12, decoration: BoxDecoration(color: _parseColor(cat.color), shape: BoxShape.circle)),
                    const SizedBox(width: 4),
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
                      width: 16,
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
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: topMerchants.length,
        separatorBuilder: (context, index) => const Divider(indent: 16, endIndent: 16),
        itemBuilder: (context, index) {
          final entry = topMerchants[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              child: Text(entry.key[0].toUpperCase()),
            ),
            title: Text(entry.key),
            trailing: Text(format.format(entry.value), style: const TextStyle(fontWeight: FontWeight.bold)),
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

