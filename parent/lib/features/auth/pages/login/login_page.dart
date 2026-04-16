import 'package:flutter/material.dart';

final class LoginPage extends StatelessWidget {
  final Widget? logo;
  final Widget? phoneField;
  final Widget? passwordField;
  final Widget? rememberMeRow;
  final Widget? forgetPasswordButton;
  final Widget? loginButton;
  final Widget? registerButton;

  const LoginPage({
    super.key,
    this.logo,
    this.phoneField,
    this.passwordField,
    this.rememberMeRow,
    this.forgetPasswordButton,
    this.loginButton,
    this.registerButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6D8BE),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (logo != null) logo!,
                  const SizedBox(height: 40),
                  if (phoneField != null) phoneField!,
                  const SizedBox(height: 20),
                  if (passwordField != null) passwordField!,
                  const SizedBox(height: 8),
                  if (rememberMeRow != null) rememberMeRow!,
                  const SizedBox(height: 10),
                  if (forgetPasswordButton != null) forgetPasswordButton!,
                  const SizedBox(height: 15),
                  if (loginButton != null) loginButton!,
                  const SizedBox(height: 16),
                  if (registerButton != null) registerButton!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
