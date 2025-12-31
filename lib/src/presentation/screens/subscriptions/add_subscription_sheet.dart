import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/data/models/subscription_model.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/presentation/providers/app_state_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddSubscriptionSheet extends ConsumerStatefulWidget {
  const AddSubscriptionSheet({super.key});

  @override
  ConsumerState<AddSubscriptionSheet> createState() => _AddSubscriptionSheetState();
}

class _AddSubscriptionSheetState extends ConsumerState<AddSubscriptionSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  
  DateTime _nextRenewalDate = DateTime.now().add(const Duration(days: 30));
  SubscriptionFrequency _frequency = SubscriptionFrequency.monthly;
  final SubscriptionLifecycleState _state = SubscriptionLifecycleState.active;
  int? _selectedCategoryId;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _nextRenewalDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null) {
      setState(() => _nextRenewalDate = picked);
    }
  }

  Future<void> _saveSubscription() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final isar = ref.read(isarProvider);
      
      final subscription = SubscriptionModel(
        serviceName: _nameController.text.trim(),
        amount: double.parse(_amountController.text.replaceAll(RegExp(r'[^0-9.]'), '')),
        nextRenewalDate: _nextRenewalDate,
        frequency: _frequency,
        lifecycleState: _state,
        categoryId: _selectedCategoryId,
        firstSeenDate: DateTime.now(),
        chargeCount: 0,
        frequencyConsistency: 100,
        detectionSource: SubscriptionDetectionSource.manual,
        notes: _notesController.text.trim(),
        userConfirmed: true,
        createdAt: DateTime.now(),
      );

      await isar.writeTxn(() async {
        await isar.subscriptionModels.put(subscription);
      });

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.subscriptionAdded)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.errorAddingSubscription(e.toString()))),
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
    final categoriesAsync = ref.watch(categoriesProvider);
    final l10n = AppLocalizations.of(context)!;


    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurfaceVariant.withAlpha(102),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  l10n.addSubscription,
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                
                // Service Name
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: l10n.serviceName,
                    hintText: l10n.serviceNameHint,
                    prefixIcon: const Icon(Icons.subscriptions),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? l10n.required : null,
                ),
                const SizedBox(height: 16),
                
                // Amount
                TextFormField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: l10n.amount,
                    prefixText: '${ref.watch(appStateProvider.select((s) => s.currencyCode))} ',
                    prefixIcon: const Icon(Icons.payments),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.required;
                    if (double.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), '')) == null) return l10n.invalid;
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Category selection
                categoriesAsync.when(
                  data: (categories) => DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      labelText: l10n.category,
                      prefixIcon: const Icon(Icons.category),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    initialValue: _selectedCategoryId,
                    items: categories.map((c) => DropdownMenuItem(
                      value: c.id,
                      child: Text(c.name),
                    )).toList(),
                    onChanged: (val) => setState(() => _selectedCategoryId = val),
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (e, s) => Text(l10n.failedToLoad),
                ),
                const SizedBox(height: 16),

                // Frequency selection
                DropdownButtonFormField<SubscriptionFrequency>(
                  decoration: InputDecoration(
                    labelText: l10n.billingCycle,
                    prefixIcon: const Icon(Icons.repeat),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  initialValue: _frequency,
                  items: SubscriptionFrequency.values.map((f) => DropdownMenuItem(
                    value: f,
                    child: Text(f.name[0].toUpperCase() + f.name.substring(1)),
                  )).toList(),
                  onChanged: (val) => setState(() => _frequency = val!),
                ),
                const SizedBox(height: 16),

                // Next Renewal Date
                InkWell(
                  onTap: () => _selectDate(context),
                  borderRadius: BorderRadius.circular(12),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: l10n.nextRenewalDate,
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(DateFormat.yMMMd().format(_nextRenewalDate)),
                  ),
                ),
                const SizedBox(height: 16),

                // Notes
                TextFormField(
                  controller: _notesController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: l10n.notesOptional,
                    prefixIcon: const Icon(Icons.note_alt),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 32),

                FilledButton(
                  onPressed: _isLoading ? null : _saveSubscription,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading 
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : Text(l10n.addSubscription),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
