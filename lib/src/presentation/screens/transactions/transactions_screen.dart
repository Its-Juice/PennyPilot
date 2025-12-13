import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/presentation/widgets/transaction_card.dart';
import 'package:pennypilot/src/presentation/widgets/empty_state.dart';
import 'package:pennypilot/src/core/utils/page_transitions.dart';
import 'package:pennypilot/src/presentation/screens/transactions/transaction_details_screen.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  String _filterCategory = 'All';
  String _sortBy = 'date'; // 'date', 'amount', 'merchant'

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transactionsAsync = ref.watch(transactionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
            tooltip: 'Filter & Sort',
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search coming soon')),
              );
            },
            tooltip: 'Search',
          ),
        ],
      ),
      body: transactionsAsync.when(
        data: (transactions) {
          if (transactions.isEmpty) {
            return EmptyState(
              icon: Icons.receipt_long,
              title: 'No Transactions Yet',
              message: 'Connect your email to start tracking your spending',
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

          // Apply filters
          var filteredTransactions = transactions;
          if (_filterCategory != 'All') {
            filteredTransactions = transactions
                .where((t) => t.category == _filterCategory)
                .toList();
          }

          // Apply sorting
          filteredTransactions = List.from(filteredTransactions);
          switch (_sortBy) {
            case 'amount':
              filteredTransactions.sort((a, b) => b.amount.compareTo(a.amount));
              break;
            case 'merchant':
              filteredTransactions.sort((a, b) => 
                a.merchantName.compareTo(b.merchantName));
              break;
            case 'date':
            default:
              filteredTransactions.sort((a, b) => b.date.compareTo(a.date));
          }

          return Column(
            children: [
              // Summary card
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
                      'Total',
                      transactions.length.toString(),
                      Icons.receipt,
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: theme.colorScheme.outline.withOpacity(0.3),
                    ),
                    _buildSummaryItem(
                      context,
                      'This Month',
                      _getMonthCount(transactions).toString(),
                      Icons.calendar_today,
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: theme.colorScheme.outline.withOpacity(0.3),
                    ),
                    _buildSummaryItem(
                      context,
                      'High Confidence',
                      _getHighConfidenceCount(transactions).toString(),
                      Icons.check_circle,
                    ),
                  ],
                ),
              ),

              // Filter chips
              if (_filterCategory != 'All' || _sortBy != 'date')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      if (_filterCategory != 'All')
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Chip(
                            label: Text('Category: $_filterCategory'),
                            onDeleted: () {
                              setState(() {
                                _filterCategory = 'All';
                              });
                            },
                          ),
                        ),
                      if (_sortBy != 'date')
                        Chip(
                          label: Text('Sort: ${_sortBy[0].toUpperCase()}${_sortBy.substring(1)}'),
                          onDeleted: () {
                            setState(() {
                              _sortBy = 'date';
                            });
                          },
                        ),
                    ],
                  ),
                ),

              // Transaction list
              Expanded(
                child: filteredTransactions.isEmpty
                    ? EmptyState(
                        icon: Icons.filter_alt_off,
                        title: 'No Matches',
                        message: 'Try adjusting your filters',
                        action: TextButton(
                          onPressed: () {
                            setState(() {
                              _filterCategory = 'All';
                              _sortBy = 'date';
                            });
                          },
                          child: const Text('Clear Filters'),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredTransactions.length,
                        padding: const EdgeInsets.only(bottom: 16),
                        itemBuilder: (context, index) {
                          final transaction = filteredTransactions[index];
                          return TransactionCard(
                            transaction: transaction,
                            showConfidence: true,
                            expandable: true,
                            onTap: () {
                              Navigator.push(
                                context,
                                SharedAxisPageRoute(
                                  page: TransactionDetailsScreen(
                                    transaction: transaction,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const LoadingState(message: 'Loading transactions...'),
        error: (error, stack) => ErrorState(
          title: 'Failed to Load',
          message: error.toString(),
          onRetry: () => ref.refresh(transactionsProvider),
        ),
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

  int _getMonthCount(List transactions) {
    final now = DateTime.now();
    return transactions.where((t) {
      return t.date.year == now.year && t.date.month == now.month;
    }).length;
  }

  int _getHighConfidenceCount(List transactions) {
    return transactions.where((t) {
      return t.extractionConfidence.name == 'high';
    }).length;
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter & Sort',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                
                Text(
                  'Sort By',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('Date'),
                      selected: _sortBy == 'date',
                      onSelected: (selected) {
                        setModalState(() {
                          _sortBy = 'date';
                        });
                        setState(() {
                          _sortBy = 'date';
                        });
                      },
                    ),
                    ChoiceChip(
                      label: const Text('Amount'),
                      selected: _sortBy == 'amount',
                      onSelected: (selected) {
                        setModalState(() {
                          _sortBy = 'amount';
                        });
                        setState(() {
                          _sortBy = 'amount';
                        });
                      },
                    ),
                    ChoiceChip(
                      label: const Text('Merchant'),
                      selected: _sortBy == 'merchant',
                      onSelected: (selected) {
                        setModalState(() {
                          _sortBy = 'merchant';
                        });
                        setState(() {
                          _sortBy = 'merchant';
                        });
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _filterCategory = 'All';
                          _sortBy = 'date';
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Reset'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Apply'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
