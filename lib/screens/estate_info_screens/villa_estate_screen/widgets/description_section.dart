// description_section.dart
import 'package:animate_do/animate_do.dart';
import 'package:webestate/data/models/estate_models/villa_model.dart';
import '../../../../data/models/estate_models/apartment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class DescriptionSection extends StatelessWidget {
  final Villa villa;

  const DescriptionSection({super.key, required this.villa});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: FadeInUp(
          delay: 200.ms,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "الوصف",
                  style: GoogleFonts.cairo(
                    fontSize: isWeb ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 12),
                ReadMoreText(
                  villa.description,
                  trimLines: 3,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' عرض المزيد',
                  trimExpandedText: ' عرض أقل',
                  style: GoogleFonts.cairo(
                    fontSize: isWeb ? 16 : 14,
                    color: theme.colorScheme.onBackground.withOpacity(0.8),
                    height: 1.6,
                  ),
                  moreStyle: TextStyle(
                    fontSize: isWeb ? 16 : 14,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  lessStyle: TextStyle(
                    fontSize: isWeb ? 16 : 14,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}