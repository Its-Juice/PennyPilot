import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/data/models/budget_model.dart';
import 'package:pennypilot/src/presentation/providers/budget_provider.dart';

class SplitTransactionSheet extends ConsumerStatefulWidget {
  final TransactionModel transaction;

  const SplitTransactionSheet({super.key, required this.transaction});

  @override
  ConsumerState<SplitTransactionSheet> createState() => _SplitTransactionSheetState();
}

class _SplitTransactionSheetState extends ConsumerState<SplitTransactionSheet> {
  final List<TextEditingController> _participantControllers = [TextEditingController()];
  final List<TextEditingController> _amountControllers = [TextEditingController()];
  
  @override
  void initState() {
    super.initState();
    // Pre-fill with "Personal" and full amount
    _participantControllers[0].text = 'Personal';
    _amountControllers[0].text = widget.transaction.amount.toString();
  }

  @override
  void dispose() {
    for (var c in _participantControllers) {
      c.dispose();
    }
    for (var c in _amountControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addSplit() {
    setState(() {
      _participantControllers.add(TextEditingController());
      _amountControllers.add(TextEditingController());
    });
  }

  void _removeSplit(int index) {
    setState(() {
      _participantControllers[index].dispose();
      _amountControllers[index].dispose();
      _participantControllers.removeAt(index);
      _amountControllers.removeAt(index);
    });
  }

  Future<void> _saveSplits() async {
    final List<SpendingSplitModel> splits = [];
    double totalSplit = 0;

    for (int i = 0; i < _participantControllers.length; i++) {
      final name = _participantControllers[i].text.trim();
      final amountStr = _amountControllers[i].text.trim();
      final amount = double.tryParse(amountStr) ?? 0;

      if (name.isNotEmpty && amount > 0) {
        splits.add(SpendingSplitModel()
          ..participant = name
          ..amount = amount
          ..transactionId = widget.transaction.id
          ..createdAt = DateTime.now());
        totalSplit += amount;
      }
    }

    if (totalSplit > widget.transaction.amount + 0.01) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Split total cannot exceed transaction amount')),
      );
      return;
    }

    await ref.read(budgetServiceProvider).createSplit(widget.transaction.id, splits);
    
    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Split Transaction',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Total: \$${widget.transaction.amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _participantControllers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _participantControllers[index],
                          decoration: const InputDecoration(
                            labelText: 'Participant',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: _amountControllers[index],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                            border: OutlineInputBorder(),
                            prefixText: '\$',
                          ),
                        ),
                      ),
                      if (index > 0)
                        IconButton(
                          onPressed: () => _removeSplit(index),
                          icon: const Icon(Icons.delete_outline),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: _addSplit,
            icon: const Icon(Icons.add),
            label: const Text('Add Participant'),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _saveSplits,
              child: const Text('Confirm Splits'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
