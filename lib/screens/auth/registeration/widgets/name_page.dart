import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import '../../../../../l10n/generated/app_localizations.dart';

class NamePage {
  static PageViewModel buildFirstNamePage(BuildContext context, TextEditingController controller) {
    final localizations = AppLocalizations.of(context);
    return _buildNamePage(
      context,
      localizations.registration_firstName,
      localizations.registration_firstNameHint,
      "assets/animations/firstname.json",
      controller,
          (value) => value!.isEmpty ? localizations.validation_firstNameRequired : null,
    );
  }

  static PageViewModel buildLastNamePage(BuildContext context, TextEditingController controller) {
    final localizations = AppLocalizations.of(context);
    return _buildNamePage(
      context,
      localizations.registration_lastName,
      localizations.registration_lastNameHint,
      "assets/animations/lastname.json",
      controller,
          (value) => value!.isEmpty ? localizations.validation_lastNameRequired : null,
    );
  }

  static PageViewModel _buildNamePage(BuildContext context, String label, String hint, String animation, TextEditingController controller, String? Function(String?)? validator) {
    final screenHeight = MediaQuery.of(context).size.height;

    return PageViewModel(
      titleWidget: const SizedBox.shrink(),
      bodyWidget: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.15),
        child: Column(
          children: [
            Lottie.asset(animation, height: screenHeight * 0.23),
            SizedBox(height: screenHeight * 0.0275),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold, fontSize: screenHeight * 0.03),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.0275),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.028),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: hint,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: validator,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
