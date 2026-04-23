import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class ParentRegistrationPage extends StatelessWidget {
  final Widget? appBarLeading;
  final String title;
  final int currentStep;
  final Widget body;
  final Widget primaryButton;
  final Widget? secondaryButton;

  const ParentRegistrationPage({
    super.key,
    this.appBarLeading,
    required this.title,
    required this.currentStep,
    required this.body,
    required this.primaryButton,
    this.secondaryButton,
  });

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      appBarLeading: appBarLeading,
      title: Text(title),
      progressIndicator: StepProgressIndicator(
        currentStep: currentStep,
        totalSteps: 3,
      ),
      body: body,
      primaryButton: primaryButton,
      secondaryButton: secondaryButton,
    );
  }
}
