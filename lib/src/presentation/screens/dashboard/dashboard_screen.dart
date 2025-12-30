import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/navigation_provider.dart';
import 'package:pennypilot/src/presentation/screens/dashboard/overview_tab.dart';
import 'package:pennypilot/src/presentation/screens/transactions/transactions_screen.dart';
import 'package:pennypilot/src/presentation/screens/subscriptions/subscriptions_screen.dart';
import 'package:pennypilot/src/presentation/screens/insights/insights_screen.dart';
import 'package:pennypilot/src/presentation/screens/settings/settings_screen.dart';

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

    return Scaffold(
      body: Row(
        children: [
          if (isWideScreen)
            NavigationRail(
              selectedIndex: ref.watch(dashboardIndexProvider),
              onDestinationSelected: (index) {
                ref.read(dashboardIndexProvider.notifier).state = index;
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('Overview'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.receipt_long_outlined),
                  selectedIcon: Icon(Icons.receipt_long),
                  label: Text('Transactions'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.subscriptions_outlined),
                  selectedIcon: Icon(Icons.subscriptions),
                  label: Text('Subs'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.insights_outlined),
                  selectedIcon: Icon(Icons.insights),
                  label: Text('Insights'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: Text('Settings'),
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
          : BottomNavigationBar(
              currentIndex: ref.watch(dashboardIndexProvider),
              onTap: (index) {
                ref.read(dashboardIndexProvider.notifier).state = index;
              },
              backgroundColor: Theme.of(context).colorScheme.surface,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined),
                  activeIcon: Icon(Icons.dashboard),
                  label: 'Overview',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_outlined),
                  activeIcon: Icon(Icons.receipt_long),
                  label: 'Transactions',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.subscriptions_outlined),
                  activeIcon: Icon(Icons.subscriptions),
                  label: 'Subs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.insights_outlined),
                  activeIcon: Icon(Icons.insights),
                  label: 'Insights',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  activeIcon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
    );
  }
}
