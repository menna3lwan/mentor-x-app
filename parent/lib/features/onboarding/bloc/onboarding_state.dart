part of 'onboarding_bloc.dart';

enum OnboardingStep {
  loading,
  needsOnboarding,
  needsLogin,
  authenticated,
}

final class OnboardingState extends Equatable {
  final OnboardingStep step;

  const OnboardingState._({required this.step});

  const OnboardingState.loading() : this._(step: OnboardingStep.loading);

  const OnboardingState.needsOnboarding()
    : this._(step: OnboardingStep.needsOnboarding);

  const OnboardingState.needsLogin() : this._(step: OnboardingStep.needsLogin);

  const OnboardingState.authenticated()
    : this._(step: OnboardingStep.authenticated);

  @override
  List<Object?> get props => [step];
}
