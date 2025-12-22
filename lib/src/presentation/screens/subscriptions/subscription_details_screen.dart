import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/data/models/subscription_model.dart';
import 'package:pennypilot/src/presentation/widgets/lifecycle_badge.dart';
import 'package:pennypilot/src/presentation/widgets/amount_display.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/services/subscription_intelligence_service.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/presentation/providers/app_state_provider.dart';

class SubscriptionDetailsScreen extends ConsumerWidget {
  final SubscriptionModel subscription;

  const SubscriptionDetailsScreen({
    super.key,
    required this.subscription,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, y');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement edit
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit coming soon')),
              );
            },
            tooltip: 'Edit',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      _getServiceIcon(),
                      size: 40,
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    subscription.serviceName,
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LifecycleBadge(
                        state: subscription.lifecycleState.name,
                        compact: false,
                      ),
                      if (subscription.isTrial) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Trial',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onTertiaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  AmountDisplay(
                    amount: subscription.amount,
                    currency: subscription.currency,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _getFrequencyLabel(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Details Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  
                  _buildDetailRow(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Next Renewal',
                    value: dateFormat.format(subscription.nextRenewalDate),
                  ),
                  
                  _buildDetailRow(
                    context,
                    icon: Icons.history,
                    label: 'First Seen',
                    value: dateFormat.format(subscription.firstSeenDate),
                  ),
                  
                  if (subscription.lastChargedDate != null)
                    _buildDetailRow(
                      context,
                      icon: Icons.payment,
                      label: 'Last Charged',
                      value: dateFormat.format(subscription.lastChargedDate!),
                    ),
                  
                  _buildDetailRow(
                    context,
                    icon: Icons.repeat,
                    label: 'Consistency',
                    value: '${subscription.frequencyConsistency}%',
                  ),
                  
                  _buildDetailRow(
                    context,
                    icon: Icons.receipt,
                    label: 'Total Charges',
                    value: subscription.chargeCount.toString(),
                  ),
                  
                  if (subscription.averageDaysBetweenCharges != null)
                    _buildDetailRow(
                      context,
                      icon: Icons.schedule,
                      label: 'Avg Days Between',
                      value: subscription.averageDaysBetweenCharges!.toStringAsFixed(1),
                    ),
                  
                  _buildDetailRow(
                    context,
                    icon: Icons.source,
                    label: 'Detection Source',
                    value: _getDetectionSourceLabel(),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Price History Card
          if (subscription.priceHistoryJson != null) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Price History',
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    FutureBuilder<List<PriceChange>>(
                      future: _getPriceChanges(ref),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Text(
                            'No price changes detected',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          );
                        }

                        return Column(
                          children: snapshot.data!.map((change) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Icon(
                                    change.changePercent > 0
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    size: 16,
                                    color: change.changePercent > 0
                                        ? Colors.orange
                                        : Colors.green,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      dateFormat.format(change.date),
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ),
                                  Text(
                                    '${popularCurrencies.firstWhere((c) => c.code == subscription.currency).symbol}${change.oldAmount.toStringAsFixed(2)} → ${popularCurrencies.firstWhere((c) => c.code == subscription.currency).symbol}${change.newAmount.toStringAsFixed(2)}',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (change.changePercent > 0
                                              ? Colors.orange
                                              : Colors.green)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '${change.changePercent > 0 ? '+' : ''}${change.changePercent.toStringAsFixed(1)}%',
                                      style: theme.textTheme.labelSmall?.copyWith(
                                        color: change.changePercent > 0
                                            ? Colors.orange
                                            : Colors.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Cycle History Card
          if (subscription.cycleHistoryJson != null) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.autorenew,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Billing Cycle History',
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    FutureBuilder<List<CycleChange>>(
                      future: _getCycleChanges(ref),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Text(
                            'No cycle changes detected',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          );
                        }

                        return Column(
                          children: snapshot.data!.map((change) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.swap_horiz,
                                    size: 16,
                                    color: theme.colorScheme.tertiary,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      dateFormat.format(change.date),
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ),
                                  Text(
                                    '${_frequencyName(change.oldFrequency)} → ${_frequencyName(change.newFrequency)}',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Notes Card
          if (subscription.notes != null) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notes',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subscription.notes!,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Mark as cancelled
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Marked as cancelled')),
                    );
                  },
                  icon: const Icon(Icons.cancel),
                  label: const Text('Mark Cancelled'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    // TODO: Add note
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Add note coming soon')),
                    );
                  },
                  icon: const Icon(Icons.note_add),
                  label: const Text('Add Note'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<List<PriceChange>> _getPriceChanges(WidgetRef ref) async {
    final service = ref.read(subscriptionIntelligenceServiceProvider);
    return await service.detectPriceChanges(subscription.id);
  }

  Future<List<CycleChange>> _getCycleChanges(WidgetRef ref) async {
    final service = ref.read(subscriptionIntelligenceServiceProvider);
    return await service.detectCycleChanges(subscription.id);
  }

  String _getFrequencyLabel() {
    switch (subscription.frequency) {
      case SubscriptionFrequency.weekly:
        return 'per week';
      case SubscriptionFrequency.biweekly:
        return 'bi-weekly';
      case SubscriptionFrequency.monthly:
        return 'per month';
      case SubscriptionFrequency.quarterly:
        return 'per quarter';
      case SubscriptionFrequency.semiannual:
        return 'semi-annual';
      case SubscriptionFrequency.yearly:
        return 'per year';
      case SubscriptionFrequency.unknown:
        return 'frequency unknown';
    }
  }

  String _getDetectionSourceLabel() {
    switch (subscription.detectionSource) {
      case SubscriptionDetectionSource.email:
        return 'Email';
      case SubscriptionDetectionSource.manual:
        return 'Manual';
      case SubscriptionDetectionSource.pattern:
        return 'Pattern Detection';
      case SubscriptionDetectionSource.keyword:
        return 'Keyword';
    }
  }

  String _frequencyName(SubscriptionFrequency freq) {
    return freq.name[0].toUpperCase() + freq.name.substring(1);
  }

  IconData _getServiceIcon() {
    final service = subscription.serviceName.toLowerCase();
    
    if (service.contains('netflix')) return Icons.movie;
    if (service.contains('spotify')) return Icons.music_note;
    if (service.contains('youtube')) return Icons.play_circle;
    if (service.contains('amazon') || service.contains('prime')) {
      return Icons.shopping_bag;
    }
    if (service.contains('apple') || service.contains('icloud')) {
      return Icons.apple;
    }
    if (service.contains('google') || service.contains('drive')) {
      return Icons.cloud;
    }
    
    return Icons.subscriptions;
  }
}
