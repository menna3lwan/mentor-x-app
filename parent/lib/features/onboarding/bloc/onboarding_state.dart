part of 'onboarding_bloc.dart';

enum OnboardingStep {
  initial,
  loading,
  needsOnboarding,
  needsLogin,
  authenticated;

  bool get isInitial => this == OnboardingStep.initial;
  bool get isLoading => this == OnboardingStep.loading;
  bool get isNeedsOnboarding => this == OnboardingStep.needsOnboarding;
  bool get isNeedsLogin => this == OnboardingStep.needsLogin;
  bool get isAuthenticated => this == OnboardingStep.authenticated;
}

final class OnboardingState extends Equatable {
  final OnboardingStep step;
  final String? errorMessage;

  const OnboardingState({
    required this.step,
    this.errorMessage,
  });

  static const OnboardingState initial = OnboardingState(
    step: OnboardingStep.initial,
  );

  OnboardingState copyWith({
    OnboardingStep? step,
    MentorXNullableValue<String?>? errorMessage,
  }) {
    return OnboardingState(
      step: step ?? this.step,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [step, errorMessage];
}
