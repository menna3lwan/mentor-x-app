import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class ForgetPasswordPage extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? phoneField;
  final Widget? sendCodeButton;
  final Widget? backToLoginButton;

  const ForgetPasswordPage({
    super.key,
    this.title,
    this.subtitle,
    this.phoneField,
    this.sendCodeButton,
    this.backToLoginButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              if (title != null) title!,
              const SizedBox(height: 12),
              if (subtitle != null) subtitle!,
              const SizedBox(height: 40),
              if (phoneField != null) phoneField!,
              const SizedBox(height: 30),
              if (sendCodeButton != null) sendCodeButton!,
              const Spacer(),
              if (backToLoginButton != null) backToLoginButton!,
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
