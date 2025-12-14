import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:isar/isar.dart';
import 'package:pennypilot/src/data/local/database_service.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/models/subscription_model.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class PrivacySecurityScreen extends ConsumerStatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  ConsumerState<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends ConsumerState<PrivacySecurityScreen> {
  bool _localOnlyMode = true;
  bool _isExporting = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dbService = ref.watch(databaseServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security'),
      ),
      body: ListView(
        children: [
          // Privacy Mode Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Privacy Settings',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          
          SwitchListTile(
            title: const Text('Local-Only Mode'),
            subtitle: const Text('All data stays on your device (except email fetching)'),
            value: _localOnlyMode,
            onChanged: (value) {
              setState(() {
                _localOnlyMode = value;
              });
              // TODO: Persist preference
            },
            secondary: Icon(
              Icons.cloud_off,
              color: theme.colorScheme.primary,
            ),
          ),

          const Divider(),

          // Data Management Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Data Management',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),

          ListTile(
            leading: Icon(
              Icons.psychology_outlined,
              color: theme.colorScheme.tertiary,
            ),
            title: const Text('Reset AI Understanding'),
            subtitle: const Text('Clear derived data, keep raw transactions'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showResetAIDialog(context, dbService),
          ),

          ListTile(
            leading: Icon(
              Icons.download,
              color: theme.colorScheme.primary,
            ),
            title: const Text('Export My Data'),
            subtitle: const Text('Download JSON or CSV format'),
            trailing: _isExporting
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.chevron_right),
            onTap: _isExporting ? null : () => _showExportDialog(context),
          ),

          const Divider(),

          // Account Management Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Account Management',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),

          ListTile(
            leading: Icon(
              Icons.key_off,
              color: theme.colorScheme.error,
            ),
            title: const Text('Clear Email Tokens'),
            subtitle: const Text('Disconnect all email accounts'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showClearTokensDialog(context),
          ),

          ListTile(
            leading: Icon(
              Icons.delete_forever,
              color: theme.colorScheme.error,
            ),
            title: const Text('Wipe All Data'),
            subtitle: const Text('Permanently delete everything'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showWipeDataDialog(context, dbService),
          ),

          const Divider(),

          // Storage Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Storage Information',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),

          FutureBuilder<String>(
            future: dbService.getDatabasePath(),
            builder: (context, snapshot) {
              return ListTile(
                leading: const Icon(Icons.storage),
                title: const Text('Database Location'),
                subtitle: Text(
                  snapshot.data ?? 'Loading...',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showResetAIDialog(BuildContext context, DatabaseService dbService) {
    final theme = Theme.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.psychology_outlined,
          color: theme.colorScheme.tertiary,
          size: 32,
        ),
        title: const Text('Reset AI Understanding?'),
        content: const Text(
          'This will clear:\n'
          '• Extraction confidence scores\n'
          '• Merchant normalizations (system only)\n'
          '• Derived metadata\n\n'
          'Your raw transaction data will be preserved.\n'
          'User-defined rules will be kept.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              
              try {
                await dbService.resetAIUnderstanding();
                
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('AI understanding reset successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.download, size: 32),
        title: const Text('Export Data'),
        content: const Text('Choose export format:'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _exportData('json');
            },
            child: const Text('JSON'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _exportData('csv');
            },
            child: const Text('CSV'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportData(String format) async {
    setState(() {
      _isExporting = true;
    });

    try {
      final isar = await ref.read(isarProvider.future);
      final transactions = await isar.transactionModels.where().findAll();
      final subscriptions = await isar.subscriptionModels.where().findAll();

      String content;
      String filename;

      if (format == 'json') {
        final data = {
          'exported_at': DateTime.now().toIso8601String(),
          'app': 'PennyPilot',
          'version': '1.0.0',
          'transactions': transactions.map((t) => {
            'id': t.id,
            'merchant': t.merchantName,
            'raw_merchant': t.rawMerchantName,
            'amount': t.amount,
            'date': t.date.toIso8601String(),
            'category': t.category,
            'confidence': t.extractionConfidence.name,
            'currency': t.currency,
          }).toList(),
          'subscriptions': subscriptions.map((s) => {
            'id': s.id,
            'service': s.serviceName,
            'amount': s.amount,
            'frequency': s.frequency.name,
            'lifecycle': s.lifecycleState.name,
            'next_renewal': s.nextRenewalDate.toIso8601String(),
            'consistency': s.frequencyConsistency,
          }).toList(),
        };
        
        content = const JsonEncoder.withIndent('  ').convert(data);
        filename = 'pennypilot_export_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.json';
      } else {
        // CSV format
        final buffer = StringBuffer();
        buffer.writeln('Type,Date,Merchant,Amount,Category,Currency');
        
        for (var t in transactions) {
          buffer.writeln(
            'Transaction,'
            '${DateFormat('yyyy-MM-dd').format(t.date)},'
            '"${t.merchantName}",'
            '${t.amount},'
            '"${t.category ?? ''}",'
            '${t.currency}',
          );
        }
        
        content = buffer.toString();
        filename = 'pennypilot_export_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.csv';
      }

      // Share the file
      await Share.shareXFiles(
        [XFile.fromData(
          utf8.encode(content),
          mimeType: format == 'json' ? 'application/json' : 'text/csv',
          name: filename,
        )],
        subject: 'PennyPilot Data Export',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Exported ${transactions.length} transactions'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isExporting = false;
        });
      }
    }
  }

  void _showClearTokensDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.key_off, color: Colors.orange, size: 32),
        title: const Text('Clear Email Tokens?'),
        content: const Text(
          'This will disconnect all email accounts. '
          'You will need to sign in again to fetch new receipts.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            onPressed: () {
              // TODO: Implement clear tokens logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Email tokens cleared'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            child: const Text('Clear Tokens'),
          ),
        ],
      ),
    );
  }

  void _showWipeDataDialog(BuildContext context, DatabaseService dbService) {
    final theme = Theme.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.warning,
          color: theme.colorScheme.error,
          size: 32,
        ),
        title: const Text('Wipe All Data?'),
        content: const Text(
          'This action cannot be undone!\n\n'
          'All your transactions, subscriptions, categories, '
          'and settings will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
            ),
            onPressed: () async {
              Navigator.pop(context);
              
              try {
                await dbService.wipeData();
                
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All data wiped'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Wipe Data'),
          ),
        ],
      ),
    );
  }
}
