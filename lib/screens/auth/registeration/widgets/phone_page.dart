import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import '../../../../../l10n/generated/app_localizations.dart';
import '../register_controller.dart';

class PhonePage {
  static PageViewModel build(BuildContext context, TextEditingController controller) {
    final localizations = AppLocalizations.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return PageViewModel(
      titleWidget: const SizedBox.shrink(),
      bodyWidget: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.15),
        child: Column(
          children: [
            Lottie.asset("assets/animations/phone.json", height: screenHeight * 0.23),
            SizedBox(height: screenHeight * 0.0275),
            Text(
              localizations.registration_phoneNumber,
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
                    hintText: localizations.registration_phoneHint,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: Icon(Icons.phone, color: Colors.blue.shade700),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return localizations.validation_phoneRequired;
                    }
                    if (!RegistrationController.validatePhoneNumber(value)) {
                      return localizations.validation_phoneInvalid;
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
