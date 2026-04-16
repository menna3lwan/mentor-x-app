import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'steps/personal_info_step.dart';
import 'steps/academic_info_step.dart';
import 'steps/location_step.dart';
import 'steps/parent_info_step.dart';
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
    final steps = [
      'Personal',
      'Academic',
      'Location',
      'Parent',
      'Security',
    ];

    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      backgroundColor: palette.backgroundPrimary,
      appBar: AppBar(
        title: Text(steps[currentStep]),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: Column(
        children: [
          _buildStepper(context, steps),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _buildCurrentStep(context),
            ),
          ),
          _buildBottomActions(context),
        ],
      ),
    );
  }

  Widget _buildStepper(BuildContext context, List<String> steps) {
    final palette = MentorXThemeColorPalette.light;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      color: palette.backgroundSecondary,
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
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: isCompleted
                          ? palette.brandPrimary
                          : palette.textTertiary,
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
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted
            ? palette.brandPrimary
            : isActive
            ? palette.brandPrimary.withValues(alpha: 0.1)
            : palette.textTertiary,
        border: isActive
            ? Border.all(color: palette.brandPrimary, width: 2)
            : null,
      ),
      child: Center(
        child: isCompleted
            ? Icon(Icons.check, size: 14, color: palette.textForeground)
            : Text(
                step.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isActive
                      ? palette.brandPrimary
                      : palette.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  Widget _buildCurrentStep(BuildContext context) {
    switch (currentStep) {
      case 0:
        return const PersonalInfoStep();
      case 1:
        return const AcademicInfoStep();
      case 2:
        return const LocationStep();
      case 3:
        return const ParentInfoStep();
      case 4:
        return const SecurityStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomActions(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    return Container(
      padding: const EdgeInsets.all(20),
      color: palette.backgroundSecondary,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : (currentStep == 4 ? onSubmit : onNext),
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        currentStep == 4
                            ? 'Complete Registration'
                            : 'Next Step',
                      ),
              ),
            ),
            if (currentStep == 0)
              TextButton(
                onPressed: isLoading ? null : onLogin,
                child: const Text('Already have an account? Login'),
              ),
          ],
        ),
      ),
    );
  }
}
