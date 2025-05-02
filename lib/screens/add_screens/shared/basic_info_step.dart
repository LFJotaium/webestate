import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../l10n/generated/app_localizations.dart';

class BasicInfoStep extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final String listingType;
  final Function(String?) onListingTypeChanged;

  const BasicInfoStep({
    required this.fadeAnimation,
    required this.titleController,
    required this.descriptionController,
    required this.priceController,
    required this.listingType,
    required this.onListingTypeChanged,
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
              AppLocalizations.of(context).add_apartment_basicInfo,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ).animate().slideX(begin: 0.1, end: 0),
            SizedBox(height: 24),
            _buildAnimatedTextField(
              context: context,
              controller: titleController,
              label: AppLocalizations.of(context).add_apartment_title,
              icon: Icons.title,
            ),
            SizedBox(height: 16),
            _buildAnimatedTextField(
              context: context,
              controller: descriptionController,
              label: AppLocalizations.of(context).add_apartment_description,
              icon: Icons.description,
              maxLines: 3,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildAnimatedTextField(
                    context: context,
                    controller: priceController,
                    label: AppLocalizations.of(context).add_apartment_price,
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: listingType,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).add_apartment_listingType,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.sell),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: [
                DropdownMenuItem(
                  value: 'rent',
                  child: Text(AppLocalizations.of(context).add_apartment_rent),
                ),
                DropdownMenuItem(
                  value: 'sell',
                  child: Text(AppLocalizations.of(context).add_apartment_sale),
                ),
              ],
              onChanged: onListingTypeChanged,
            ).animate().slideX(delay: 200.ms, begin: 0.1, end: 0),
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
          ? TextDirection.rtl
          : TextDirection.ltr,
      validator: (v) {
        if (v!.isEmpty) {
          return AppLocalizations.of(context).add_apartment_requiredField;
        }
        return null;
      },
    ).animate().fadeIn().slideX(begin: 0.1, end: 0);
  }
}
