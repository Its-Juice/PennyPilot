import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/data/models/email_sender_preference_model.dart';
import 'package:pennypilot/src/presentation/widgets/empty_state.dart';
import 'package:intl/intl.dart';

// Email sender preferences provider
final emailSenderPreferencesProvider = StreamProvider<List<EmailSenderPreferenceModel>>((ref) async* {
  final isar = await ref.watch(isarProvider.future);
  
  yield* isar.emailSenderPreferenceModels
      .where()
      .sortByTotalEmailsProcessedDesc()
      .watch(fireImmediately: true);
});

class EmailScannerControlsScreen extends ConsumerStatefulWidget {
  const EmailScannerControlsScreen({super.key});

  @override
  ConsumerState<EmailScannerControlsScreen> createState() => _EmailScannerControlsScreenState();
}

class _EmailScannerControlsScreenState extends ConsumerState<EmailScannerControlsScreen> {
  bool _showOnlyEnabled = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sendersAsync = ref.watch(emailSenderPreferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Scanner Controls'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(context),
            tooltip: 'Help',
          ),
        ],
      ),
      body: sendersAsync.when(
        data: (senders) {
          if (senders.isEmpty) {
            return EmptyState(
              icon: Icons.email,
              title: 'No Email Senders Yet',
              message: 'Connect your email account to start scanning for receipts',
              action: FilledButton.icon(
                onPressed: () {
                  // TODO: Navigate to email connect
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email connection coming soon')),
                  );
                },
                icon: const Icon(Icons.email),
                label: const Text('Connect Email'),
              ),
            );
          }

          // Apply filter
          var filteredSenders = senders;
          if (_showOnlyEnabled) {
            filteredSenders = senders.where((s) => s.scanEnabled).toList();
          }

          return Column(
            children: [
              // Summary Card
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primaryContainer,
                      theme.colorScheme.secondaryContainer,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryItem(
                      context,
                      'Total Senders',
                      senders.length.toString(),
                      Icons.email,
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: theme.colorScheme.outline.withOpacity(0.3),
                    ),
                    _buildSummaryItem(
                      context,
                      'Enabled',
                      senders.where((s) => s.scanEnabled).length.toString(),
                      Icons.check_circle,
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: theme.colorScheme.outline.withOpacity(0.3),
                    ),
                    _buildSummaryItem(
                      context,
                      'Merchants',
                      senders.where((s) => s.isRecognizedMerchant).length.toString(),
                      Icons.store,
                    ),
                  ],
                ),
              ),

              // Filter Toggle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SwitchListTile(
                  title: const Text('Show Only Enabled'),
                  value: _showOnlyEnabled,
                  onChanged: (value) {
                    setState(() {
                      _showOnlyEnabled = value;
                    });
                  },
                  secondary: const Icon(Icons.filter_list),
                ),
              ),

              const Divider(),

              // Senders List
              Expanded(
                child: filteredSenders.isEmpty
                    ? EmptyState(
                        icon: Icons.filter_alt_off,
                        title: 'No Enabled Senders',
                        message: 'Enable some senders to see them here',
                        action: TextButton(
                          onPressed: () {
                            setState(() {
                              _showOnlyEnabled = false;
                            });
                          },
                          child: const Text('Show All'),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredSenders.length,
                        padding: const EdgeInsets.only(bottom: 16),
                        itemBuilder: (context, index) {
                          final sender = filteredSenders[index];
                          return _buildSenderCard(context, sender);
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const LoadingState(message: 'Loading email senders...'),
        error: (error, stack) => ErrorState(
          title: 'Failed to Load',
          message: error.toString(),
          onRetry: () => ref.refresh(emailSenderPreferencesProvider),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showDryRunDialog(context),
        icon: const Icon(Icons.preview),
        label: const Text('Dry Run'),
      ),
    );
  }

  Widget _buildSummaryItem(
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
          size: 20,
          color: theme.colorScheme.onPrimaryContainer,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onPrimaryContainer.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildSenderCard(BuildContext context, EmailSenderPreferenceModel sender) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, y');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ExpansionTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: sender.scanEnabled
                ? theme.colorScheme.primaryContainer
                : theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            sender.isRecognizedMerchant ? Icons.store : Icons.email,
            color: sender.scanEnabled
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
        title: Text(
          sender.senderDisplayName ?? sender.senderEmail,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          sender.senderDomain,
          style: theme.textTheme.bodySmall,
        ),
        trailing: Switch(
          value: sender.scanEnabled,
          onChanged: (value) => _toggleSenderScan(sender, value),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Statistics Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildStatBox(
                        context,
                        'Emails Processed',
                        sender.totalEmailsProcessed.toString(),
                        Icons.email,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatBox(
                        context,
                        'Transactions',
                        sender.totalTransactionsExtracted.toString(),
                        Icons.receipt,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatBox(
                        context,
                        'Avg Confidence',
                        sender.averageConfidence != null
                            ? '${(sender.averageConfidence! * 100).toStringAsFixed(0)}%'
                            : 'N/A',
                        Icons.psychology,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatBox(
                        context,
                        'Last Scan',
                        sender.lastScannedDate != null
                            ? dateFormat.format(sender.lastScannedDate!)
                            : 'Never',
                        Icons.schedule,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _rescanSender(sender),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Rescan'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _editSenderNotes(context, sender),
                        icon: const Icon(Icons.edit_note),
                        label: const Text('Notes'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 14,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _toggleSenderScan(EmailSenderPreferenceModel sender, bool enabled) async {
    final isar = await ref.read(isarProvider.future);
    
    await isar.writeTxn(() async {
      sender.scanEnabled = enabled;
      sender.updatedAt = DateTime.now();
      await isar.emailSenderPreferenceModels.put(sender);
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            enabled
                ? 'Enabled scanning for ${sender.senderDomain}'
                : 'Disabled scanning for ${sender.senderDomain}',
          ),
        ),
      );
    }
  }

  void _rescanSender(EmailSenderPreferenceModel sender) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Rescanning emails from ${sender.senderDomain}...'),
      ),
    );
    // TODO: Implement rescan logic
  }

  void _editSenderNotes(BuildContext context, EmailSenderPreferenceModel sender) {
    final controller = TextEditingController(text: sender.userNotes);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Notes'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Notes',
            hintText: 'Add notes about this sender...',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final isar = await ref.read(isarProvider.future);
              
              await isar.writeTxn(() async {
                sender.userNotes = controller.text.isEmpty ? null : controller.text;
                sender.updatedAt = DateTime.now();
                await isar.emailSenderPreferenceModels.put(sender);
              });
              
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notes saved')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDryRunDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.preview, size: 32),
        title: const Text('Dry Run Preview'),
        content: const Text(
          'This will show you what would be scanned from your emails '
          'without actually importing anything.\n\n'
          'This feature is coming soon!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dry run coming soon')),
              );
            },
            child: const Text('Run Preview'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.help_outline, size: 32),
        title: const Text('Email Scanner Help'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Per-Sender Controls',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Toggle scanning on/off for each email sender individually. '
                'This gives you fine-grained control over which merchants '
                'are tracked.',
              ),
              SizedBox(height: 16),
              Text(
                'Statistics',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '• Emails Processed: Total emails scanned\n'
                '• Transactions: Successfully extracted receipts\n'
                '• Avg Confidence: Average extraction quality\n'
                '• Last Scan: Most recent scan date',
              ),
              SizedBox(height: 16),
              Text(
                'Dry Run',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Preview what would be scanned without actually importing. '
                'Useful for testing your settings.',
              ),
            ],
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got It'),
          ),
        ],
      ),
    );
  }
}
