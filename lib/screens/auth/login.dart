import 'package:webestate/core/auth_service/fiirebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../l10n/generated/app_localizations.dart';
import 'forgot_password.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  bool obscureText = true;
  IconData visibilityIcon = Icons.visibility;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.5, curve: Curves.easeIn),
    ));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.8, curve: Curves.elasticOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    ref.listen<AsyncValue<UserModel>>(userProvider, (previous, next) {
      next.whenData((user) {
        if (!user.isGuest && mounted) {
          context.go('/profile_screen');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم تسجيل الدخول')),
          );
        }
      });
    });

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 400, // <<< --- WEB STYLE: Max Width Constraint
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Back button (Optional, for mobile flow)
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                const SizedBox(height: 16),

                /// Lottie Animation
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SizedBox(
                      height: 180,
                      child: Lottie.asset(
                        'assets/animations/login.json',
                        animate: true,
                        repeat: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                /// Login Form
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: FormBuilderTextField(
                              name: 'email',
                              decoration: _inputDecoration(
                                label: localizations.emailLabel,
                                hint: localizations.emailHint,
                                icon: Icons.email,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) =>
                              value == null || value.isEmpty ? localizations.emailError : null,
                            ),
                          ),
                          const SizedBox(height: 16),

                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: FormBuilderTextField(
                              name: 'password',
                              obscureText: obscureText,
                              decoration: _inputDecoration(
                                label: localizations.passwordLabel,
                                hint: localizations.passwordHint,
                                icon: Icons.lock,
                                suffixIcon: IconButton(
                                  icon: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: Icon(
                                      visibilityIcon,
                                      key: ValueKey(obscureText),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                      visibilityIcon =
                                      obscureText ? Icons.visibility_off : Icons.visibility;
                                    });
                                  },
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) =>
                              value == null || value.isEmpty ? localizations.passwordError : null,
                            ),
                          ),
                          const SizedBox(height: 8),

                          /// Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => showForgotPasswordDialog(context),
                              child: Text(
                                localizations.forgotPassword,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          /// Login Button
                          GFButton(
                            text: localizations.loginButton,
                            shape: GFButtonShape.pills,
                            fullWidthButton: true,
                            color: Colors.blue.shade700,
                            size: GFSize.LARGE,
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.saveAndValidate()) {
                                final email = _formKey.currentState!.fields['email']?.value;
                                final password = _formKey.currentState!.fields['password']?.value;
                                try {
                                  await ref
                                      .read(userProvider.notifier)
                                      .signInWithEmailAndPassword(email, password, context);
                                  await Future.delayed(const Duration(milliseconds: 500));
                                } catch (e) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error: ${e.toString()}')),
                                    );
                                  }
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                /// Sign up Section
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          localizations.noAccount,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.blueGrey.shade700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push('/register');
                          },
                          child: Text(
                            "سجل الان",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.blue),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 1.5),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    );
  }
}
