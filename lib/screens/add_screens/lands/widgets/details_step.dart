import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../l10n/generated/app_localizations.dart';

class LandDetailsStep extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final TextEditingController areaController;
  final String landType;
  final Function(String?) onLandTypeChanged;


  const LandDetailsStep({
    required this.fadeAnimation,
    required this.areaController,
    required this.landType,
    required this.onLandTypeChanged

  });

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;
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
            Column(
              children: [
                _buildAnimatedTextField(
                  context: context,
                  controller: areaController,
                  label: AppLocalizations.of(context).add_apartment_area,
                  icon: Icons.aspect_ratio,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: screenSize.height * 0.05),

                DropdownButtonFormField<String>(
                  value: landType,
                  decoration: InputDecoration(
                    labelText: "نوع الأرض",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.sell),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'agriculture',
                      child: Text("زراعية"),
                    ),
                    DropdownMenuItem(
                      value: 'residential',
                      child: Text("سكنية"),
                    ),
                    DropdownMenuItem(
                      value: 'industrial',
                      child: Text("صناعية"),
                    ),
                  ],
                  onChanged: onLandTypeChanged,
                ).animate().slideX(delay: 200.ms, begin: 0.1, end: 0),

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