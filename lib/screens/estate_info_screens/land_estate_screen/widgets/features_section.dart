import 'package:animate_do/animate_do.dart';
import '../../../../data/models/estate_models/land_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'shared/custom_chip.dart';

class FeaturesSection extends StatelessWidget {
  final Land land;

  const FeaturesSection({super.key, required this.land});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return FadeInUp(
      delay: 300.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "المواصفات",
            style: GoogleFonts.cairo(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _getFeatures(land).map((feature) {
              return CustomChip(
                icon: feature['icon'],
                text: feature['text'],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFeatures(Land land) {
    return [


    ];
  }


  String getType(String type)
  {
    if(type == "Rent")
    {
      return "ايجار";
    }
    if(type == "Sell"){
      return "بيع";
    }
    return "غير معروف";
  }
}