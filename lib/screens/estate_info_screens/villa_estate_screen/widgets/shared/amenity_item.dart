// amenity_item.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmenityItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool available;
  final bool isWeb;

  const AmenityItem({
    super.key,
    required this.icon,
    required this.label,
    required this.available,
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
          size: isWeb ? 32 : 24,
          color: available ? theme.colorScheme.primary : Colors.grey,
        ),
        SizedBox(height: isWeb ? 8 : 4),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: isWeb ? 14 : 10,
            color: available
                ? theme.colorScheme.onBackground
                : Colors.grey,
            fontWeight: isWeb ? FontWeight.w500 : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}