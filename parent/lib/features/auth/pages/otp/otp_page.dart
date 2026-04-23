import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class OtpPage extends StatelessWidget {
  final Widget? backButton;
  final Widget? title;
  final Widget? subtitle;
  final Widget otpFields;
  final Widget verifyButton;
  final Widget? resendButton;

  const OtpPage({
    super.key,
    this.backButton,
    this.title,
    this.subtitle,
    required this.otpFields,
    required this.verifyButton,
    this.resendButton,
  });

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      appBarLeading: backButton,
      title: title,
      subtitle: subtitle,
      body: Center(child: otpFields),
      primaryButton: verifyButton,
      secondaryButton: resendButton,
    );
  }
}
