import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../l10n/generated/app_localizations.dart';

class VillaDetailsStep extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final TextEditingController areaController;
  final TextEditingController totalRoomsController;
  final TextEditingController totalBathroomsController;
  final TextEditingController totalKitchensController;


  const VillaDetailsStep({
    required this.fadeAnimation,
    required this.areaController,
    required this.totalRoomsController,
    required this.totalBathroomsController,
    required this.totalKitchensController,

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
              AppLocalizations.of(context).add_apartment_details,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildAnimatedTextField(
                    context: context,
                    controller: areaController,
                    label: AppLocalizations.of(context).add_apartment_area,
                    icon: Icons.aspect_ratio,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildAnimatedTextField(
                    context: context,
                    controller: totalRoomsController,
                    label: AppLocalizations.of(context).add_apartment_rooms,
                    icon: Icons.king_bed,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildAnimatedTextField(
                    context: context,
                    controller: totalBathroomsController,
                    label: AppLocalizations.of(context).add_apartment_bathrooms,
                    icon: Icons.bathtub,
                    keyboardType: TextInputType.number,
                  ).animate().slideX(delay: 100.ms, begin: 0.1, end: 0),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildAnimatedTextField(
                    context: context,
                    controller: totalKitchensController,
                    label: AppLocalizations.of(context).add_apartment_kitchens,
                    icon: Icons.kitchen,
                    keyboardType: TextInputType.number,
                  ).animate().slideX(delay: 200.ms, begin: 0.1, end: 0),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(icon),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      textDirection: AppLocalizations.of(context).localeName == 'ar' ||
          AppLocalizations.of(context).localeName == 'he'
          ? TextDirection.rtl : TextDirection.ltr,
    );
  }
}