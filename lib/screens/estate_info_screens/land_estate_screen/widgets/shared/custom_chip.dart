// custom_chip.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isWeb;

  const CustomChip({
    super.key,
    required this.icon,
    required this.text,
    this.isWeb = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Chip(
      avatar: Icon(
        icon,
        size: isWeb ? 20 : 18,
        color: theme.colorScheme.primary,
      ),
      label: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: isWeb ? 14 : 12,
        ),
      ),
      backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 12 : 8,
        vertical: isWeb ? 8 : 4,
      ),
      visualDensity: VisualDensity.standard,
    );
  }
}