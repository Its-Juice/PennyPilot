import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rive/rive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'smart_dashboard.g.dart';

class DashboardMetrics {
  final double budgetPercent;
  DashboardMetrics({required this.budgetPercent});
}

class Metrics {
  static DashboardMetrics from(dynamic receipts, dynamic spending) {
    return DashboardMetrics(budgetPercent: 0.75); // Mock data
  }
}

// Mock providers for the demonstration
final receiptsProvider = Provider((ref) => []);
final monthlySpendingProvider = Provider((ref) => 1000.0);

@Riverpod(keepAlive: true)
FutureOr<DashboardMetrics> dashboardMetrics(DashboardMetricsRef ref) async {
  final receipts = ref.watch(receiptsProvider);
  final spending = ref.watch(monthlySpendingProvider);
  return Metrics.from(receipts, spending);
}

class BudgetController extends RiveAnimationController<RuntimeArtboard> {
  final double percent;
  BudgetController(this.percent);

  @override
  bool init(RuntimeArtboard artboard) => true;

  @override
  void apply(RuntimeArtboard artboard, double elapsedSeconds) {}
}

class AnimatedGauge extends HookConsumerWidget {
  const AnimatedGauge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);

    return metricsAsync.when(
      data: (metrics) => SizedBox(
        height: 200,
        child: RiveAnimation.asset(
          'assets/budget_gauge.riv',
          controllers: [BudgetController(metrics.budgetPercent)],
        ),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
