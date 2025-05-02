// details_section.dart
import 'package:animate_do/animate_do.dart';
import 'package:webestate/data/models/estate_models/land_model.dart';
import '../../../../data/models/estate_models/apartment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'shared/detail_item.dart';

class DetailsSection extends StatelessWidget {
  final Land land;

  const DetailsSection({super.key, required this.land});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: FadeInUp(
          delay: 250.ms,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "تفاصيل العقار",
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
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: isWeb ? 3 : 2,
                  childAspectRatio: isWeb ? 4 : 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  padding: EdgeInsets.zero,
                  children: [
                    DetailItem(
                        icon: Iconsax.rulerpen,
                        label: "المساحة",
                        value: "${land.area} متر²",isWeb: isWeb,),
                    DetailItem(
                        icon: Iconsax.calendar,
                        label: "تاريخ الإضافة",
                        value: _formatDate(land.listedAt),isWeb: isWeb,),

                    DetailItem(
                        icon: Iconsax.document,
                        label: "حالة العقار",
                        value: land.available ? "متاح" : "غير متاح",isWeb: isWeb,),
                    DetailItem(
                        icon: Iconsax.document,
                        label: "نوع الأرض",
                        value: getLandUseInArabic(land.landUse),isWeb: isWeb,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String getType(String type) {
    if (type.toLowerCase() == "rent") {
      return "ايجار";
    }
    if (type.toLowerCase() == "sell") {
      return "بيع";
    }
    return "غير معروف";
  }
}
