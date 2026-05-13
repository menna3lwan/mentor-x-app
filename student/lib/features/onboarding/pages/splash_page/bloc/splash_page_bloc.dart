import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'splash_page_event.dart';
part 'splash_page_state.dart';

sealed class SplashPagePresentationEvent {
  const SplashPagePresentationEvent();
}

final class SplashNavigatePresentationEvent
    extends SplashPagePresentationEvent {
  final String route;

  const SplashNavigatePresentationEvent({required this.route});
}

final class SplashPageBloc extends Bloc<SplashPageEvent, SplashPageState>
    with BlocPresentationMixin<SplashPageState, SplashPagePresentationEvent> {
  final StudentAuthenticationRepository _authenticationRepository;
  final CacheRepository _cacheRepository;
  final AnalyticsService _analyticsService;

  SplashPageBloc({
    required StudentAuthenticationRepository authenticationRepository,
    required CacheRepository cacheRepository,
    required AnalyticsService analyticsService,
  }) : _authenticationRepository = authenticationRepository,
       _cacheRepository = cacheRepository,
       _analyticsService = analyticsService,
       super(SplashPageState.initial) {
    on<SplashPageStarted>(_onStarted);
    on<SplashPageRetryRequested>(_onRetryRequested);
  }

  Future<void> _onStarted(
    SplashPageStarted event,
    Emitter<SplashPageState> emit,
  ) async {
    _analyticsService.logEvent(name: AnalyticsEvents.splashViewed);
    await _resolveNextRoute(emit);
  }

  Future<void> _onRetryRequested(
    SplashPageRetryRequested event,
    Emitter<SplashPageState> emit,
  ) async {
    await _resolveNextRoute(emit);
  }

  Future<void> _resolveNextRoute(Emitter<SplashPageState> emit) async {
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );

    try {
      final startedAt = DateTime.now();
      final route = await _computeNextRoute();

      final elapsed = DateTime.now().difference(startedAt);
      const minimumBrandingDelay = Duration(milliseconds: 1200);
      if (elapsed < minimumBrandingDelay) {
        await Future<void>.delayed(minimumBrandingDelay - elapsed);
      }

      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(SplashNavigatePresentationEvent(route: route));
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<String> _computeNextRoute() async {
    StudentEntity? user = await _authenticationRepository.getCachedUser();

    if (user != null) {
      try {
        user = await _authenticationRepository.getAccountStatus().timeout(
          const Duration(seconds: 3),
        );
      } catch (e) {
        final MentorXLogger logger = MentorXLogger('SplashPageBloc');
        logger.warning('Failed to refresh account status: $e');
        
        if (e is AuthenticationRepositoryException) {
          if (e.code == AuthenticationRepositoryExceptionCode.invalidCredentials ||
              e.code == AuthenticationRepositoryExceptionCode.failedToRefreshToken) {
            logger.info('Session is invalid or expired, redirecting to login');
            return '/login';
          }
        }
        
        // Fallback to cached user in unstable network conditions (e.g. timeouts, server errors)
        logger.debug('Non-auth error during status check, falling back to cached user data');
      }

      final resolvedUser = user;
      if (resolvedUser == null) {
        return '/login';
      }

      return switch (resolvedUser.status) {
        StudentStatus.active => '/',
        StudentStatus.pending => '/status-pending',
        StudentStatus.suspended => '/status-blocked',
        StudentStatus.rejected => '/status-rejected',
        StudentStatus.inactive => '/status-rejected',
      };
    }

    final hasSeenOnboarding = await _cacheRepository.get(
      CacheKeys.hasSeenOnboarding,
    );
    if (hasSeenOnboarding != 'true') {
      return '/walkthrough';
    }

    final selectedTenantId = await _cacheRepository.get(CacheKeys.tenantId);
    if (selectedTenantId == null || selectedTenantId.isEmpty) {
      await _cacheRepository.put(CacheKeys.tenantId, '1');
      await _cacheRepository.put(CacheKeys.tenantName, 'Mr. Ahmed Physics');
    }

    return '/login';
  }
}
