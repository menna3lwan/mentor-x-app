import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'bloc/student_registration_bloc.dart';
import 'registration_page.dart';
import '../../../../core/routing/app_routes.dart';

final class RegistrationPageWrapper extends StatelessWidget {
  const RegistrationPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<StudentRegistrationBloc, StudentRegistrationPresentationEvent>(
      listener: (context, event) {
        if (event is StudentRegistrationSuccessPresentationEvent) {
          OtpPageRoute(
            phoneNumber: context.read<StudentRegistrationBloc>().state.phone,
            otpLength: 6, // Default or from result
            otpDurationSeconds: event.otpExpiresInSeconds,
          ).go(context);
        } else if (event is StudentRegistrationFailurePresentationEvent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(event.message),
              backgroundColor: MentorXThemeColorPalette.light.statusDanger,
            ),
          );
        }
      },
      child: BlocBuilder<StudentRegistrationBloc, StudentRegistrationState>(
        builder: (context, state) {
          return RegistrationPage(
            currentStep: state.currentStep,
            isLoading: state.loadingState.isLoading,
            onBack: () {
              if (state.currentStep == 0) {
                const LoginPageRoute().go(context);
              } else {
                context.read<StudentRegistrationBloc>().add(StudentRegistrationPreviousStepRequested());
              }
            },
            onNext: () {
              context.read<StudentRegistrationBloc>().add(StudentRegistrationNextStepRequested());
            },
            onSubmit: () {
              context.read<StudentRegistrationBloc>().add(StudentRegistrationSubmitted());
            },
          );
        },
      ),
    );
  }
}
