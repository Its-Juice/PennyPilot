import 'package:flutter/material.dart';
import 'package:pennypilot/src/core/theme/app_theme.dart';

/// Badge to display subscription lifecycle state
class LifecycleBadge extends StatelessWidget {
  final String state; // 'active', 'trial', 'paused', 'ended', 'cancelled'
  final bool compact;

  const LifecycleBadge({
    super.key,
    required this.state,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = AppTheme.getLifecycleColor(context, state);
    
    final icon = _getIcon();
    final label = _getLabel();

    if (compact) {
      return Tooltip(
        message: label,
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
    switch (state.toLowerCase()) {
      case 'active':
        return Icons.check_circle;
      case 'trial':
        return Icons.schedule;
      case 'paused':
        return Icons.pause_circle;
      case 'ended':
        return Icons.cancel;
      case 'cancelled':
        return Icons.block;
      default:
        return Icons.help_outline;
    }
  }

  String _getLabel() {
    switch (state.toLowerCase()) {
      case 'active':
        return 'Active';
      case 'trial':
        return 'Trial';
      case 'paused':
        return 'Paused';
      case 'ended':
        return 'Ended';
      case 'cancelled':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }
}
