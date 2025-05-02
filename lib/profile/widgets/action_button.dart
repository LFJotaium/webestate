// action_button.dart
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDestructive;
  final bool isFilled;

  const ActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isDestructive = false,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 768;
    final backgroundColor = isDestructive
        ? theme.colorScheme.errorContainer
        : theme.colorScheme.primaryContainer;
    final foregroundColor = isDestructive
        ? theme.colorScheme.onErrorContainer
        : theme.colorScheme.onPrimaryContainer;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: isFilled
          ? FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 20,
          color: foregroundColor,
        ),
        label: Text(
          text,
          style: TextStyle(
            color: foregroundColor,
            fontSize: isDesktop ? 18 : 16,
          ),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(
            vertical: isDesktop ? 18 : 16,
            horizontal: isDesktop ? 24 : 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      )
          : OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 20,
          color: isDestructive
              ? theme.colorScheme.error
              : theme.colorScheme.primary,
        ),
        label: Text(
          text,
          style: TextStyle(
            color: isDestructive
                ? theme.colorScheme.error
                : theme.colorScheme.primary,
            fontSize: isDesktop ? 18 : 16,
          ),
        ),
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(
            vertical: isDesktop ? 18 : 16,
            horizontal: isDesktop ? 24 : 20,
          ),
          side: BorderSide(
            color: isDestructive
                ? theme.colorScheme.error.withOpacity(0.5)
                : theme.colorScheme.primary.withOpacity(0.5),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}