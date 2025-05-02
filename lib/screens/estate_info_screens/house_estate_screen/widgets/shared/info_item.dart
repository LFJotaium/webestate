// info_item.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final bool isWeb;

  const InfoItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.isWeb = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: isWeb ? 28 : 24,
          color: theme.colorScheme.primary,
        ),
        SizedBox(height: isWeb ? 8 : 4),
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: isWeb ? 16 : 14,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onBackground,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: isWeb ? 14 : 12,
            color: theme.colorScheme.onBackground.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}