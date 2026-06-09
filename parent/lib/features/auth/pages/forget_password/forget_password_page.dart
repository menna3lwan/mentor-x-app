import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/routing/app_routes.dart';

final class ForgetPasswordPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? phoneField;
  final Widget? sendCodeButton;
  final Widget? backToLoginButton;

  const ForgetPasswordPage({
    super.key,
    required this.title,
    required this.subtitle,
    this.phoneField,
    this.sendCodeButton,
    this.backToLoginButton,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        const LoginPageRoute().go(context);
      },
      child: Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        body: Column(
          children: [
            // Premium Header
            _BuildHeader(title: title),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: Column(
                      children: [
                        FadeInDown(
                          duration: const Duration(milliseconds: 500),
                          delay: const Duration(milliseconds: 200),
                          child: Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: context.textSecondaryColor,
                              height: 1.6,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Gap(48),
                        if (phoneField != null)
                          FadeInUp(
                            duration: const Duration(milliseconds: 500),
                            delay: const Duration(milliseconds: 300),
                            child: phoneField!,
                          ),
                        const Gap(40),
                        if (sendCodeButton != null)
                          FadeInUp(
                            duration: const Duration(milliseconds: 500),
                            delay: const Duration(milliseconds: 400),
                            child: sendCodeButton!,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            if (backToLoginButton != null)
              Container(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 16,
                  bottom: MediaQuery.of(context).padding.bottom + 16,
                ),
                child: FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 500),
                  child: backToLoginButton!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final String title;

  const _BuildHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 40,
        left: 20,
        right: 20,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  const LoginPageRoute().go(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: context.textPrimaryColor,
                  size: 20,
                ),
              ),
              Expanded(
                child: FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    Translations.of(
                      context,
                    ).parent.auth.passwordRecoveryHeading,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const Gap(32),
          ZoomIn(
            duration: const Duration(milliseconds: 600),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: context.brandPrimaryColor.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.lock_reset_rounded,
                color: context.brandPrimaryColor,
                size: 48,
              ),
            ),
          ),
          const Gap(24),
          FadeInDown(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 300),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: context.textPrimaryColor,
                letterSpacing: -1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
