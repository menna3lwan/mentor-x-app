import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';

final class SplashPage extends StatelessWidget {
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onRetry;

  const SplashPage({
    super.key,
    required this.isLoading,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.onboarding;

    return AuthScaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App logo with gradient ring
                  ZoomIn(
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            context.brandPrimaryColor,
                            context.brandSecondaryColor.withValues(alpha: 0.3),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: context.brandPrimaryColor.withValues(alpha: 0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: context.backgroundSecondaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.school_rounded,
                          size: 40,
                          color: context.brandPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  const Gap(24),
                  // Clean Typography
                  FadeInUp(
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 200),
                    child: Column(
                      children: [
                        Text(
                          'MentorX',
                          style: context.titleH1Style.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          'STUDENT',
                          style: context.bodySecondaryStyle.copyWith(
                            color: context.textTertiaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 3.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Loading or Error at the bottom
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: isLoading
                    ? FadeIn(
                        duration: const Duration(milliseconds: 400),
                        delay: const Duration(milliseconds: 400),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.brandPrimaryColor.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      )
                    : FadeInUp(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                errorMessage ?? t.somethingWentWrong,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: context.statusDangerColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Gap(16),
                              MentorXButton(
                                onPressed: onRetry,
                                label: t.retry,
                                size: MentorXButtonSize.medium,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
