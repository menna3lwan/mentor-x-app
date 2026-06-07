import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent/core/core.dart';
import '../bloc/onboarding_bloc.dart';
import 'splash_screen_page.dart';

final class SplashScreenPageWrapper extends StatelessWidget {
  const SplashScreenPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(
        onboardingRepository: context.read<OnboardingRepository>(),
        authenticationRepository: context.read<AuthenticationRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(const OnboardingStarted()),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          switch (state.step) {
            case OnboardingStep.authenticated:
              const HomePageRoute().go(context);
            case OnboardingStep.needsLogin:
              const LoginPageRoute().go(context);
            case OnboardingStep.needsOnboarding:
              const OnboardingRoute().go(context);
            case OnboardingStep.initial:
            case OnboardingStep.loading:
              break;
          }
        },
        child: const SplashScreenPage(),
      ),
    );
  }
}
