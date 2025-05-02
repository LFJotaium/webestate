// detail_item.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isWeb;

  const DetailItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.isWeb = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: isWeb ? 24 : 20,
          color: theme.colorScheme.primary,
        ),
        SizedBox(width: isWeb ? 12 : 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: isWeb ? 14 : 12,
                  color: theme.colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.cairo(
                  fontSize: isWeb ? 16 : 14,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}