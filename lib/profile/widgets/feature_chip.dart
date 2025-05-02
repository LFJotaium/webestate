// feature_chip.dart
import 'package:flutter/material.dart';

class FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const FeatureChip({
    Key? key,
    required this.icon,
    required this.label,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipColor = color ?? theme.colorScheme.surfaceVariant;
    final textColor = color != null
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: textColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}