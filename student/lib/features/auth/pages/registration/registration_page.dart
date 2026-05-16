import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import 'steps/start_step.dart';
import 'steps/otp_step.dart';
import 'steps/personal_info_step.dart';
import 'steps/academic_info_step.dart';
import 'steps/location_step.dart';
import 'steps/security_step.dart';

final class RegistrationPage extends StatelessWidget {
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
    final List<String> steps = [
      context.t.auth.welcome,
      context.t.auth.otpVerifyTitle,
      context.t.auth.registerTitle,
      context.t.auth.gradeLabel,
      context.t.auth.governorateLabel,
      context.t.auth.passwordAndPhotosLabel,
    ];

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _buildHeader(context, steps[currentStep]),
          _buildStepper(context, steps),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ZoomIn(
                key: ValueKey(currentStep),
                child: _buildCurrentStep(context),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FadeInUp(
        duration: const Duration(milliseconds: 500),
        child: _buildBottomActions(context),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            12,
            MediaQuery.paddingOf(context).top + 8,
            12,
            16,
          ),
          decoration: BoxDecoration(
            color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
            border: Border(
              bottom: BorderSide(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: onBack,
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.t.auth.registrationLabel,
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      title,
                      style: context.titleH1Style.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepper(BuildContext context, List<String> steps) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
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
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: isCompleted
                            ? context.brandPrimaryColor
                            : context.borderPrimaryColor.withValues(alpha: 0.1),
                        boxShadow: isCompleted
                            ? [
                                BoxShadow(
                                  color: context.brandPrimaryColor.withValues(
                                    alpha: 0.3,
                                  ),
                                  blurRadius: 8,
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? 40 : 32,
      height: isActive ? 40 : 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted
            ? context.brandPrimaryColor
            : isActive
            ? context.brandPrimaryColor.withValues(alpha: 0.2)
            : context.backgroundSecondaryColor,
        border: isActive
            ? Border.all(color: context.brandPrimaryColor, width: 3)
            : isCompleted
            ? null
            : Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
                width: 2,
              ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: context.brandPrimaryColor.withValues(alpha: 0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Center(
        child: isCompleted
            ? const Icon(Icons.check_rounded, size: 20, color: Colors.white)
            : Text(
                step.toString(),
                style: context.bodyPrimaryStyle.copyWith(
                  fontSize: isActive ? 16 : 14,
                  color: isActive || isCompleted
                      ? Colors.white
                      : context.textSecondaryColor,
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
    final t = context.t;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            MediaQuery.paddingOf(context).bottom + 24,
          ),
          decoration: BoxDecoration(
            color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
            border: Border(
              top: BorderSide(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MentorXButton(
                onPressed: isLoading
                    ? null
                    : (currentStep == 5 ? onSubmit : onNext),
                label: currentStep == 5
                    ? t.auth.submitRegistration
                    : t.auth.commonNext,
                loading: isLoading,
                size: MentorXButtonSize.large,
              ),
              if (currentStep == 0) ...[
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(
                      context.t.auth.alreadyHaveAccount,
                      style: context.bodySecondaryStyle.copyWith(
                        color: context.textSecondaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: isLoading ? null : onLogin,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: Text(
                        context.t.auth.loginButton,
                        style: context.bodySecondaryStyle.copyWith(
                          color: context.brandPrimaryColor,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}



class _FadeInScale extends StatefulWidget {
  final Widget child;
  const _FadeInScale({required this.child});

  @override
  State<_FadeInScale> createState() => _FadeInScaleState();
}

class _FadeInScaleState extends State<_FadeInScale>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
