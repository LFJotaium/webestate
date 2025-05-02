import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ActionButtonSection extends StatelessWidget {
  final String phoneNumber;

  const ActionButtonSection({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizing calculations
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width
    final verticalPadding = screenHeight * 0.02; // 2% of screen height
    final buttonHeight = screenHeight * 0.07; // 7% of screen height
    final fontSize = screenWidth * 0.04; // 4% of screen width
    final shadowBlur = screenWidth * 0.02; // 2% of screen width

    return FadeInUp(
      delay: 600.ms,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: shadowBlur,
              offset: Offset(0, -screenHeight * 0.005),
            ),
          ],
        ),
        child: GFButton(
          onPressed: () => _makePhoneCall(phoneNumber),
          text: "اتصل الآن",
          shape: GFButtonShape.pills,
          color: theme.colorScheme.primary,
          size: GFSize.LARGE,
          textStyle: GoogleFonts.cairo(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          fullWidthButton: true,
          elevation: 5,
          padding: EdgeInsets.symmetric(vertical: buttonHeight * 0.4),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }
}