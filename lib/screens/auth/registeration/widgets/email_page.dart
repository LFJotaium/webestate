import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import '../../../../../l10n/generated/app_localizations.dart';
import '../register_controller.dart';

class EmailPage {
  static PageViewModel build(BuildContext context, TextEditingController controller) {
    final localizations = AppLocalizations.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return PageViewModel(
      titleWidget: const SizedBox.shrink(),
      bodyWidget: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.15),
        child: Column(
          children: [
            Lottie.asset("assets/animations/email.json", height: screenHeight * 0.23),
            SizedBox(height: screenHeight * 0.0275),
            Text(
              localizations.emailLabel,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold, fontSize: screenHeight * 0.03),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.0275),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.028),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: localizations.emailHint,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return localizations.validation_emailRequired;
                    }
                    if (!RegistrationController.validateEmail(value)) {
                      return localizations.validation_emailInvalid;
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
