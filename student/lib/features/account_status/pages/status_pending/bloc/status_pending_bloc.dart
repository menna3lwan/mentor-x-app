import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'dart:async';
import 'package:mentorx_student/core/core.dart';

part 'status_pending_event.dart';
part 'status_pending_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class StatusPendingPresentationEvent {
  const StatusPendingPresentationEvent();
}

final class StatusPendingFailurePresentationEvent
    extends StatusPendingPresentationEvent {
  final MentorXException exception;
  const StatusPendingFailurePresentationEvent({required this.exception});
}

final class StatusPendingStatusUpdatedPresentationEvent
    extends StatusPendingPresentationEvent {
  final StudentEntity user;

  const StatusPendingStatusUpdatedPresentationEvent({required this.user});
}

final class StatusPendingLoggedOutPresentationEvent
    extends StatusPendingPresentationEvent {
  const StatusPendingLoggedOutPresentationEvent();
}

// ──── Bloc ────
final class StatusPendingBloc
    extends Bloc<StatusPendingEvent, StatusPendingState>
    with
        BlocPresentationMixin<
          StatusPendingState,
          StatusPendingPresentationEvent
        > {
  final StudentAuthenticationRepository _authRepository;
  final CacheRepository _cacheRepository;
  final AnalyticsService _analyticsService;
  Timer? _pollingTimer;

  StatusPendingBloc({
    required StudentAuthenticationRepository authRepository,
    required CacheRepository cacheRepository,
    required AnalyticsService analyticsService,
  }) : _authRepository = authRepository,
       _cacheRepository = cacheRepository,
       _analyticsService = analyticsService,
       super(StatusPendingState.initial) {
    on<StatusPendingInitialized>(_onInitialized);
    on<StatusPendingRefreshRequested>(_onRefreshRequested);
    on<StatusPendingLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onInitialized(
    StatusPendingInitialized event,
    Emitter<StatusPendingState> emit,
  ) async {
    final cachedUser = await _authRepository.getCachedUser();
    final tenantWhatsApp = await _cacheRepository.get('tenant_whatsapp_number');

    emit(
      state.copyWith(
        loadingState: LoadingState.loaded,
        studentCode: cachedUser?.studentCode,
        tenantWhatsAppNumber: MentorXNullableValue(tenantWhatsApp),
      ),
    );

    _analyticsService.logEvent(
      name: AnalyticsEvents.accountStatusViewed,
      parameters: {AnalyticsParams.status: 'pending'},
    );

    add(const StatusPendingRefreshRequested());
    _startPolling();
  }

  Future<void> _onRefreshRequested(
    StatusPendingRefreshRequested event,
    Emitter<StatusPendingState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true));

    try {
      final user = await _authRepository.getAccountStatus();
      emit(
        state.copyWith(
          isRefreshing: false,
          studentCode: user.studentCode,
        ),
      );

      if (user.status != StudentStatus.pending) {
        emitPresentation(
          StatusPendingStatusUpdatedPresentationEvent(user: user),
        );
      }
    } on MentorXException catch (exception) {
      emit(state.copyWith(isRefreshing: false));
      emitPresentation(
        StatusPendingFailurePresentationEvent(exception: exception),
      );
    } catch (_) {
      emit(state.copyWith(isRefreshing: false));
    }
  }

  Future<void> _onLogoutRequested(
    StatusPendingLogoutRequested event,
    Emitter<StatusPendingState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true));
    try {
      await _authRepository.logout();
      emit(state.copyWith(isRefreshing: false));
      emitPresentation(const StatusPendingLoggedOutPresentationEvent());
    } on MentorXException catch (exception) {
      emit(state.copyWith(isRefreshing: false));
      emitPresentation(
        StatusPendingFailurePresentationEvent(exception: exception),
      );
    }
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!isClosed) {
        add(const StatusPendingRefreshRequested());
      }
    });
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
