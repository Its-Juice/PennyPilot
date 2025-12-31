import 'package:flutter/material.dart';
import 'package:pennypilot/src/data/models/transaction_model.dart';
import 'package:pennypilot/src/presentation/widgets/amount_display.dart';
import 'package:pennypilot/src/presentation/widgets/confidence_badge.dart';
import 'package:intl/intl.dart';

/// Enhanced transaction card with confidence indicators and line items
class TransactionCard extends StatefulWidget {
  final TransactionModel transaction;
  final VoidCallback? onTap;
  final bool showConfidence;
  final bool expandable;

  const TransactionCard({
    super.key,
    required this.transaction,
    this.onTap,
    this.showConfidence = true,
    this.expandable = true,
  });

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d, y');

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: theme.colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withAlpha(51)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: widget.onTap ?? (widget.expandable && widget.transaction.hasLineItems ? _toggleExpanded : null),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer.withAlpha(51),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      _getMerchantIcon(),
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.transaction.merchantName,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              dateFormat.format(widget.transaction.date),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            if (widget.transaction.category != null) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.secondaryContainer.withAlpha(51),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: theme.colorScheme.secondary.withAlpha(26)),
                                ),
                                child: Text(
                                  widget.transaction.category!,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.colorScheme.secondary,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  Builder(
                    builder: (context) {
                      final isIncome = widget.transaction.kind == TransactionKind.income;
                      final amount = widget.transaction.amount * (isIncome ? 1 : -1);
                      
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AmountDisplay(
                            amount: amount,
                            currency: widget.transaction.currency,
                            showSign: true,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isIncome ? Colors.green : theme.colorScheme.onSurface,
                            ),
                          ),
                          if (widget.showConfidence)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: ConfidenceBadge(
                                level: widget.transaction.extractionConfidence.name,
                                compact: true,
                              ),
                            ),
                        ],
                      );
                    }
                  ),
                ],
              ),

              // Expandable line items section
              if (widget.expandable && widget.transaction.hasLineItems)
                SizeTransition(
                  sizeFactor: _expandAnimation,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      
                      // Line items breakdown
                      if (widget.transaction.subtotalAmount != null)
                        _buildBreakdownRow(
                          context,
                          'Subtotal',
                          widget.transaction.subtotalAmount!,
                        ),
                      if (widget.transaction.taxAmount != null)
                        _buildBreakdownRow(
                          context,
                          'Tax',
                          widget.transaction.taxAmount!,
                        ),
                      if (widget.transaction.discountAmount != null)
                        _buildBreakdownRow(
                          context,
                          'Discount',
                          -widget.transaction.discountAmount!,
                          isDiscount: true,
                        ),
                      if (widget.transaction.tipAmount != null)
                        _buildBreakdownRow(
                          context,
                          'Tip',
                          widget.transaction.tipAmount!,
                        ),
                      
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: theme.textTheme.titleSmall,
                            ),
                            AmountDisplay(
                              amount: widget.transaction.amount,
                              currency: widget.transaction.currency,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              // Expand indicator
              if (widget.expandable && widget.transaction.hasLineItems)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Center(
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 0.5).animate(_expandAnimation),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBreakdownRow(
    BuildContext context,
    String label,
    double amount, {
    bool isDiscount = false,
  }) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
            currency: widget.transaction.currency,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDiscount
                  ? theme.colorScheme.tertiary
                  : theme.colorScheme.onSurface,
            ),
            showSign: isDiscount,
          ),
        ],
      ),
    );
  }

  IconData _getMerchantIcon() {
    final merchant = widget.transaction.merchantName.toLowerCase();
    
    if (merchant.contains('amazon')) return Icons.shopping_bag;
    if (merchant.contains('netflix')) return Icons.movie;
    if (merchant.contains('spotify')) return Icons.music_note;
    if (merchant.contains('uber')) return Icons.local_taxi;
    if (merchant.contains('starbucks') || merchant.contains('coffee')) {
      return Icons.local_cafe;
    }
    if (merchant.contains('restaurant') || merchant.contains('food')) {
      return Icons.restaurant;
    }
    if (merchant.contains('gas') || merchant.contains('fuel')) {
      return Icons.local_gas_station;
    }
    if (merchant.contains('grocery') || merchant.contains('market')) {
      return Icons.shopping_cart;
    }
    
    return Icons.receipt_long;
  }
}
