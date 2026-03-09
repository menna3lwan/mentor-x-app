import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'splash_page_event.dart';
part 'splash_page_state.dart';

final class SplashPageBloc extends Bloc<SplashPageEvent, SplashPageState> {
  final StudentAuthenticationRepository _authRepository;
  final CacheRepository _cacheRepository;

  SplashPageBloc({
    required StudentAuthenticationRepository authRepository,
    required CacheRepository cacheRepository,
  })  : _authRepository = authRepository,
        _cacheRepository = cacheRepository,
        super(const SplashPageState()) {
    on<SplashPageStarted>(_onStarted);
  }

  Future<void> _onStarted(
    SplashPageStarted event,
    Emitter<SplashPageState> emit,
  ) async {
    // Brief splash delay for branding
    await Future.delayed(const Duration(milliseconds: 1500));

    try {
      final user = await _authRepository.getCachedUser();
      if (user != null) {
        emit(state.copyWith(
          status: SplashPageStatus.authenticated,
          user: user,
        ));
        return;
      }
    } catch (_) {
      // No cached user - proceed to check onboarding
    }

    // Check if onboarding was completed
    final hasSeenOnboarding = await _cacheRepository.get('has_seen_onboarding');
    if (hasSeenOnboarding == 'true') {
      emit(state.copyWith(status: SplashPageStatus.unauthenticated));
    } else {
      emit(state.copyWith(status: SplashPageStatus.onboarding));
    }
  }
}
