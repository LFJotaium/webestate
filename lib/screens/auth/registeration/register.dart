import 'package:webestate/screens/auth/registeration/register_controller.dart';
import 'package:webestate/screens/auth/registeration/widgets/email_page.dart';
import 'package:webestate/screens/auth/registeration/widgets/final_page.dart';
import 'package:webestate/screens/auth/registeration/widgets/name_page.dart';
import 'package:webestate/screens/auth/registeration/widgets/password_page.dart';
import 'package:webestate/screens/auth/registeration/widgets/phone_page.dart';
import 'package:webestate/screens/auth/registeration/widgets/register_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../l10n/generated/app_localizations.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onRegister() async {
    final controller = RegistrationController();

    try {
      setState(() => _isLoading = true);

      final success = await controller.registerUser(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          phone: _phoneController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          context: context);

      if (success) {
        context.pop();
      } else {}
    } on FirebaseAuthException catch (e) {

    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: IntroductionScreen(
            globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            pages: [
              NamePage.buildFirstNamePage(context, _firstNameController),
              NamePage.buildLastNamePage(context, _lastNameController),
              PhonePage.build(context, _phoneController),
              EmailPage.build(context, _emailController),
              PasswordPage.build(context, _passwordController),
              FinalPage.build(
                context,
                RegistrationData(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  phone: _phoneController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
              ),
            ],
            showNextButton: true,
            next: Icon(Icons.arrow_forward_ios_rounded,
                color: Colors.blue.shade600, size: screenHeight * 0.0275),
            showBackButton: true,
            back: Icon(Icons.arrow_back_ios_rounded,
                color: Colors.blue.shade600, size: screenHeight * 0.0275),
            done: _isLoading
                ? const CircularProgressIndicator()
                : Text(
                    localizations.registration_registerButton,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
            onDone: _onRegister,
            showSkipButton: true,
            skip: TextButton(
              onPressed: () => context.pop(),
              child: Text(
                localizations.registration_skip,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                    fontSize: screenHeight * 0.015),
              ),
            ),
            dotsDecorator: DotsDecorator(
              size: const Size(10.0, 10.0),
              activeSize: const Size(22.0, 10.0),
              activeColor: Colors.blue.shade600,
              color: Colors.blue.shade200,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }
}
