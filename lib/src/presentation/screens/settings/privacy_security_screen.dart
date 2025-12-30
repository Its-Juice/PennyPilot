import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/privacy_provider.dart';
import 'package:pennypilot/src/presentation/providers/backup_provider.dart';
import 'package:pennypilot/src/presentation/providers/auth_provider.dart';
import 'package:pennypilot/src/services/backup_service.dart';
import 'package:pennypilot/src/services/auth_service.dart';

class PrivacySecurityScreen extends ConsumerWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final privacyService = ref.watch(privacyServiceProvider);
    final backupService = ref.watch(backupServiceProvider);
    final authService = ref.read(authServiceProvider);

    final isLocalOnly = ref.watch(isLocalOnlyModeProvider);
    final isBiometric = ref.watch(isBiometricEnabledProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security'),
      ),
      body: ListView(
        children: [
          // Security Section
          _buildSectionHeader(context, 'Security'),
          FutureBuilder<bool>(
            future: privacyService.canCheckBiometrics(),
            builder: (context, snapshot) {
              final canDoBiometrics = snapshot.data ?? false;
              return SwitchListTile(
                title: const Text('Biometric Lock'),
                subtitle: Text(canDoBiometrics 
                  ? 'Require authentication to open the app' 
                  : 'Biometrics not available on this device'),
                value: isBiometric,
                onChanged: canDoBiometrics ? (value) async {
                  if (value) {
                    final success = await privacyService.authenticate();
                    if (!success) return;
                  }
                  await privacyService.setBiometricEnabled(value);
                  ref.read(isBiometricEnabledProvider.notifier).state = value;
                } : null,
                secondary: Icon(Icons.fingerprint, color: theme.colorScheme.primary),
              );
            },
          ),
          SwitchListTile(
            title: const Text('Local-Only Mode'),
            subtitle: const Text('Disable all external connections except for OAuth authentication.'),
            value: isLocalOnly,
            onChanged: (value) async {
              await privacyService.setLocalOnlyMode(value);
              ref.read(isLocalOnlyModeProvider.notifier).state = value;
            },
            secondary: Icon(Icons.cloud_off, color: theme.colorScheme.primary),
          ),

          const Divider(),

          // Data Export Section
          _buildSectionHeader(context, 'Data Management'),
          ListTile(
            leading: Icon(Icons.file_download, color: theme.colorScheme.primary),
            title: const Text('Export JSON'),
            subtitle: const Text('Download all data in machine-readable format'),
            onTap: () async {
              try {
                // Using existing exportBackup (encrypted if passphrase provided, plain if not)
                await backupService.exportBackup(); 
              } catch (e) {
                if (context.mounted) _showError(context, e.toString());
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.table_chart, color: theme.colorScheme.primary),
            title: const Text('Export CSV'),
            subtitle: const Text('Open your transactions in Excel or Google Sheets'),
            onTap: () async {
              try {
                await backupService.exportToCsv();
              } catch (e) {
                if (context.mounted) _showError(context, e.toString());
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.upload_file, color: theme.colorScheme.secondary),
            title: const Text('Import Backup'),
            subtitle: const Text('Restore from a previously exported .isar file'),
            onTap: () async {
              try {
                await backupService.importBackup();
              } catch (e) {
                if (context.mounted) _showError(context, e.toString());
              }
            },
          ),

          const Divider(),

          // Danger Zone Section
          _buildSectionHeader(context, 'Danger Zone', isError: true),
          ListTile(
            leading: Icon(Icons.delete_forever, color: theme.colorScheme.error),
            title: Text('Nuclear Wipe', style: TextStyle(color: theme.colorScheme.error)),
            subtitle: const Text('Delete all transactions, categories, and disconnect accounts.'),
            onTap: () => _showWipeConfirmation(context, ref, backupService, authService),
          ),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, {bool isError = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: isError ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
      ),
    );
  }

  void _showWipeConfirmation(BuildContext context, WidgetRef ref, BackupService backupService, AuthService authService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you absolutely sure?'),
        content: const Text(
          'This is the Nuclear Option. It will permanently delete all your local data and disconnect your email accounts.\n\nThis action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            onPressed: () async {
              Navigator.pop(context);
              await backupService.nuclearWipe(authService);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All data has been wiped.')),
                );
              }
            },
            child: const Text('WIPE EVERYTHING'),
          ),
        ],
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Theme.of(context).colorScheme.error),
    );
  }
}
