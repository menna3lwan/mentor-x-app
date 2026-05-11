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
            context.showSuccessSnackBar(
              'Verification code sent to your phone.',
            );
          case StudentRegistrationFailurePresentationEvent(:final message):
            context.showErrorSnackBar(message);
        }
      },
      child: Builder(
        builder: (context) {
          final currentStep = context.select(
            (StudentRegistrationBloc bloc) => bloc.state.currentStep,
          );
          final isLoading = context.select(
            (StudentRegistrationBloc bloc) => bloc.state.loadingState.isLoading,
          );

          return RegistrationPage(
            currentStep: currentStep,
            isLoading: isLoading,
            onBack: () {
              if (currentStep == 0) {
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        backgroundColor: context.backgroundSecondaryColor,
        surfaceTintColor: Colors.transparent,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: context.statusSuccessColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.statusSuccessColor.withValues(alpha: 0.1),
                ),
              ),
              child: Icon(
                Icons.check_circle_rounded,
                size: 64,
                color: context.statusSuccessColor,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Registration Successful!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: context.textPrimaryColor,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your account has been created successfully and is now pending approval.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: context.textSecondaryColor,
                height: 1.6,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (studentCode != null) ...[
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: context.backgroundPrimaryColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'YOUR STUDENT CODE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: context.textTertiaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      studentCode,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 48),
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
