import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/presentation/providers/transaction_provider.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/presentation/providers/app_state_provider.dart';

class EditTransactionScreen extends ConsumerStatefulWidget {
  final TransactionModel transaction;

  const EditTransactionScreen({
    super.key,
    required this.transaction,
  });

  @override
  ConsumerState<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends ConsumerState<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _merchantController;
  late TextEditingController _amountController;
  late TextEditingController _notesController;
  late DateTime _selectedDate;
  late String _selectedCategory;
  late bool _isRecurring;
  late bool _isSubscription;
  late TransactionKind _transactionKind;
  
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _merchantController = TextEditingController(text: widget.transaction.merchantName);
    _amountController = TextEditingController(text: widget.transaction.amount.toStringAsFixed(2));
    _notesController = TextEditingController(text: widget.transaction.notes ?? '');
    _selectedDate = widget.transaction.date;
    _selectedCategory = widget.transaction.category ?? 'Uncategorized';
    _isRecurring = widget.transaction.isRecurring;
    _isSubscription = widget.transaction.isSubscription;
    _transactionKind = widget.transaction.kind;
  }

  @override
  void dispose() {
    _merchantController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveTransaction() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      // Create updated transaction
      final updatedTransaction = widget.transaction
        ..merchantName = _merchantController.text.trim()
        ..amount = double.parse(_amountController.text)
        ..date = _selectedDate
        ..category = _selectedCategory
        ..notes = _notesController.text.trim().isEmpty ? null : _notesController.text.trim()
        ..isRecurring = _isRecurring
        ..isSubscription = _isSubscription
        ..kind = _transactionKind
        ..isManuallyEdited = true
        ..manualEditTimestamp = DateTime.now()
        ..updatedAt = DateTime.now();

      // Save via repository
      await ref.read(transactionRepositoryProvider).updateTransaction(updatedTransaction);

      if (mounted) {
        Navigator.of(context).pop(true); // Return true to indicate success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transaction updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving transaction: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('EEEE, MMMM d, y');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Transaction'),
        actions: [
          if (_isSaving)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveTransaction,
              tooltip: 'Save',
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Manual Edit Warning
            Card(
              color: theme.colorScheme.tertiaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: theme.colorScheme.onTertiaryContainer,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Manual edits will override email-extracted data',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),

            // Merchant Name
            TextFormField(
              controller: _merchantController,
              decoration: const InputDecoration(
                labelText: 'Merchant Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.store),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a merchant name';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Amount
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: const OutlineInputBorder(),
                prefixText: '${CurrencyInfo.getSymbol(widget.transaction.currency)} ',
                prefixIcon: const Icon(Icons.payments),
                suffix: Text(widget.transaction.currency),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Date
            InkWell(
              onTap: _selectDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(dateFormat.format(_selectedDate)),
              ),
            ),

            const SizedBox(height: 16),

            // Category
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
              items: () {
                // Predefined categories
                final categories = [
                  'Uncategorized',
                  'Food & Dining',
                  'Shopping',
                  'Transportation',
                  'Entertainment',
                  'Bills & Utilities',
                  'Healthcare',
                  'Travel',
                  'Other',
                ];
                
                // Add the current category if it's not in the list
                if (!categories.contains(_selectedCategory)) {
                  categories.add(_selectedCategory);
                }
                
                return categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList();
              }(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            // Transaction Type
            DropdownButtonFormField<TransactionKind>(
              value: _transactionKind,
              decoration: const InputDecoration(
                labelText: 'Type',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.swap_vert),
              ),
              items: TransactionKind.values.map((kind) {
                return DropdownMenuItem(
                  value: kind,
                  child: Row(
                    children: [
                      Icon(
                        kind == TransactionKind.income
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        size: 16,
                        color: kind == TransactionKind.income
                            ? Colors.green
                            : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(kind.name[0].toUpperCase() + kind.name.substring(1)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _transactionKind = value;
                  });
                }
              },
            ),

            const SizedBox(height: 24),

            // Recurring Switch
            SwitchListTile(
              title: const Text('Recurring Transaction'),
              subtitle: const Text('This transaction repeats regularly'),
              value: _isRecurring,
              onChanged: (value) {
                setState(() {
                  _isRecurring = value;
                });
              },
              secondary: const Icon(Icons.repeat),
            ),

            // Subscription Switch
            SwitchListTile(
              title: const Text('Subscription'),
              subtitle: const Text('This is a subscription service'),
              value: _isSubscription,
              onChanged: (value) {
                setState(() {
                  _isSubscription = value;
                });
              },
              secondary: const Icon(Icons.subscriptions),
            ),

            const SizedBox(height: 16),

            // Notes
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (Optional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
                alignLabelWithHint: true,
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),

            const SizedBox(height: 32),

            // Save Button
            FilledButton.icon(
              onPressed: _isSaving ? null : _saveTransaction,
              icon: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.save),
              label: Text(_isSaving ? 'Saving...' : 'Save Changes'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),

            const SizedBox(height: 16),

            // Cancel Button
            OutlinedButton(
              onPressed: _isSaving
                  ? null
                  : () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
