import 'package:flutter/material.dart';
import 'package:pennypilot/src/core/theme/app_theme.dart';

/// Badge to display extraction confidence level
class ConfidenceBadge extends StatelessWidget {
  final String level; // 'high', 'medium', or 'low'
  final bool compact;

  const ConfidenceBadge({
    super.key,
    required this.level,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = AppTheme.getConfidenceColor(context, level);
    
    final icon = _getIcon();
    final label = _getLabel();

    if (compact) {
      return Tooltip(
        message: '$label confidence',
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            size: 14,
            color: color,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    switch (level.toLowerCase()) {
      case 'high':
        return Icons.check_circle;
      case 'medium':
        return Icons.info;
      case 'low':
        return Icons.help_outline;
      default:
        return Icons.help_outline;
    }
  }

  String _getLabel() {
    switch (level.toLowerCase()) {
      case 'high':
        return 'High';
      case 'medium':
        return 'Medium';
      case 'low':
        return 'Low';
      default:
        return 'Unknown';
    }
  }
}
