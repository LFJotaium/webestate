// info_card_section.dart
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:webestate/data/models/estate_models/villa_model.dart';

import '../../../../../data/repositories/estate_repository.dart';
import '../../../../data/models/estate_models/apartment_model.dart';
import 'shared/info_item.dart';

class InfoCardSection extends StatelessWidget {
  final Villa villa;

  const InfoCardSection({super.key, required this.villa});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: FadeInUp(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        villa.title,
                        style: GoogleFonts.cairo(
                          fontSize: isWeb ? 22 : 20,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onBackground,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (villa.isPromoted)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'ممول',
                          style: GoogleFonts.cairo(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Icon(Iconsax.location,
                        size: isWeb ? 18 : 16,
                        color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        villa.locationDescription,
                        style: GoogleFonts.cairo(
                          fontSize: isWeb ? 16 : 14,
                          color: theme.colorScheme.onBackground.withOpacity(0.7),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        Icon(Iconsax.eye,
                            size: isWeb ? 18 : 16,
                            color: theme.colorScheme.onBackground.withOpacity(0.6)),
                        const SizedBox(width: 8),
                        Text(
                          '${villa.views}',
                          style: GoogleFonts.cairo(
                            fontSize: isWeb ? 16 : 14,
                            color: theme.colorScheme.onBackground.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                delay: 100.ms,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoItem(
                        icon: Iconsax.money,
                        value: "${EstateRepository().formatNumber(villa.price.toInt())} ₪",
                        label: "السعر",
                        isWeb: isWeb,
                      ),
                      InfoItem(
                        icon: Iconsax.ruler,
                        value: "${villa.area.toInt()} متر²",
                        label: "المساحة",
                        isWeb: isWeb,
                      ),
                      InfoItem(
                        icon: Iconsax.buildings,
                        value: villa.listingType == 'rent' ? 'للإيجار' : 'للبيع',
                        label: "النوع",
                        isWeb: isWeb,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}