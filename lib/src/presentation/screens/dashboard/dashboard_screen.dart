import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/navigation_provider.dart';
import 'package:pennypilot/src/presentation/screens/dashboard/overview_tab.dart';
import 'package:pennypilot/src/presentation/screens/transactions/transactions_screen.dart';
import 'package:pennypilot/src/presentation/screens/subscriptions/subscriptions_screen.dart';
import 'package:pennypilot/src/presentation/screens/insights/insights_screen.dart';
import 'package:pennypilot/src/presentation/screens/settings/settings_screen.dart';
import 'package:pennypilot/src/localization/generated/app_localizations.dart';
import 'package:pennypilot/src/presentation/screens/transactions/add_transaction_sheet.dart';
import 'package:pennypilot/src/presentation/screens/subscriptions/add_subscription_sheet.dart';
import 'package:pennypilot/src/presentation/screens/transactions/receipt_scan_screen.dart';
import 'package:pennypilot/src/presentation/widgets/status_dialogs.dart';
import 'package:pennypilot/src/presentation/providers/email_provider.dart';

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
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeOut),
                    ),
                    child: child,
                  ),
                );
              },
              child: Container(
                key: ValueKey(ref.watch(dashboardIndexProvider)),
                child: _screens[ref.watch(dashboardIndexProvider)],
              ),
            ),
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
      floatingActionButton: ref.watch(dashboardIndexProvider) < 4 
          ? FloatingActionButton(
              onPressed: () => _showActionMenu(context),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _showActionMenu(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.receipt_long),
                title: Text(l10n.addEntry),
                onPressed: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) => const AddTransactionSheet(),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.subscriptions),
                title: Text(l10n.addSubscription),
                onPressed: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    builder: (context) => const AddSubscriptionSheet(),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.document_scanner),
                title: Text(l10n.scanReceipt),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReceiptScanScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.sync),
                title: Text(l10n.scanEmails),
                onPressed: () async {
                  Navigator.pop(context);
                  _performEmailScan(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performEmailScan(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const ScanningDialog(),
      );
      
      final count = await ref.read(emailServiceProvider).scanEmails();
      
      if (context.mounted) {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) => SuccessDialog(count: count),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorScanning(e.toString())), 
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
