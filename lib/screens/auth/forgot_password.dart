import 'package:webestate/core/auth_service/fiirebase_auth_service.dart';
import 'package:flutter/material.dart';

import '../../../core/firebase_service/firebase_service.dart';

void showForgotPasswordDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Forgot Password",
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => const SizedBox.shrink(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      TextEditingController _emailController = TextEditingController();
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.3),
            end: Offset.zero,
          ).animate(animation),
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text(
              'إعادة تعيين كلمة المرور',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'يرجى إدخال بريدك الإلكتروني لإرسال رابط إعادة تعيين كلمة المرور.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: ()  {
                  if(_emailController.text.isNotEmpty) {
                    showEmailSentSnackBar(context);
                    FirebaseAuthService().sendPasswordResetEmail(
                        _emailController.text.trim());
                    Navigator.of(context).pop();
                  }
                  else{
                    showEmailNotSentSnackBar(context);

                  }

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child:  Text('إرسال',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),
              ),
            ],
          ),
        ),
      );
    },
  );
}



void showEmailSentSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white),
          const SizedBox(width: 12),
           Expanded(
            child: Text(
              'الرجاء التفحص من البريد الذي ادخلته',
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green.shade600,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      duration: const Duration(seconds: 3),
    ),
  );
}


void showEmailNotSentSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'لم تدخل اي شيء',
              textDirection: TextDirection.rtl,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.red.shade600,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      duration: const Duration(seconds: 3),
    ),
  );
}