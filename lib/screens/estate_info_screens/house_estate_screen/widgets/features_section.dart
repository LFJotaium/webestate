// features_section.dart
import 'package:animate_do/animate_do.dart';
import '../../../../data/models/estate_models/house_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'shared/custom_chip.dart';

class FeaturesSection extends StatelessWidget {
  final House house;

  const FeaturesSection({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: FadeInUp(
          delay: 300.ms,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "المواصفات",
                  style: GoogleFonts.cairo(
                    fontSize: isWeb ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _getFeatures(house).map((feature) {
                    return CustomChip(
                      icon: feature['icon'],
                      text: feature['text'],
                      isWeb: isWeb,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }







  List<Map<String, dynamic>> _getFeatures(House house) {
    return [
      {"icon": Iconsax.clock, "text": "تاريخ الإنشاء: ${_formatDate(house.listedAt)}"},
      {"icon": Iconsax.building, "text": "الغرف: ${house.totalRooms}"},
      {"icon": Icons.bathroom, "text": "الحمامات: ${house.totalBathrooms}"},
      {"icon": Icons.kitchen, "text": "المطابخ: ${house.totalKitchens}"},

    ];
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
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