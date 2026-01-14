import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/data/models/category_model.dart';

class CategoryPieChart extends ConsumerStatefulWidget {
  const CategoryPieChart({super.key});

  @override
  ConsumerState<CategoryPieChart> createState() => _CategoryPieChartState();
}

class _CategoryPieChartState extends ConsumerState<CategoryPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final transactionsAsync = ref.watch(recentTransactionsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final theme = Theme.of(context);

    return transactionsAsync.when(
      data: (transactions) {
        if (transactions.isEmpty) return const SizedBox.shrink();

        return categoriesAsync.when(
          data: (categories) {
            final data = _processData(transactions, categories);
            if (data.isEmpty) return const SizedBox.shrink();

            final total =
                data.values.fold<double>(0, (sum, d) => sum + d.amount);

            return Container(
              height: 240,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 6,
                      centerSpaceRadius: 75,
                      sections: _showingSections(data),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'TOTAL',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        NumberFormat.compactSimpleCurrency().format(total),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          loading: () => const SizedBox(
              height: 240, child: Center(child: CircularProgressIndicator())),
          error: (e, s) => const SizedBox(
              height: 240, child: Center(child: Icon(Icons.error))),
        );
      },
      loading: () => const SizedBox(
          height: 240, child: Center(child: CircularProgressIndicator())),
      error: (e, s) =>
          const SizedBox(height: 240, child: Center(child: Icon(Icons.error))),
    );
  }

  Map<String, _CategoryData> _processData(
      List<dynamic> transactions, List<CategoryModel> categories) {
    final Map<String, _CategoryData> result = {};

    for (var t in transactions) {
      if (t.categoryId == null) continue;

      final category = categories.firstWhere(
        (c) => c.id == t.categoryId,
        orElse: () => CategoryModel()
          ..name = 'Unknown'
          ..color = '#9E9E9E',
      );

      final existing = result[category.name];
      if (existing == null) {
        result[category.name] = _CategoryData(
          amount: t.amount,
          color: _parseColor(category.color),
        );
      } else {
        existing.amount += t.amount;
      }
    }

    return result;
  }

  Color _parseColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return Colors.grey;
    }
  }

  List<PieChartSectionData> _showingSections(Map<String, _CategoryData> data) {
    final total = data.values.fold<double>(0, (sum, d) => sum + d.amount);
    int index = 0;

    return data.entries.map((entry) {
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 16.0 : 12.0;
      final radius = isTouched ? 60.0 : 50.0;
      final percentage = (entry.value.amount / total) * 100;

      final section = PieChartSectionData(
        color: entry.value.color,
        value: entry.value.amount,
        title: percentage > 5 ? '${percentage.toStringAsFixed(0)}%' : '',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
      index++;
      return section;
    }).toList();
  }
}

class _CategoryData {
  double amount;
  final Color color;

  _CategoryData({required this.amount, required this.color});
}
