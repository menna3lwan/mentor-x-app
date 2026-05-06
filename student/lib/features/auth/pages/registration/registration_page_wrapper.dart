import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'bloc/student_registration_bloc.dart';
import '../../../../core/core.dart';
import 'registration_page.dart';

final class RegistrationPageWrapper extends StatelessWidget {
  const RegistrationPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      StudentRegistrationBloc,
      StudentRegistrationPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case StudentRegistrationSuccessPresentationEvent(:final studentCode):
            _showSuccessDialog(context, studentCode);
          case StudentRegistrationOtpSentPresentationEvent():
            context.showSuccessSnackBar('Verification code sent to your phone.');
          case StudentRegistrationFailurePresentationEvent(:final message):
            context.showErrorSnackBar(message);
        }
      },
      child: BlocBuilder<StudentRegistrationBloc, StudentRegistrationState>(
        builder: (context, state) {
          return RegistrationPage(
            currentStep: state.currentStep,
            isLoading: state.loadingState.isLoading,
            onBack: () {
              if (state.currentStep == 0) {
                if (context.canPop()) {
                  context.pop();
                } else {
                  const LoginPageRoute().go(context);
                }
              } else {
                context.read<StudentRegistrationBloc>().add(
                  StudentRegistrationPreviousStepRequested(),
                );
              }
            },
            onNext: () {
              context.read<StudentRegistrationBloc>().add(
                StudentRegistrationNextStepRequested(),
              );
            },
            onSubmit: () {
              context.read<StudentRegistrationBloc>().add(
                StudentRegistrationSubmitted(),
              );
            },
            onLogin: () {
              if (context.canPop()) {
                context.pop();
              } else {
                const LoginPageRoute().go(context);
              }
            },
          );
        },
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, String? studentCode) {
    final palette = MentorXThemeColorPalette.light;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: palette.backgroundPrimary,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: palette.statusSuccess.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline_rounded,
                size: 64,
                color: palette.statusSuccess,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Registration Successful!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: palette.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your account has been created successfully and is now pending approval.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: palette.textSecondary,
                height: 1.5,
              ),
            ),
            if (studentCode != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: palette.backgroundSecondary,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: palette.brandPrimary.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'YOUR STUDENT CODE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: palette.textTertiary,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      studentCode,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: palette.brandPrimary,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 32),
            MentorXButton(
              label: 'Go to Login',
              onPressed: () {
                Navigator.of(context).pop();
                const LoginPageRoute().go(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
