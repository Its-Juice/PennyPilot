import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pennypilot/src/core/theme/app_theme.dart';

/// Widget to display currency amounts with proper formatting
class AmountDisplay extends StatelessWidget {
  final double amount;
  final String? currency;
  final TextStyle? style;
  final bool showCurrency;
  final bool showSign;
  final bool monospace;

  const AmountDisplay({
    super.key,
    required this.amount,
    this.currency = 'USD',
    this.style,
    this.showCurrency = true,
    this.showSign = false,
    this.monospace = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formatter = NumberFormat.currency(
      symbol: showCurrency ? _getCurrencySymbol() : '',
      decimalDigits: 2,
    );

    String formattedAmount = formatter.format(amount.abs());
    
    if (showSign && amount != 0) {
      formattedAmount = '${amount > 0 ? '+' : '-'}$formattedAmount';
    }

    final textStyle = style ?? (monospace
        ? AppTheme.monospaceAmount(context)
        : theme.textTheme.bodyLarge);

    return Text(
      formattedAmount,
      style: textStyle,
    );
  }

  String _getCurrencySymbol() {
    switch (currency?.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      default:
        return '\$';
    }
  }
}

/// Compact amount chip
class AmountChip extends StatelessWidget {
  final double amount;
  final String? currency;
  final String? label;
  final Color? backgroundColor;

  const AmountChip({
    super.key,
    required this.amount,
    this.currency = 'USD',
    this.label,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 8),
          ],
          AmountDisplay(
            amount: amount,
            currency: currency,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            monospace: true,
          ),
        ],
      ),
    );
  }
}
