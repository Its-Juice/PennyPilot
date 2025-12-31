import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/presentation/providers/database_provider.dart';
import 'package:pennypilot/src/presentation/providers/app_state_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTransactionSheet extends ConsumerStatefulWidget {
  const AddTransactionSheet({super.key});

  @override
  ConsumerState<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends ConsumerState<AddTransactionSheet> {
  final _formKey = GlobalKey<FormState>();
  TransactionKind _kind = TransactionKind.expense;
  late DateTime _selectedDate;
  final _amountController = TextEditingController();
  final _merchantController = TextEditingController();
  String? _category;
  bool _isRecurring = false;
  bool _isLoading = false;

  final List<String> _expenseCategories = [
    'Food & Dining',
    'Shopping',
    'Transportation',
    'Utilities',
    'Entertainment',
    'Healthcare',
    'Housing',
    'Travel',
    'Other',
  ];

  final List<String> _incomeCategories = [
    'Salary',
    'Freelance',
    'Investments',
    'Refunds',
    'Gifts',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _merchantController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveTransaction() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final isar = ref.read(isarProvider);
      
      final preferredCurrency = ref.read(appStateProvider).currencyCode;
      final transaction = TransactionModel()
        ..kind = _kind
        ..origin = TransactionOrigin.manual
        ..merchantName = _merchantController.text.trim()
        ..rawMerchantName = _merchantController.text.trim()
        ..amount = double.parse(_amountController.text.replaceAll(RegExp(r'[^0-9.]'), ''))
        ..date = _selectedDate
        ..category = _category ?? 'Other'
        ..isRecurring = _isRecurring
        ..hasLineItems = false
        ..userVerified = true
        ..extractionConfidence = ConfidenceLevel.high
        ..currency = preferredCurrency
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();

      await isar.writeTxn(() async {
        await isar.transactionModels.put(transaction);
      });

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.transactionRecorded)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.error(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isIncome = _kind == TransactionKind.income;
    final categories = isIncome ? _incomeCategories : _expenseCategories;
    final l10n = AppLocalizations.of(context)!;


    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withAlpha(102),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.newEntry,
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  
                  // Type Selection
                  SegmentedButton<TransactionKind>(
                    segments: [
                      ButtonSegment(
                        value: TransactionKind.expense,
                        label: Text(l10n.expense),
                        icon: const Icon(Icons.arrow_upward, size: 16),
                      ),
                      ButtonSegment(
                        value: TransactionKind.income,
                        label: Text(l10n.incomeLabel),
                        icon: const Icon(Icons.arrow_downward, size: 16),
                      ),
                    ],
                    selected: {_kind},
                    onSelectionChanged: (Set<TransactionKind> newSelection) {
                      setState(() {
                        _kind = newSelection.first;
                        _category = null; // Reset category when switching type
                      });
                    },
                    style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Amount Field
                  TextFormField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: isIncome ? Colors.green : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '0.00',
                      prefixText: '${CurrencyInfo.getSymbol(ref.watch(appStateProvider).currencyCode)} ',
                      border: InputBorder.none,
                      hintStyle: theme.textTheme.displaySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(77),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.pleaseEnterAmount;
                      }
                      if (double.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), '')) == null) {
                        return l10n.invalidAmount;
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Merchant/Source Field
                  TextFormField(
                    controller: _merchantController,
                    decoration: InputDecoration(
                      labelText: isIncome ? l10n.source : l10n.merchantLabel,
                      prefixIcon: Icon(isIncome ? Icons.work : Icons.store),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest.withAlpha(77),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                          return isIncome ? l10n.pleaseEnterSource : l10n.pleaseEnterMerchant;
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Category Dropdown
                  DropdownButtonFormField<String>(
                    initialValue: _category,
                    decoration: InputDecoration(
                      labelText: l10n.category,
                      prefixIcon: const Icon(Icons.category),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest.withAlpha(77),
                    ),
                    items: categories.map((c) => DropdownMenuItem(
                      value: c,
                      child: Text(c),
                    )).toList(),
                    onChanged: (value) => setState(() => _category = value),
                    validator: (value) => value == null ? l10n.pleaseSelectCategory : null,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Date Picker
                  InkWell(
                    onTap: () => _selectDate(context),
                    borderRadius: BorderRadius.circular(12),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: l10n.date,
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surfaceContainerHighest.withAlpha(77),
                      ),
                      child: Text(
                        DateFormat.yMMMd().format(_selectedDate),
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  
                  // Recurring Switch
                  SwitchListTile(
                    title: Text(l10n.recurring),
                    subtitle: Text(
                      isIncome 
                        ? l10n.recurringIncomeDescription
                        : l10n.recurringExpenseDescription,
                      style: theme.textTheme.bodySmall,
                    ),
                    value: _isRecurring,
                    onChanged: (value) => setState(() => _isRecurring = value),
                    secondary: Icon(
                      Icons.update,
                      color: _isRecurring ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Save Button
                  FilledButton(
                    onPressed: _isLoading ? null : _saveTransaction,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.saveTransaction),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
