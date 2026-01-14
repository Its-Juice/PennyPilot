import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/presentation/widgets/subscription_card.dart';
import 'package:pennypilot/src/presentation/widgets/empty_state.dart';
import 'package:pennypilot/src/presentation/widgets/amount_display.dart';
import 'package:pennypilot/src/data/models/subscription_model.dart';

import 'package:pennypilot/src/presentation/screens/subscriptions/add_subscription_sheet.dart';
import 'package:pennypilot/src/localization/generated/app_localizations.dart';

class SubscriptionsScreen extends ConsumerStatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  ConsumerState<SubscriptionsScreen> createState() =>
      _SubscriptionsScreenState();
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
    final subscriptionsAsync = ref.watch(subscriptionsProvider);
    final statsAsync = ref.watch(subscriptionStatsProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(l10n.subscriptions),
          ),
          subscriptionsAsync.when(
            data: (subscriptions) {
              if (subscriptions.isEmpty) {
                return SliverFillRemaining(
                  child: EmptyState(
                    icon: Icons.subscriptions,
                    title: l10n.noSubscriptionsFound,
                    message: l10n.noSubscriptionsDescription,
                    action: FilledButton.icon(
                      onPressed: _showAddSheet,
                      icon: const Icon(Icons.add),
                      label: Text(l10n.addManually),
                    ),
                  ),
                );
              }

              var filteredSubscriptions = subscriptions;
              if (_filter != 'all') {
                final filterState = _getLifecycleState(_filter);
                filteredSubscriptions = subscriptions
                    .where((s) => s.lifecycleState == filterState)
                    .toList();
              }

              return SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: statsAsync.when(
                      data: (stats) => _buildRefinedStats(context, stats),
                      loading: () => const SizedBox(height: 100),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 56,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildFilterChip(l10n.all, 'all'),
                          _buildFilterChip(l10n.active, 'active'),
                          _buildFilterChip(l10n.trial, 'trial'),
                          _buildFilterChip(l10n.paused, 'paused'),
                          _buildFilterChip(l10n.ended, 'ended'),
                        ],
                      ),
                    ),
                  ),
                  if (filteredSubscriptions.isEmpty)
                    SliverFillRemaining(
                      child: EmptyState(
                        icon: Icons.filter_alt_off,
                        title: l10n.noFilteredSubscriptions(_filter == 'all'
                            ? l10n.all
                            : _filter.toUpperCase()),
                        message: l10n.trySelectingDifferentFilter,
                        action: TextButton(
                          onPressed: () => setState(() => _filter = 'all'),
                          child: Text(l10n.showAll),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.only(bottom: 32),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final subscription = filteredSubscriptions[index];
                            return SubscriptionCard(
                              subscription: subscription,
                              showDetails: true,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(l10n.detailsFor(
                                          subscription.serviceName))),
                                );
                              },
                            );
                          },
                          childCount: filteredSubscriptions.length,
                        ),
                      ),
                    ),
                ],
              );
            },
            loading: () => const SliverFillRemaining(child: LoadingState()),
            error: (error, stack) => SliverFillRemaining(
              child: ErrorState(
                title: l10n.failedToLoad,
                message: error.toString(),
                onRetry: () => ref.refresh(subscriptionsProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefinedStats(BuildContext context, Map<String, dynamic> stats) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final monthlyTotal = stats['totalMonthlySpend'] ?? 0.0;
    final annualTotal = monthlyTotal * 12;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withAlpha(12),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        border:
            Border.all(color: theme.colorScheme.outlineVariant.withAlpha(51)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.monthlySpend.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AmountDisplay(
                      amount: monthlyTotal,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 40,
                  width: 1,
                  color: theme.colorScheme.outlineVariant.withAlpha(51)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PROJECTED ANNUAL',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      AmountDisplay(
                        amount: annualTotal,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1),
          const SizedBox(height: 20),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                    context,
                    l10n.active,
                    stats['active']?.toString() ?? '0',
                    Icons.check_circle_rounded),
                _buildStatItem(context, l10n.trial,
                    stats['trial']?.toString() ?? '0', Icons.bolt_rounded),
                _buildStatItem(
                    context,
                    l10n.paused,
                    stats['paused']?.toString() ?? '0',
                    Icons.pause_circle_rounded),
                _buildStatItem(context, l10n.ended,
                    stats['ended']?.toString() ?? '0', Icons.cancel_rounded),
              ],
            ),
          ),
        ],
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
          color: theme.colorScheme.onSecondaryContainer.withAlpha(204),
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
            color: theme.colorScheme.onSecondaryContainer.withAlpha(178),
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
