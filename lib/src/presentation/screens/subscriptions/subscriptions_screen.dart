import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/presentation/widgets/subscription_card.dart';
import 'package:pennypilot/src/presentation/widgets/empty_state.dart';
import 'package:pennypilot/src/presentation/widgets/amount_display.dart';
import 'package:pennypilot/src/data/models/subscription_model.dart';

import 'package:pennypilot/src/presentation/screens/subscriptions/add_subscription_sheet.dart';
import 'package:pennypilot/src/core/utils/page_transitions.dart';

class SubscriptionsScreen extends ConsumerStatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  ConsumerState<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends ConsumerState<SubscriptionsScreen> {
  String _filter = 'all'; // 'all', 'active', 'trial', 'paused', 'ended'

  void _showAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddSubscriptionSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subscriptionsAsync = ref.watch(subscriptionsProvider);
    final statsAsync = ref.watch(subscriptionStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscriptions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddSheet,
            tooltip: 'Add Subscription',
          ),
        ],
      ),
      body: subscriptionsAsync.when(
        data: (subscriptions) {
          if (subscriptions.isEmpty) {
            return EmptyState(
              icon: Icons.subscriptions,
              title: 'No Subscriptions Found',
              message: 'We\'ll automatically detect subscriptions from your transactions, or you can add them manually.',
              action: FilledButton.icon(
                onPressed: _showAddSheet,
                icon: const Icon(Icons.add),
                label: const Text('Add Manually'),
              ),
            );
          }

          // Apply filter
          var filteredSubscriptions = subscriptions;
          if (_filter != 'all') {
            final filterState = _getLifecycleState(_filter);
            filteredSubscriptions = subscriptions
                .where((s) => s.lifecycleState == filterState)
                .toList();
          }

          return Column(
            children: [
              // Statistics Card
              statsAsync.when(
                data: (stats) => Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.colorScheme.secondaryContainer,
                        theme.colorScheme.tertiaryContainer,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Monthly Spend',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSecondaryContainer,
                            ),
                          ),
                          AmountDisplay(
                            amount: stats['totalMonthlySpend'] ?? 0.0,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: theme.colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem(
                            context,
                            'Active',
                            stats['active']?.toString() ?? '0',
                            Icons.check_circle,
                          ),
                          _buildStatItem(
                            context,
                            'Trial',
                            stats['trial']?.toString() ?? '0',
                            Icons.schedule,
                          ),
                          _buildStatItem(
                            context,
                            'Paused',
                            stats['paused']?.toString() ?? '0',
                            Icons.pause_circle,
                          ),
                          _buildStatItem(
                            context,
                            'Ended',
                            stats['ended']?.toString() ?? '0',
                            Icons.cancel,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                loading: () => const SizedBox(height: 120),
                error: (_, __) => const SizedBox(height: 120),
              ),

              // Filter Chips
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFilterChip('All', 'all'),
                    _buildFilterChip('Active', 'active'),
                    _buildFilterChip('Trial', 'trial'),
                    _buildFilterChip('Paused', 'paused'),
                    _buildFilterChip('Ended', 'ended'),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Subscription List
              Expanded(
                child: filteredSubscriptions.isEmpty
                    ? EmptyState(
                        icon: Icons.filter_alt_off,
                        title: 'No ${_filter == 'all' ? '' : _filter.toUpperCase()} Subscriptions',
                        message: 'Try selecting a different filter',
                        action: TextButton(
                          onPressed: () {
                            setState(() {
                              _filter = 'all';
                            });
                          },
                          child: const Text('Show All'),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredSubscriptions.length,
                        padding: const EdgeInsets.only(bottom: 16),
                        itemBuilder: (context, index) {
                          final subscription = filteredSubscriptions[index];
                          return SubscriptionCard(
                            subscription: subscription,
                            showDetails: true,
                            onTap: () {
                              // TODO: Navigate to subscription details
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Details for ${subscription.serviceName}'),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const LoadingState(message: 'Loading subscriptions...'),
        error: (error, stack) => ErrorState(
          title: 'Failed to Load',
          message: error.toString(),
          onRetry: () => ref.refresh(subscriptionsProvider),
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 18,
          color: theme.colorScheme.onSecondaryContainer.withOpacity(0.8),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSecondaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSecondaryContainer.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: _filter == value,
        onSelected: (selected) {
          setState(() {
            _filter = value;
          });
        },
      ),
    );
  }

  SubscriptionLifecycleState _getLifecycleState(String filter) {
    switch (filter) {
      case 'active':
        return SubscriptionLifecycleState.active;
      case 'trial':
        return SubscriptionLifecycleState.trial;
      case 'paused':
        return SubscriptionLifecycleState.paused;
      case 'ended':
        return SubscriptionLifecycleState.ended;
      default:
        return SubscriptionLifecycleState.active;
    }
  }
}
