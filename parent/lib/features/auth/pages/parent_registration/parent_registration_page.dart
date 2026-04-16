import 'package:flutter/material.dart';

final class ParentRegistrationPage extends StatelessWidget {
  final Widget? appBarLeading;
  final Widget? title;
  final Widget? progressIndicator;
  final Widget? body;
  final Widget? primaryButton;
  final Widget? secondaryButton;

  const ParentRegistrationPage({
    super.key,
    this.appBarLeading,
    this.title,
    this.progressIndicator,
    this.body,
    this.primaryButton,
    this.secondaryButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6D8BE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: appBarLeading,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) title!,
              const SizedBox(height: 12),
              if (progressIndicator != null) progressIndicator!,
              const SizedBox(height: 16),
              if (body != null) Expanded(child: body!),
              const SizedBox(height: 16),
              if (primaryButton != null) primaryButton!,
              const SizedBox(height: 10),
              if (secondaryButton != null) secondaryButton!,
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
