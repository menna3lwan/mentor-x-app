import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/core.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

final class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingRepository _onboardingRepository;
  final AuthenticationRepository _authenticationRepository;
  final AnalyticsService _analyticsService;
  static final MentorXLogger _logger = MentorXLogger('OnboardingBloc');

  OnboardingBloc({
    required OnboardingRepository onboardingRepository,
    required AuthenticationRepository authenticationRepository,
    required AnalyticsService analyticsService,
  }) : _onboardingRepository = onboardingRepository,
       _authenticationRepository = authenticationRepository,
       _analyticsService = analyticsService,
       super(OnboardingState.initial) {
    on<OnboardingStarted>(_onStarted);
    on<OnboardingCompleted>(_onCompleted);
  }

  Future<void> _onStarted(
    OnboardingStarted event,
    Emitter<OnboardingState> emit,
  ) async {
    _logger.info('Onboarding started check...');
    emit(state.copyWith(step: OnboardingStep.loading));
    
    // Add artificial delay for splash logo display
    await Future.delayed(const Duration(seconds: 2));
    
    try {
      final user = await _authenticationRepository.getCachedUser();
      if (user != null) {
        _logger.info('User is already cached (authenticated). Navigating to home.');
        emit(state.copyWith(step: OnboardingStep.authenticated));
        return;
      }

      final completed = await _onboardingRepository.isOnboardingCompleted();
      if (completed) {
        _logger.info('Onboarding already completed. Navigating to login.');
        emit(state.copyWith(step: OnboardingStep.needsLogin));
        return;
      }

      _logger.info('First-time user. Showing onboarding walkthrough.');
      _analyticsService.logEvent(name: AnalyticsEvents.walkthroughStarted);
      emit(state.copyWith(step: OnboardingStep.needsOnboarding));
    } catch (e, s) {
      _logger.error('Error during onboarding splash checks', e, s);
      // Fallback: request onboarding
      emit(state.copyWith(step: OnboardingStep.needsOnboarding));
    }
  }

  Future<void> _onCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) async {
    _logger.info('Onboarding walkthrough completed. Updating preference.');
    try {
      await _onboardingRepository.completeOnboarding();
      _logger.info('Successfully saved onboarding completed status.');
      emit(state.copyWith(step: OnboardingStep.needsLogin));
    } catch (e, s) {
      _logger.error('Failed to save onboarding completed status', e, s);
      emit(state.copyWith(step: OnboardingStep.needsLogin));
    }
  }
}
