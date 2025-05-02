// amenities_section.dart
import 'package:animate_do/animate_do.dart';
import 'package:webestate/data/models/estate_models/villa_model.dart';
import '../../../../data/models/estate_models/apartment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'shared/amenity_item.dart';

class AmenitiesSection extends StatelessWidget {
  final Villa villa;

  const AmenitiesSection({super.key, required this.villa});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: FadeInUp(
          delay: 400.ms,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "المرافق",
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
                  crossAxisCount: isWeb ? 4 : 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  padding: EdgeInsets.zero,
                  children: [
                    AmenityItem(
                        icon: Iconsax.car,
                        label: "موقف سيارات",
                        available: villa.hasParking),
                    AmenityItem(
                        icon: Icons.elevator_outlined,
                        label: "مصعد",
                        available: villa.hasElevator),

                    AmenityItem(
                        icon: Icons.balcony,
                        label: "شرفة",
                        available: villa.hasBalcony),
                    AmenityItem(
                        icon: Iconsax.wind,
                        label: "تهوئة",
                        available: villa.hasAirConditioning),
                    AmenityItem(
                        icon: Iconsax.backward_item,
                        label: "مخزن",
                        available: villa.hasStorage),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

