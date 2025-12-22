import 'package:flutter/material.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/presentation/widgets/confidence_badge.dart';
import 'package:pennypilot/src/presentation/widgets/amount_display.dart';
import 'package:pennypilot/src/presentation/widgets/manual_edit_badge.dart';
import 'package:pennypilot/src/presentation/screens/transactions/edit_transaction_screen.dart';
import 'package:pennypilot/src/presentation/screens/transactions/split_transaction_sheet.dart';
import 'package:intl/intl.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailsScreen({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('EEEE, MMMM d, y');
    final timeFormat = DateFormat('h:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  builder: (context) => EditTransactionScreen(
                    transaction: transaction,
                  ),
                ),
              );
              
              // If edit was successful, pop back to refresh the list
              if (result == true && context.mounted) {
                Navigator.of(context).pop();
              }
            },
            tooltip: 'Edit',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Merchant Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.receipt_long,
                      size: 40,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    transaction.merchantName,
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  if (transaction.isManuallyEdited) ...[ 
                    const SizedBox(height: 8),
                    const ManualEditBadge(compact: false),
                  ],
                  if (transaction.rawMerchantName != null &&
                      transaction.rawMerchantName != transaction.merchantName) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_fix_high,
                            size: 14,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Original: ${transaction.rawMerchantName}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  AmountDisplay(
                    amount: transaction.amount,
                    currency: transaction.currency,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Details Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  
                  _buildDetailRow(
                    context,
                    icon: Icons.calendar_today,
                    label: 'Date',
                    value: dateFormat.format(transaction.date),
                  ),
                  
                  _buildDetailRow(
                    context,
                    icon: Icons.access_time,
                    label: 'Time',
                    value: timeFormat.format(transaction.date),
                  ),
                  
                  _buildDetailRow(
                    context,
                    icon: transaction.kind == TransactionKind.income 
                        ? Icons.arrow_downward 
                        : Icons.arrow_upward,
                    label: 'Type',
                    value: transaction.kind.name[0].toUpperCase() + transaction.kind.name.substring(1),
                  ),

                  if (transaction.isRecurring)
                    _buildDetailRow(
                      context,
                      icon: Icons.repeat,
                      label: 'Recurring',
                      value: 'Yes',
                    ),

                  if (transaction.category != null)
                    _buildDetailRow(
                      context,
                      icon: Icons.category,
                      label: 'Category',
                      value: transaction.category!,
                    ),
                  
                  _buildDetailRow(
                    context,
                    icon: Icons.attach_money,
                    label: 'Currency',
                    value: transaction.currency,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Breakdown Section (if available)
          if (transaction.hasLineItems) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Breakdown',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    
                    if (transaction.subtotalAmount != null)
                      _buildBreakdownRow(
                        context,
                        'Subtotal',
                        transaction.subtotalAmount!,
                        transaction.currency,
                      ),
                    
                    if (transaction.taxAmount != null)
                      _buildBreakdownRow(
                        context,
                        'Tax',
                        transaction.taxAmount!,
                        transaction.currency,
                      ),
                    
                    if (transaction.discountAmount != null)
                      _buildBreakdownRow(
                        context,
                        'Discount',
                        -transaction.discountAmount!,
                        transaction.currency,
                        isDiscount: true,
                      ),
                    
                    if (transaction.tipAmount != null)
                      _buildBreakdownRow(
                        context,
                        'Tip',
                        transaction.tipAmount!,
                        transaction.currency,
                      ),
                    
                    const Divider(height: 24),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: theme.textTheme.titleMedium,
                        ),
                        AmountDisplay(
                          amount: transaction.amount,
                          currency: transaction.currency,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Extraction Info Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Extraction Information',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Confidence',
                        style: theme.textTheme.bodyMedium,
                      ),
                      ConfidenceBadge(
                        level: transaction.extractionConfidence.name,
                        compact: false,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Has Line Items',
                        style: theme.textTheme.bodyMedium,
                      ),
                      Icon(
                        transaction.hasLineItems
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: transaction.hasLineItems
                            ? Colors.green
                            : theme.colorScheme.outline,
                        size: 20,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'User Verified',
                        style: theme.textTheme.bodyMedium,
                      ),
                      Icon(
                        transaction.userVerified
                            ? Icons.verified
                            : Icons.pending,
                        color: transaction.userVerified
                            ? Colors.blue
                            : theme.colorScheme.outline,
                        size: 20,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Source',
                        style: theme.textTheme.bodyMedium,
                      ),
                      Row(
                        children: [
                          Icon(
                            transaction.origin == TransactionOrigin.emailDetected 
                                ? Icons.email 
                                : transaction.origin == TransactionOrigin.manual
                                    ? Icons.edit
                                    : Icons.file_upload,
                            size: 16,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            transaction.origin == TransactionOrigin.emailDetected
                                ? 'Email'
                                : transaction.origin == TransactionOrigin.manual
                                    ? 'Manual Entry'
                                    : 'Imported',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Notes Section
          if (transaction.notes != null) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notes',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      transaction.notes!,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Mark as verified
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Marked as verified')),
                    );
                  },
                  icon: const Icon(Icons.verified),
                  label: const Text('Verify'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    // TODO: Add note
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Add note coming soon')),
                    );
                  },
                  icon: const Icon(Icons.note_add),
                  label: const Text('Add Note'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => SplitTransactionSheet(
                    transaction: transaction,
                  ),
                );
              },
              icon: const Icon(Icons.call_split),
              label: const Text('Split Bill'),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(
    BuildContext context,
    String label,
    double amount,
    String currency, {
    bool isDiscount = false,
  }) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AmountDisplay(
            amount: amount,
            currency: currency,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDiscount
                  ? theme.colorScheme.tertiary
                  : theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            showSign: isDiscount,
          ),
        ],
      ),
    );
  }
}
