import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/position/gf_toast_position.dart';

import '../../../../core/auth_service/fiirebase_auth_service.dart';

class RegistrationController {
  final FirebaseAuthService _authService = FirebaseAuthService();

  Future<bool> registerUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var message = '';

      final isValid = validatePhoneNumber(phone) &&
          validateEmail(email) &&
          validatePassword(password) &&
          validateFirstName(firstName) &&
          validateLastName(lastName);

      if (isValid) {
        await _authService.registerWithEmail(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
        );
        return true;
      }

      if (!validateFirstName(firstName)) {
        message += 'الاسم الأول غير صالح.\n';
      }
      if (!validateLastName(lastName)) {
        message += 'اسم العائلة غير صالح.\n';
      }
      if (!validatePassword(password)) {
        message += 'كلمة مرور غير صالحة للاستعمال.\n';
      }
      if (!validateEmail(email)) {
        message += 'البريد الإلكتروني غير صالح.\n';
      }
      if (!validatePhoneNumber(phone)) {
        message += 'رقم هاتف غير قابل للاستعمال.\n';
      }

      GFToast.showToast(
        message,
        context,
        toastPosition: GFToastPosition.CENTER,
        backgroundColor: Colors.red,
      );
      return false;
    } on FirebaseAuthException catch (e) {
      var message = '';
      switch (e.code) {
        case 'email-already-in-use':
          message += 'البريد الإلكتروني مستخدم بالفعل.';
          break;
        case 'invalid-email':
          message += 'البريد الإلكتروني غير صالح.';
          break;
        case 'weak-password':
          message += 'كلمة المرور ضعيفة جداً. اختر كلمة أقوى.';
          break;
        case 'operation-not-allowed':
          message += 'التسجيل معطل حالياً. تواصل مع الدعم.';
          break;
        case 'too-many-requests':
          message += 'عدد كبير جداً من المحاولات. حاول لاحقاً.';
          break;
        case 'network-request-failed':
          message += 'فشل الاتصال بالإنترنت. تأكد من الشبكة.';
          break;
        default:
          message += 'حدث خطأ غير متوقع: ${e.message}';
      }

      GFToast.showToast(
        message,
        context,
        toastPosition: GFToastPosition.CENTER,
        backgroundColor: Colors.red,
      );
      return false;
    }
  }

  static bool validatePhoneNumber(String phone) {
    return RegExp(r'^(?:\+972|0)5\d{8}$').hasMatch(phone);
  }

  static bool validateEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
        .hasMatch(email);
  }

  static bool validatePassword(String password) {
    return password.length >= 6 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  static bool validateFirstName(String name) {
    return name.trim().length >= 2;
  }

  static bool validateLastName(String name) {
    return name.trim().length >= 2;
  }
}
