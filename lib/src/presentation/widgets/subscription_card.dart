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
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withAlpha(51)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer.withAlpha(51),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      _getServiceIcon(),
                      color: theme.colorScheme.secondary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subscription.serviceName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            LifecycleBadge(
                              state: subscription.lifecycleState.name,
                              compact: true,
                            ),
                            if (subscription.isTrial) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.tertiaryContainer.withAlpha(51),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: theme.colorScheme.tertiary.withAlpha(26)),
                                ),
                                child: Text(
                                  'Trial',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.colorScheme.tertiary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
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
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AmountDisplay(
                        amount: subscription.amount,
                        currency: subscription.currency,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
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
                      color: theme.colorScheme.errorContainer.withAlpha(128),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.colorScheme.error.withAlpha(77)),
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
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(51),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(26)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
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
