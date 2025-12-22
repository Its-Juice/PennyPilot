import 'package:flutter/material.dart';
import 'package:pennypilot/src/presentation/screens/settings/privacy_security_screen.dart';
import 'package:pennypilot/src/presentation/screens/settings/backup_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/theme_provider.dart';
import 'package:pennypilot/src/presentation/providers/email_provider.dart';
import 'package:pennypilot/src/presentation/providers/auth_provider.dart';
import 'package:pennypilot/src/presentation/screens/settings/privacy_audit_screen.dart';
import 'package:pennypilot/src/presentation/screens/settings/manage_accounts_screen.dart';
import 'package:pennypilot/src/presentation/providers/app_state_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  int _aboutTapCount = 0;

  @override
  Widget build(BuildContext context) {
    final connectedEmails = ref.watch(authServiceProvider).connectedEmails;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Appearance Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Appearance',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('System'),
                  icon: Icon(Icons.brightness_auto),
                ),
              ],
              selected: {ref.watch(themeModeProvider).mode},
              onSelectionChanged: (Set<ThemeMode> newSelection) {
                ref.read(themeModeProvider.notifier).setThemeMode(newSelection.first);
              },
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Pitch Black OLED'),
            subtitle: const Text('Completely black background for OLED screens'),
            value: ref.watch(themeModeProvider).isOledMode,
            onChanged: (bool value) {
              ref.read(themeModeProvider.notifier).setOledMode(value);
            },
            secondary: const Icon(Icons.auto_awesome),
          ),
          
          const Divider(height: 32),

          // Accounts Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              'Accounts',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.manage_accounts),
            title: const Text('Manage connected accounts'),
            subtitle: Text(
              connectedEmails.isEmpty 
                ? 'No accounts connected' 
                : '${connectedEmails.length} account(s) connected'
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageAccountsScreen()),
              );
            },
          ),
          const Divider(height: 32),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              'General',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.currency_exchange),
            title: const Text('Primary Currency'),
            subtitle: Text(
              popularCurrencies
                  .firstWhere((c) => c.code == ref.watch(appStateProvider).currencyCode, 
                      orElse: () => popularCurrencies.first)
                  .name
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showCurrencyPicker(context, ref),
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privacy & Security'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacySecurityScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.verified_user_outlined),
            title: const Text('Privacy Audit'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyAuditScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text('Rescan Emails'),
            onTap: () async {
              try {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Scanning emails...')),
                );
                await ref.read(emailServiceProvider).scanEmails();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Scan complete')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Scan failed: $e')),
                  );
                }
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('Backups'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BackupScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About PennyPilot'),
            subtitle: Text(
              'Version alpha.1.2${_aboutTapCount == 1 ? ' (Press 2 more to open GitHub)' : _aboutTapCount == 2 ? ' (Press 1 more to open GitHub)' : ''}',
            ),
            onTap: () {
              setState(() {
                _aboutTapCount++;
              });
              if (_aboutTapCount >= 3) {
                setState(() {
                  _aboutTapCount = 0;
                });
                launchUrl(Uri.parse('https://github.com/Its-Juice/PennyPilot'), mode: LaunchMode.externalApplication);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showCurrencyPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Select Currency',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: popularCurrencies.length,
                itemBuilder: (context, index) {
                  final currency = popularCurrencies[index];
                  final isSelected = ref.watch(appStateProvider).currencyCode == currency.code;
                  
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isSelected 
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.surfaceContainerHigh,
                      child: Text(
                        currency.symbol,
                        style: TextStyle(
                          color: isSelected
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    title: Text(currency.name),
                    subtitle: Text(currency.code),
                    trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
                    onTap: () {
                      ref.read(appStateProvider.notifier).setCurrency(currency.code);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
