import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

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
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: backButton,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Gap(20),
              // Glassmorphic Logo/Icon
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: context.backgroundSecondaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: context.brandPrimaryColor.withValues(alpha: 0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.security_rounded,
                    color: context.brandPrimaryColor,
                    size: 48,
                  ),
                ),
              ),
              const Gap(40),
              if (title != null) 
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 200),
                  child: title!,
                ),
              const Gap(12),
              if (subtitle != null)
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 300),
                  child: subtitle!,
                ),
              const Gap(56),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 400),
                child: otpFields,
              ),
              const Gap(56),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 500),
                child: verifyButton,
              ),
              const Gap(24),
              if (resendButton != null)
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 600),
                  child: resendButton!,
                ),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}
