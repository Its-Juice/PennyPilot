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
    final isIncome = widget.transaction.kind == TransactionKind.income;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withAlpha(12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap ?? (widget.expandable && widget.transaction.hasLineItems ? _toggleExpanded : null),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildMerchantIcon(theme),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.transaction.merchantName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                dateFormat.format(widget.transaction.date),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant.withAlpha(180),
                                ),
                              ),
                              if (widget.transaction.category != null) ...[
                                _buildCategoryPoint(theme),
                                Text(
                                  widget.transaction.category!,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.colorScheme.secondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildAmountSection(theme, isIncome),
                  ],
                ),
                if (widget.expandable && widget.transaction.hasLineItems)
                  _buildExpandableSection(theme),
                if (widget.expandable && widget.transaction.hasLineItems)
                  _buildExpandIndicator(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMerchantIcon(ThemeData theme) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.surfaceContainerHighest,
            theme.colorScheme.surfaceContainerLow,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(51)),
      ),
      child: Icon(
        _getMerchantIcon(),
        color: theme.colorScheme.primary.withAlpha(200),
        size: 22,
      ),
    );
  }

  Widget _buildCategoryPoint(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Icon(Icons.circle, size: 4, color: theme.colorScheme.outlineVariant),
    );
  }

  Widget _buildAmountSection(ThemeData theme, bool isIncome) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AmountDisplay(
          amount: widget.transaction.amount * (isIncome ? 1 : -1),
          currency: widget.transaction.currency,
          showSign: true,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isIncome ? Colors.green.shade600 : theme.colorScheme.onSurface,
          ),
        ),
        if (widget.showConfidence)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: ConfidenceBadge(
              level: widget.transaction.extractionConfidence.name,
              compact: true,
            ),
          ),
      ],
    );
  }

  Widget _buildExpandableSection(ThemeData theme) {
    return SizeTransition(
      sizeFactor: _expandAnimation,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow.withAlpha(128),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant.withAlpha(26)),
            ),
            child: Column(
              children: [
                if (widget.transaction.subtotalAmount != null)
                  _buildBreakdownRow(context, 'Subtotal', widget.transaction.subtotalAmount!),
                if (widget.transaction.taxAmount != null)
                  _buildBreakdownRow(context, 'Tax', widget.transaction.taxAmount!),
                if (widget.transaction.discountAmount != null)
                  _buildBreakdownRow(context, 'Discount', -widget.transaction.discountAmount!, isDiscount: true),
                if (widget.transaction.tipAmount != null)
                  _buildBreakdownRow(context, 'Tip', widget.transaction.tipAmount!),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(height: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: theme.textTheme.labelLarge),
                    AmountDisplay(
                      amount: widget.transaction.amount,
                      currency: widget.transaction.currency,
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildExpandIndicator(ThemeData theme) {
    return Center(
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 0.5).animate(_expandAnimation),
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 20,
          color: theme.colorScheme.onSurfaceVariant.withAlpha(100),
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
