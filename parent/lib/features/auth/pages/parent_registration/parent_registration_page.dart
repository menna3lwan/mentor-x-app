import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

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
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      backgroundColor: palette.backgroundPrimary,
      body: Column(
        children: [
          // Premium Header
          _BuildHeader(
            palette: palette,
            title: title,
            currentStep: currentStep,
            leading: appBarLeading,
          ),
          
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: palette.backgroundSecondary.withValues(alpha: 0.5),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: FadeInUp(
                    key: ValueKey('step_$currentStep'),
                    duration: const Duration(milliseconds: 500),
                    child: body,
                  ),
                ),
              ),
            ),
          ),
          
          // Bottom Actions with glassmorphism effect
          Container(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: MediaQuery.of(context).padding.bottom + 20,
            ),
            decoration: BoxDecoration(
              color: palette.backgroundPrimary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 200),
                  child: primaryButton,
                ),
                if (secondaryButton != null) ...[
                  const Gap(16),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 300),
                    child: secondaryButton!,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final String title;
  final int currentStep;
  final Widget? leading;

  const _BuildHeader({
    required this.palette,
    required this.title,
    required this.currentStep,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 40,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (leading != null) 
                leading! 
              else 
                const SizedBox(width: 48),
              Expanded(
                child: FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: palette.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48), // Spacer
            ],
          ),
          const Gap(32),
          // Step Progress with premium indicators
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: List.generate(3, (index) {
                final isActive = index <= currentStep;
                final isCurrent = index == currentStep;
                return Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: isCurrent ? 8 : 6,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isActive 
                          ? palette.brandPrimary 
                          : palette.brandPrimary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: isCurrent ? [
                        BoxShadow(
                          color: palette.brandPrimary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ] : null,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
