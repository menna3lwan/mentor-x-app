import 'dart:ui';
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
    final t = context.t.student;
    final List<String> steps = [
      t['welcome']?.toString() ?? 'Welcome',
      t['otpVerifyTitle']?.toString() ?? 'Verify',
      t['profile']?.toString() ?? 'Profile',
      t['academicInfo']?.toString() ?? 'Academic',
      t['locationDetails']?.toString() ?? 'Location',
      t['securityAndIdentity']?.toString() ?? 'Security',
    ];

    return AuthScaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBarLeading: IconButton(
        onPressed: onBack,
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: context.textPrimaryColor,
          size: 20,
        ),
      ),
      title: Text(steps[currentStep]),
      progressIndicator: FadeInDown(
        duration: const Duration(milliseconds: 500),
        delay: const Duration(milliseconds: 100),
        child: _buildStepper(context, steps),
      ),
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: ZoomIn(
                    key: ValueKey(currentStep),
                    child: _buildCurrentStep(context),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      footer: FadeInUp(
        duration: const Duration(milliseconds: 500),
        child: _buildBottomActions(context),
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
                style: TextStyle(
                  fontSize: isActive ? 16 : 14,
                  color: isActive
                      ? context.brandPrimaryColor
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
    final t = context.t.student;
    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.paddingOf(context).bottom + 24,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border(
          top: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.05),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, -10),
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
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  t['alreadyHaveAccount'] ?? 'Already have an account?',
                  style: TextStyle(
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
                    t['signIn'] ?? 'Sign In',
                    style: TextStyle(
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
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
          ),
        ),
        Positioned(
          bottom: 200,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(seconds: 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: const SizedBox.expand(),
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
