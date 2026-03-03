import 'package:flutter/material.dart';

final class OtpPage extends StatelessWidget {
  final Widget? backButton;
  final Widget? title;
  final Widget? subtitle;
  final Widget? otpFields;
  final Widget? verifyButton;
  final Widget? resendButton;

  const OtpPage({
    super.key,
    this.backButton,
    this.title,
    this.subtitle,
    this.otpFields,
    this.verifyButton,
    this.resendButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6D8BE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              if (backButton != null) backButton!,
              const SizedBox(height: 30),
              if (title != null) title!,
              const SizedBox(height: 8),
              if (subtitle != null) subtitle!,
              const SizedBox(height: 50),
              if (otpFields != null) otpFields!,
              const SizedBox(height: 50),
              if (verifyButton != null) verifyButton!,
              const SizedBox(height: 25),
              if (resendButton != null) resendButton!,
            ],
          ),
        ),
      ),
    );
  }
}
