import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:lottie/lottie.dart';

import '../../../core/auth_service/fiirebase_auth_service.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final Function(bool) onVerificationComplete;

  const OtpVerificationScreen({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
    required this.onVerificationComplete,
  }) : super(key: key);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isVerifying = false;

  void _verifyOTP() async {
    if (_otpController.text.isEmpty) {
      GFToast.showToast("Please enter OTP code", context,
        toastPosition: GFToastPosition.CENTER,
      );
      return;
    }

    setState(() => _isVerifying = true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset('assets/animations/otp.json', height: 120),
                      const SizedBox(height: 10),
                      Text(
                        "أدخل رمز OTP المرسل إلى\n${widget.phoneNumber}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: PinCodeTextField(
                          appContext: context,
                          controller: _otpController,
                          length: 4,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 50,
                            fieldWidth: 50,
                            activeColor: GFColors.PRIMARY,
                            selectedColor: GFColors.WARNING,
                            inactiveColor: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _isVerifying
                          ? GFLoader(type: GFLoaderType.circle)
                          : GFButton(
                        onPressed: _verifyOTP,
                        text: "تحقق",
                        shape: GFButtonShape.pills,
                        fullWidthButton: true,
                        color: GFColors.SUCCESS,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
