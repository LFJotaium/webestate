import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../l10n/generated/app_localizations.dart';
import '../../shared/feature_chip.dart';

class LandFeaturesStep extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Function(String feature, bool value) onFeatureChanged;
  final bool roadAccess;
  const LandFeaturesStep({
    required this.fadeAnimation,
    required this.onFeatureChanged,
    required this.roadAccess,
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
                  label: "طريق مؤدي",
                  icon: Icons.balcony,
                  selected: roadAccess,
                  onSelected: (selected) => onFeatureChanged('roadAccess', selected),
                ),
              ],
            ).animate().fadeIn().slideY(begin: 20, end: 0),
          ],
        ),
      ),
    );
  }
}