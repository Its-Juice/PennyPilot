import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/presentation/screens/auth/connect_email_screen.dart';
import 'package:pennypilot/src/presentation/widgets/transaction_card.dart';
import 'package:pennypilot/src/presentation/widgets/empty_state.dart';
import 'package:pennypilot/src/core/utils/page_transitions.dart';
import 'package:pennypilot/src/presentation/screens/transactions/transaction_details_screen.dart';
import 'package:pennypilot/src/presentation/screens/transactions/add_transaction_sheet.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/presentation/providers/app_state_provider.dart';
import 'package:pennypilot/src/presentation/screens/transactions/receipt_scan_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionsScreen extends ConsumerStatefulWidget {
  const TransactionsScreen({super.key});

  @override
  ConsumerState<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends ConsumerState<TransactionsScreen> {
  String _filterCategory = 'All';
  String _sortBy = 'date'; // 'date', 'amount', 'merchant'
  String _searchQuery = '';
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionsAsync = ref.watch(transactionsProvider);
    final l10n = AppLocalizations.of(context)!;


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: _isSearching 
                ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: l10n.searchHint,
                      border: InputBorder.none,
                      filled: false,
                    ),
                    onChanged: (value) => setState(() => _searchQuery = value),
                  )
                : Text(l10n.transactions),
            actions: [
              IconButton(
                icon: Icon(_isSearching ? Icons.close : Icons.search),
                onPressed: () {
                   setState(() {
                     if (_isSearching) {
                       _isSearching = false;
                       _searchQuery = '';
                       _searchController.clear();
                     } else {
                       _isSearching = true;
                     }
                   });
                },
              ),
              IconButton(
                icon: const Icon(Icons.document_scanner),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReceiptScanScreen()),
                  );
                },
              ),
              if (!_isSearching)
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () => _showFilterSheet(context),
                ),
            ],
          ),
          
          transactionsAsync.when(
            data: (transactions) {
              if (transactions.isEmpty) {
                return SliverFillRemaining(
                  child: EmptyState(
                    icon: Icons.receipt_long,
                    title: l10n.noTransactionsYet,
                    message: l10n.connectEmailDescription,
                    action: FilledButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ConnectEmailScreen())),
                      icon: const Icon(Icons.email),
                      label: Text(l10n.connectEmail),
                    ),
                  ),
                );
              }

              var filteredTransactions = transactions;
              if (_filterCategory != 'All') {
                filteredTransactions = transactions.where((t) => t.category == _filterCategory).toList();
              }
              if (_searchQuery.isNotEmpty) {
                final query = _searchQuery.toLowerCase();
                filteredTransactions = filteredTransactions.where((t) => 
                  t.merchantName.toLowerCase().contains(query) ||
                  (t.notes?.toLowerCase().contains(query) ?? false) ||
                  (t.category?.toLowerCase().contains(query) ?? false)
                ).toList();
              }

              filteredTransactions = List.from(filteredTransactions);
              switch (_sortBy) {
                case 'amount': filteredTransactions.sort((a, b) => b.amount.compareTo(a.amount)); break;
                case 'merchant': filteredTransactions.sort((a, b) => a.merchantName.compareTo(b.merchantName)); break;
                case 'date': default: filteredTransactions.sort((a, b) => b.date.compareTo(a.date));
              }

              return SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: _buildRefinedSummary(context, filteredTransactions),
                    ),
                  ),
                  if (_filterCategory != 'All' || _sortBy != 'date')
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 48,
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          children: [
                            if (_filterCategory != 'All')
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: InputChip(
                                  label: Text(_filterCategory),
                                  onDeleted: () => setState(() => _filterCategory = 'All'),
                                ),
                              ),
                            if (_sortBy != 'date')
                              InputChip(
                                label: Text('${_sortBy[0].toUpperCase()}${_sortBy.substring(1)}'),
                                onDeleted: () => setState(() => _sortBy = 'date'),
                              ),
                          ],
                        ),
                      ),
                    ),
                  
                  if (filteredTransactions.isEmpty)
                    SliverFillRemaining(
                      child: EmptyState(
                        icon: Icons.filter_alt_off,
                        title: l10n.noMatches,
                        message: l10n.tryAdjustingFilters,
                        action: TextButton(
                          onPressed: () => setState(() { _filterCategory = 'All'; _sortBy = 'date'; }),
                          child: Text(l10n.clearFilters),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.only(bottom: 80),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final transaction = filteredTransactions[index];
                            return TransactionCard(
                              transaction: transaction,
                              showConfidence: true,
                              expandable: true,
                              onTap: () => Navigator.push(
                                context,
                                SharedAxisPageRoute(
                                  page: TransactionDetailsScreen(transaction: transaction),
                                ),
                              ),
                            );
                          },
                          childCount: filteredTransactions.length,
                        ),
                      ),
                    ),
                ],
              );
            },
            loading: () => const SliverFillRemaining(child: LoadingState()),
            error: (error, stack) => SliverFillRemaining(
              child: ErrorState(
                title: l10n.failedToLoad,
                message: error.toString(),
                onRetry: () => ref.refresh(transactionsProvider),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (context) => const AddTransactionSheet(),
        ),
        icon: const Icon(Icons.add),
        label: Text(l10n.addEntry),
      ),
    );
  }

  Widget _buildRefinedSummary(BuildContext context, List<TransactionModel> transactions) {
    final flows = _calculateMonthlyFlows(transactions);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(51)),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _summaryColumn(
                context, 
                l10n.income, 
                flows['income']!, 
                theme.colorScheme.primary,
              ),
            ),
            VerticalDivider(color: theme.colorScheme.outlineVariant.withAlpha(51), thickness: 1, indent: 8, endIndent: 8),
            Expanded(
              child: _summaryColumn(
                context, 
                l10n.expenses, 
                flows['expense']!, 
                theme.colorScheme.onSurface,
              ),
            ),
            VerticalDivider(color: theme.colorScheme.outlineVariant.withAlpha(51), thickness: 1, indent: 8, endIndent: 8),
            Expanded(
              child: _summaryColumn(
                context, 
                l10n.net, 
                flows['net']!, 
                flows['net']! >= 0 ? Colors.green : theme.colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryColumn(BuildContext context, String label, double amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          NumberFormat.compactCurrency(
            symbol: CurrencyInfo.getSymbol(ref.watch(appStateProvider).currencyCode),
          ).format(amount.abs()),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Map<String, double> _calculateMonthlyFlows(List<TransactionModel> transactions) {
    final now = DateTime.now();
    
    double income = 0;
    double expense = 0;

    for (var t in transactions) {
      if (t.date.year == now.year && t.date.month == now.month) {
        if (t.kind == TransactionKind.income) {
          income += t.amount;
        } else {
          expense += t.amount;
        }
      }
    }

    return {
      'income': income,
      'expense': expense,
      'net': income - expense,
    };
  }

  void _showFilterSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                  l10n.filterAndSort,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                
                Text(
                  l10n.sortFilter(''), // Note: this might need a better key for just 'Sort By'
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: Text(l10n.date),
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
                      label: Text(l10n.amount),
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
                      label: Text(l10n.merchant),
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
                      child: Text(l10n.reset),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(l10n.apply),
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
