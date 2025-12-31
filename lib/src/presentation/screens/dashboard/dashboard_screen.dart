import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/navigation_provider.dart';
import 'package:pennypilot/src/presentation/screens/dashboard/overview_tab.dart';
import 'package:pennypilot/src/presentation/screens/transactions/transactions_screen.dart';
import 'package:pennypilot/src/presentation/screens/subscriptions/subscriptions_screen.dart';
import 'package:pennypilot/src/presentation/screens/insights/insights_screen.dart';
import 'package:pennypilot/src/presentation/screens/settings/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  final bool isDemoMode;

  const DashboardScreen({super.key, this.isDemoMode = false});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      OverviewTab(isDemoMode: widget.isDemoMode),
      const TransactionsScreen(),
      const SubscriptionsScreen(),
      const InsightsScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;
    final l10n = AppLocalizations.of(context)!;


    return Scaffold(
      body: Row(
        children: [
          if (isWideScreen)
            NavigationRail(
              selectedIndex: ref.watch(dashboardIndexProvider),
              onDestinationSelected: (index) {
                ref.read(dashboardIndexProvider.notifier).state = index;
              },
              extended: MediaQuery.of(context).size.width > 900,
              labelType: MediaQuery.of(context).size.width > 900 
                  ? NavigationRailLabelType.none 
                  : NavigationRailLabelType.all,
              indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
              destinations: [
                NavigationRailDestination(
                  icon: const Icon(Icons.dashboard_outlined),
                  selectedIcon: const Icon(Icons.dashboard),
                  label: Text(l10n.overview),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.receipt_long_outlined),
                  selectedIcon: const Icon(Icons.receipt_long),
                  label: Text(l10n.transactions),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.subscriptions_outlined),
                  selectedIcon: const Icon(Icons.subscriptions),
                  label: Text(l10n.subs),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.insights_outlined),
                  selectedIcon: const Icon(Icons.insights),
                  label: Text(l10n.insights),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings),
                  label: Text(l10n.settings),
                ),
              ],
            ),
          Expanded(
            child: _screens[ref.watch(dashboardIndexProvider)],
          ),
        ],
      ),
      bottomNavigationBar: isWideScreen
          ? null
          : NavigationBar(
              selectedIndex: ref.watch(dashboardIndexProvider),
              onDestinationSelected: (index) {
                ref.read(dashboardIndexProvider.notifier).state = index;
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.dashboard_outlined),
                  selectedIcon: const Icon(Icons.dashboard),
                  label: l10n.overview,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.receipt_long_outlined),
                  selectedIcon: const Icon(Icons.receipt_long),
                  label: l10n.transactions,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.subscriptions_outlined),
                  selectedIcon: const Icon(Icons.subscriptions),
                  label: l10n.subs,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.insights_outlined),
                  selectedIcon: const Icon(Icons.insights),
                  label: l10n.insights,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings),
                  label: l10n.settings,
                ),
              ],
            ),
    );
  }
}
