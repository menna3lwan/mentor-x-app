import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/core.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

final class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingRepository _onboardingRepository;
  final AuthenticationRepository _authenticationRepository;
  final AnalyticsService _analyticsService;

  OnboardingBloc({
    required OnboardingRepository onboardingRepository,
    required AuthenticationRepository authenticationRepository,
    required AnalyticsService analyticsService,
  }) : _onboardingRepository = onboardingRepository,
       _authenticationRepository = authenticationRepository,
       _analyticsService = analyticsService,
       super(const OnboardingState.loading()) {
    on<OnboardingStarted>(_onStarted);
    on<OnboardingCompleted>(_onCompleted);
  }

  Future<void> _onStarted(
    OnboardingStarted event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const OnboardingState.loading());
    final user = await _authenticationRepository.getCachedUser();
    if (user != null) {
      emit(const OnboardingState.authenticated());
      return;
    }

    final completed = await _onboardingRepository.isOnboardingCompleted();
    if (completed) {
      emit(const OnboardingState.needsLogin());
      return;
    }

    _analyticsService.logEvent(name: AnalyticsEvents.walkthroughStarted);
    emit(const OnboardingState.needsOnboarding());
  }

  Future<void> _onCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) async {
    await _onboardingRepository.completeOnboarding();
    emit(const OnboardingState.needsLogin());
  }
}
