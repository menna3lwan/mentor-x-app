import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'steps/start_step.dart';
import 'steps/otp_step.dart';
import 'steps/personal_info_step.dart';
import 'steps/academic_info_step.dart';
import 'steps/location_step.dart';
import 'steps/security_step.dart';

class RegistrationPage extends StatelessWidget {
  final int currentStep;
  final bool isLoading;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onSubmit;
  final VoidCallback onLogin;

  const RegistrationPage({
    super.key,
    required this.currentStep,
    required this.isLoading,
    required this.onBack,
    required this.onNext,
    required this.onSubmit,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final steps = [
      t['welcome'] ?? 'Welcome',
      t['otpVerifyTitle'] ?? 'Verify',
      t['profile'] ?? 'Profile',
      t['academicInfo'] ?? 'Academic',
      t['locationDetails'] ?? 'Location',
      t['securityAndIdentity'] ?? 'Security',
    ];

    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      backgroundColor: palette.backgroundPrimary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: AppBar(
            backgroundColor: palette.backgroundPrimary,
            elevation: 0,
            title: Text(
              steps[currentStep],
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                letterSpacing: -0.5,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: palette.textPrimary,
                size: 20,
              ),
              onPressed: onBack,
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Column(
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 100),
            child: _buildStepper(context, steps),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: FadeInRight(
                key: ValueKey(currentStep),
                duration: const Duration(milliseconds: 500),
                child: _buildCurrentStep(context),
              ),
            ),
          ),
          FadeInUp(
            duration: const Duration(milliseconds: 500),
            child: _buildBottomActions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper(BuildContext context, List<String> steps) {
    final palette = MentorXThemeColorPalette.light;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        children: List.generate(steps.length, (index) {
          final isCompleted = index < currentStep;
          final isActive = index == currentStep;
          return Expanded(
            child: Row(
              children: [
                _buildStepCircle(context, index + 1, isActive, isCompleted),
                if (index < steps.length - 1)
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: isCompleted
                            ? palette.brandPrimary
                            : palette.brandPrimary.withValues(alpha: 0.1),
                        boxShadow: isCompleted
                            ? [
                                BoxShadow(
                                  color: palette.brandPrimary.withValues(
                                    alpha: 0.2,
                                  ),
                                  blurRadius: 4,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStepCircle(
    BuildContext context,
    int step,
    bool isActive,
    bool isCompleted,
  ) {
    final palette = MentorXThemeColorPalette.light;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 36 : 32,
      height: isActive ? 36 : 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted
            ? palette.brandPrimary
            : isActive
            ? palette.brandPrimary.withValues(alpha: 0.15)
            : palette.backgroundSecondary,
        border: isActive
            ? Border.all(color: palette.brandPrimary, width: 3)
            : isCompleted
            ? null
            : Border.all(
                color: palette.textTertiary.withValues(alpha: 0.3),
                width: 1.5,
              ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: palette.brandPrimary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Center(
        child: isCompleted
            ? Icon(Icons.check_rounded, size: 20, color: palette.textForeground)
            : Text(
                step.toString(),
                style: TextStyle(
                  fontSize: isActive ? 16 : 14,
                  color: isActive
                      ? palette.brandPrimary
                      : palette.textSecondary,
                  fontWeight: FontWeight.w900,
                ),
              ),
      ),
    );
  }

  Widget _buildCurrentStep(BuildContext context) {
    switch (currentStep) {
      case 0:
        return const StartStep();
      case 1:
        return const OtpStep();
      case 2:
        return const PersonalInfoStep();
      case 3:
        return const AcademicInfoStep();
      case 4:
        return const LocationStep();
      case 5:
        return const SecurityStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomActions(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).padding.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, -12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MentorXButton(
            onPressed: isLoading
                ? null
                : (currentStep == 5 ? onSubmit : onNext),
            label: currentStep == 5
                ? (t['completeRegistration'] ?? 'Complete Registration')
                : (currentStep == 0
                    ? (t['commonNext'] ?? 'Verify & Continue')
                    : (t['commonNext'] ?? 'Continue')),
            loading: isLoading,
          ),
          if (currentStep == 0) ...[
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  t['alreadyHaveAccount'] ?? 'Already have an account?',
                  style: TextStyle(
                    color: palette.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: isLoading ? null : onLogin,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: Text(
                    t['signIn'] ?? 'Sign In',
                    style: TextStyle(
                      color: palette.brandPrimary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

}
