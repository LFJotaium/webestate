import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../l10n/generated/app_localizations.dart';
import '../../shared/feature_chip.dart';

class HouseFeaturesStep extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final bool hasBalcony;
  final bool hasParking;
  final bool hasElevator;
  final bool hasStorage;
  final bool hasAirConditioning;
  final bool isFurnished;
  final bool utilitiesIncluded;


  final Function(String feature, bool value) onFeatureChanged;

  const HouseFeaturesStep({
    required this.fadeAnimation,
    required this.hasBalcony,
    required this.hasParking,
    required this.hasElevator,
    required this.hasStorage,
    required this.hasAirConditioning,

    required this.isFurnished,
    required this.utilitiesIncluded,
    required this.onFeatureChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).add_apartment_features,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 24),
            Text(
              AppLocalizations.of(context).add_apartment_selectFeatures,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FeatureChip(
                  label: AppLocalizations.of(context).add_apartment_balcony,
                  icon: Icons.balcony,
                  selected: hasBalcony,
                  onSelected: (selected) => onFeatureChanged('balcony', selected),
                ),
                FeatureChip(
                  label: AppLocalizations.of(context).add_apartment_parking,
                  icon: Icons.local_parking,
                  selected: hasParking,
                  onSelected: (selected) => onFeatureChanged('parking', selected),
                ),
                FeatureChip(
                  label: AppLocalizations.of(context).add_apartment_elevator,
                  icon: Icons.elevator,
                  selected: hasElevator,
                  onSelected: (selected) => onFeatureChanged('elevator', selected),
                ),
                FeatureChip(
                  label: AppLocalizations.of(context).add_apartment_storage,
                  icon: Icons.storage,
                  selected: hasStorage,
                  onSelected: (selected) => onFeatureChanged('storage', selected),
                ),
                FeatureChip(
                  label: AppLocalizations.of(context).add_apartment_ac,
                  icon: Icons.ac_unit,
                  selected: hasAirConditioning,
                  onSelected: (selected) => onFeatureChanged('ac', selected),
                ),
                FeatureChip(
                  label: AppLocalizations.of(context).add_apartment_furnished,
                  icon: Icons.chair,
                  selected: isFurnished,
                  onSelected: (selected) => onFeatureChanged('furnished', selected),
                ),
                FeatureChip(
                  label: AppLocalizations.of(context).add_apartment_utilities,
                  icon: Icons.emoji_objects,
                  selected: utilitiesIncluded,
                  onSelected: (selected) => onFeatureChanged('utilities', selected),
                ),
              ],
            ).animate().fadeIn().slideY(begin: 20, end: 0),
          ],
        ),
      ),
    );
  }
}