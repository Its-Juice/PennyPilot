import 'package:flutter/material.dart';
import 'package:pennypilot/src/data/models/subscription_model.dart';
import 'package:pennypilot/src/presentation/widgets/amount_display.dart';
import 'package:pennypilot/src/presentation/widgets/lifecycle_badge.dart';
import 'package:intl/intl.dart';

/// Enhanced subscription card with lifecycle state and intelligence
class SubscriptionCard extends StatelessWidget {
  final SubscriptionModel subscription;
  final VoidCallback? onTap;
  final bool showDetails;

  const SubscriptionCard({
    super.key,
    required this.subscription,
    this.onTap,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, y');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  // Service icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getServiceIcon(),
                      color: theme.colorScheme.onSecondaryContainer,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Service name and lifecycle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subscription.serviceName,
                          style: theme.textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            LifecycleBadge(
                              state: subscription.lifecycleState.name,
                              compact: false,
                            ),
                            if (subscription.isTrial) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.tertiaryContainer,
                                  borderRadius: BorderRadius.circular(6),
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
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Amount
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AmountDisplay(
                        amount: subscription.amount,
                        currency: subscription.currency,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _getFrequencyLabel(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              if (showDetails) ...[
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 12),

                // Details grid
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailItem(
                        context,
                        icon: Icons.calendar_today,
                        label: 'Next Renewal',
                        value: dateFormat.format(subscription.nextRenewalDate),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDetailItem(
                        context,
                        icon: Icons.repeat,
                        label: 'Consistency',
                        value: '${subscription.frequencyConsistency}%',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildDetailItem(
                        context,
                        icon: Icons.history,
                        label: 'First Seen',
                        value: dateFormat.format(subscription.firstSeenDate),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDetailItem(
                        context,
                        icon: Icons.receipt,
                        label: 'Charges',
                        value: '${subscription.chargeCount}',
                      ),
                    ),
                  ],
                ),

                if (subscription.isZombie) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.colorScheme.error.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber_rounded, size: 20, color: theme.colorScheme.error),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Potential Zombie Subscription',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.error,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (subscription.zombieReason != null)
                                Text(
                                  subscription.zombieReason!,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onErrorContainer,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
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
    if (service.contains('dropbox')) return Icons.folder;
    if (service.contains('adobe')) return Icons.design_services;
    if (service.contains('microsoft') || service.contains('office')) {
      return Icons.business;
    }
    if (service.contains('gym') || service.contains('fitness')) {
      return Icons.fitness_center;
    }
    
    return Icons.subscriptions;
  }
}
