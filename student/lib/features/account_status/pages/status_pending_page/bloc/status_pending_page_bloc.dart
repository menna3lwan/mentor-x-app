import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'dart:async';
import '../../../../../core/core.dart';

part 'status_pending_page_event.dart';
part 'status_pending_page_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class StatusPendingPagePresentationEvent {
  const StatusPendingPagePresentationEvent();
}

final class StatusPendingPageFailurePresentationEvent
    extends StatusPendingPagePresentationEvent {
  final MentorXException exception;
  const StatusPendingPageFailurePresentationEvent({required this.exception});
}

final class StatusPendingPageStatusUpdatedPresentationEvent
    extends StatusPendingPagePresentationEvent {
  final StudentEntity user;

  const StatusPendingPageStatusUpdatedPresentationEvent({required this.user});
}

final class StatusPendingPageLoggedOutPresentationEvent
    extends StatusPendingPagePresentationEvent {
  const StatusPendingPageLoggedOutPresentationEvent();
}

// ──── Bloc ────
final class StatusPendingPageBloc
    extends Bloc<StatusPendingPageEvent, StatusPendingPageState>
    with
        BlocPresentationMixin<
          StatusPendingPageState,
          StatusPendingPagePresentationEvent
        > {
  final StudentAuthenticationRepository _authRepository;
  final CacheRepository _cacheRepository;
  final AnalyticsService _analyticsService;
  Timer? _pollingTimer;

  StatusPendingPageBloc({
    required StudentAuthenticationRepository authRepository,
    required CacheRepository cacheRepository,
    required AnalyticsService analyticsService,
  }) : _authRepository = authRepository,
       _cacheRepository = cacheRepository,
       _analyticsService = analyticsService,
       super(StatusPendingPageState.initial) {
    on<StatusPendingPageInitialized>(_onInitialized);
    on<StatusPendingPageRefreshRequested>(_onRefreshRequested);
    on<StatusPendingPageLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onInitialized(
    StatusPendingPageInitialized event,
    Emitter<StatusPendingPageState> emit,
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

    add(const StatusPendingPageRefreshRequested());
    _startPolling();
  }

  Future<void> _onRefreshRequested(
    StatusPendingPageRefreshRequested event,
    Emitter<StatusPendingPageState> emit,
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
          StatusPendingPageStatusUpdatedPresentationEvent(user: user),
        );
      }
    } on MentorXException catch (exception) {
      emit(state.copyWith(isRefreshing: false));
      emitPresentation(
        StatusPendingPageFailurePresentationEvent(exception: exception),
      );
    } catch (_) {
      emit(state.copyWith(isRefreshing: false));
    }
  }

  Future<void> _onLogoutRequested(
    StatusPendingPageLogoutRequested event,
    Emitter<StatusPendingPageState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true));
    try {
      await _authRepository.logout();
      emit(state.copyWith(isRefreshing: false));
      emitPresentation(const StatusPendingPageLoggedOutPresentationEvent());
    } on MentorXException catch (exception) {
      emit(state.copyWith(isRefreshing: false));
      emitPresentation(
        StatusPendingPageFailurePresentationEvent(exception: exception),
      );
    }
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!isClosed) {
        add(const StatusPendingPageRefreshRequested());
      }
    });
  }

  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }
}
