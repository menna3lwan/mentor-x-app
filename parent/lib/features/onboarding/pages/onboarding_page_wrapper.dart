import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent/core/core.dart';
import '../bloc/onboarding_bloc.dart';
import 'onboarding_page.dart';

final class OnboardingPageWrapper extends StatelessWidget {
  const OnboardingPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(
        onboardingRepository: context.read<OnboardingRepository>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      ),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state.step == OnboardingStep.needsLogin) {
            const LoginPageRoute().go(context);
          }
        },
        child: Builder(
          builder: (context) {
            return OnboardingPage(
              onCompleted: () {
                context.read<OnboardingBloc>().add(const OnboardingCompleted());
              },
            );
          },
        ),
      ),
    );
  }
}
