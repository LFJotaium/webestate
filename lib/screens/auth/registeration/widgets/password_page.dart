import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import '../../../../../l10n/generated/app_localizations.dart';
import '../register_controller.dart';

class PasswordPage {
  static PageViewModel build(BuildContext context, TextEditingController controller) {
    final localizations = AppLocalizations.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    bool isPasswordVisible = false;

    return PageViewModel(
      titleWidget: const SizedBox.shrink(),
      bodyWidget: StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.15),
            child: Column(
              children: [
                Lottie.asset("assets/animations/password.json", height: screenHeight * 0.23),
                SizedBox(height: screenHeight * 0.0275),
                Text(
                  localizations.registration_passwordLabel,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold, fontSize: screenHeight * 0.03),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.0275),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.028),
                  child: TextFormField(
                    controller: controller,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: localizations.registration_passwordHint,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return localizations.validation_passwordRequired;
                      }
                      if (value.length < 6) {
                        return localizations.validation_passwordShort;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
