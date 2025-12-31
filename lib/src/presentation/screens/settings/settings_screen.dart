import 'package:flutter/material.dart';
import 'package:pennypilot/src/presentation/screens/settings/manage_categories_screen.dart';
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
import 'package:pennypilot/src/localization/generated/app_localizations.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final connectedEmails = ref.watch(authServiceProvider).connectedEmails;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(l10n.settings),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _settingsSectionHeader(context, l10n.appearance),
                _appearanceSection(context, l10n),
                
                const SizedBox(height: 24),
                _settingsSectionHeader(context, l10n.accounts),
                _groupWrapper(
                  context,
                  child: ListTile(
                    leading: const Icon(Icons.manage_accounts),
                    title: Text(l10n.manageConnectedAccounts),
                    subtitle: Text(
                      connectedEmails.isEmpty 
                        ? l10n.noAccountsConnected 
                        : l10n.accountsConnected(connectedEmails.length)
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageAccountsScreen())),
                  ),
                ),

                const SizedBox(height: 24),
                _settingsSectionHeader(context, l10n.general),
                _groupWrapper(
                  context,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.currency_exchange),
                        title: Text(l10n.primaryCurrency),
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
                        leading: const Icon(Icons.language),
                        title: Text(l10n.language),
                        subtitle: Text(
                          _getLanguageName(ref.watch(appStateProvider).languageCode)
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _showLanguagePicker(context, ref),
                      ),
                      ListTile(
                        leading: const Icon(Icons.category),
                        title: Text(l10n.manageCategories),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageCategoriesScreen())),
                      ),
                      ListTile(
                        leading: const Icon(Icons.security),
                        title: Text(l10n.privacySecurity),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacySecurityScreen())),
                      ),
                      ListTile(
                        leading: const Icon(Icons.verified_user_outlined),
                        title: Text(l10n.privacyAudit),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyAuditScreen())),
                      ),
                      ListTile(
                        leading: const Icon(Icons.refresh),
                        title: Text(l10n.rescanEmails),
                        onTap: () => _rescanEmails(context, l10n),
                      ),
                      ListTile(
                        leading: const Icon(Icons.backup),
                        title: Text(l10n.backups),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BackupScreen())),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                _settingsSectionHeader(context, 'About'),
                _groupWrapper(
                  context,
                  child: ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text(l10n.aboutPennyPilot),
                    subtitle: const Text('Version 1.0.0-alpha.1.10'),
                    onTap: () => launchUrl(
                      Uri.parse('https://github.com/Its-Juice/PennyPilot'),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 16, 16, 12),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _groupWrapper(BuildContext context, {required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withAlpha(51)),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  Widget _appearanceSection(BuildContext context, AppLocalizations l10n) {
    final themeMode = ref.watch(themeModeProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SegmentedButton<ThemeMode>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(value: ThemeMode.light, label: Text(l10n.light), icon: const Icon(Icons.light_mode_outlined)),
              ButtonSegment(value: ThemeMode.dark, label: Text(l10n.dark), icon: const Icon(Icons.dark_mode_outlined)),
              ButtonSegment(value: ThemeMode.system, label: Text(l10n.system), icon: const Icon(Icons.brightness_auto)),
            ],
            selected: {themeMode.mode},
            onSelectionChanged: (Set<ThemeMode> newSelection) {
              ref.read(themeModeProvider.notifier).setThemeMode(newSelection.first);
            },
          ),
        ),
        const SizedBox(height: 12),
        _groupWrapper(
          context,
          child: SwitchListTile(
            title: Text(l10n.pitchBlackOled),
            subtitle: Text(l10n.oledDescription),
            value: themeMode.isOledMode,
            onChanged: (bool value) => ref.read(themeModeProvider.notifier).setOledMode(value),
            secondary: const Icon(Icons.auto_awesome),
          ),
        ),
      ],
    );
  }

  Future<void> _rescanEmails(BuildContext context, AppLocalizations l10n) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.scanningEmails)));
      await ref.read(emailServiceProvider).scanEmails();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.scanComplete)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.scanFailed(e.toString()))));
      }
    }
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
                AppLocalizations.of(context)!.selectCurrency,
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

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    final languages = [
      {'code': 'en', 'name': 'English', 'native': 'English'},
      {'code': 'de', 'name': 'German', 'native': 'Deutsch'},
      {'code': 'fr', 'name': 'French', 'native': 'Français'},
      {'code': 'el', 'name': 'Greek', 'native': 'Ελληνικά'},
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                AppLocalizations.of(context)!.selectLanguage,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...languages.map((lang) {
              final isSelected = ref.watch(appStateProvider).languageCode == lang['code'];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: isSelected
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: Text(
                    lang['native']![0].toUpperCase(),
                    style: TextStyle(
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                title: Text(lang['native']!),
                subtitle: Text(lang['name']!),
                trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
                onTap: () {
                  ref.read(appStateProvider.notifier).setLanguage(lang['code']);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  String _getLanguageName(String? code) {
    switch (code) {
      case 'de':
        return 'Deutsch';
      case 'fr':
        return 'Français';
      case 'el':
        return 'Ελληνικά';
      default:
        return 'English';
    }
  }
}
