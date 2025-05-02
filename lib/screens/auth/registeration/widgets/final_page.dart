import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:webestate/screens/auth/registeration/widgets/register_model.dart';
import '../../../../../l10n/generated/app_localizations.dart';

class FinalPage {
  static PageViewModel build(BuildContext context, RegistrationData data) {
    final localizations = AppLocalizations.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return PageViewModel(
      titleWidget: Column(
        children: [
          Lottie.asset("assets/animations/review.json", height: screenHeight * 0.25, fit: BoxFit.cover),
          SizedBox(height: screenHeight * 0.03),
          Text(
            localizations.registration_verifyInfo,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenHeight * 0.015),
          Text(
            localizations.registration_verifyMessage,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.blueGrey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bodyWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: AnimationLimiter(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 500),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    _buildInfoRow(context, localizations.registration_firstName, data.firstName, Icons.person),
                    SizedBox(height: screenHeight * 0.015),
                    _buildInfoRow(context, localizations.registration_lastName, data.lastName, Icons.person_outline),
                    SizedBox(height: screenHeight * 0.015),
                    _buildInfoRow(context, localizations.registration_phoneNumber, data.phone, Icons.phone),
                    SizedBox(height: screenHeight * 0.015),
                    _buildInfoRow(context, localizations.emailLabel, data.email, Icons.email),
                    SizedBox(height: screenHeight * 0.03),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015, horizontal: screenWidth * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue.shade700, size: screenHeight * 0.03),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.blueGrey.shade800,
                    fontSize: screenHeight * 0.018,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                    fontSize: screenHeight * 0.018,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
