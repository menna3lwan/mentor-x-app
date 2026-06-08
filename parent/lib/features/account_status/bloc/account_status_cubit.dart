import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/blocs/bloc_error_helpers.dart';

part 'account_status_state.dart';

// ──── Presentation events ────────────────────────────────────────────────────

sealed class AccountStatusPresentationEvent {
  const AccountStatusPresentationEvent();
}

/// Fired the first time we observe the account transition from `pending` to
/// `active`. The shell uses this to surface a snackbar and to navigate the
/// user out of the gated `PendingAccountPage`.
final class AccountStatusApprovedPresentationEvent
    extends AccountStatusPresentationEvent {
  const AccountStatusApprovedPresentationEvent();
}

/// Fired when the status load fails. The page renders an inline error
/// banner; we additionally emit this so the wrapper can show a toast.
final class AccountStatusLoadFailedPresentationEvent
    extends AccountStatusPresentationEvent {
  final String message;
  const AccountStatusLoadFailedPresentationEvent({required this.message});
}

/// Fired when the repository reports an authentication failure (typically a
/// 401). The shell listens and triggers a logout.
final class AccountStatusUnauthorizedPresentationEvent
    extends AccountStatusPresentationEvent {
  const AccountStatusUnauthorizedPresentationEvent();
}

// ──── Cubit ─────────────────────────────────────────────────────────────────

/// Drives the `PendingAccountPage`.
///
/// Responsibilities:
/// - Fetch the latest [ParentAccountStatusEntity] from the repository.
/// - Poll on a low-frequency schedule while the page is mounted so the user
///   sees an automatic transition when the back-office approves them.
/// - Allow an explicit manual refresh (pull-to-refresh / button tap).
/// - Detect the `pending` → `active` transition and notify the shell via a
///   presentation event so it can pull the freshly-approved profile and
///   navigate away.
///
/// The polling cadence is deliberately conservative ([_pollInterval]) so we
/// don't hammer the backend; the user can still tap **Refresh** to force a
/// check immediately.
final class AccountStatusCubit extends Cubit<AccountStatusState>
    with
        BlocPresentationMixin<AccountStatusState,
            AccountStatusPresentationEvent> {
  final ParentAccountStatusRepository _repository;
  final AppAuthenticationCubit _appAuthCubit;
  Timer? _pollTimer;

  /// Polling cadence while the wrapper is mounted. Tuned high enough that an
  /// idle device doesn't generate excessive traffic, low enough that a user
  /// who just submitted is unlikely to wait long after admin approval.
  static const Duration _pollInterval = Duration(seconds: 30);

  AccountStatusCubit({
    required ParentAccountStatusRepository repository,
    required AppAuthenticationCubit appAuthCubit,
  })  : _repository = repository,
        _appAuthCubit = appAuthCubit,
        super(AccountStatusState.initial());

  /// Called by the wrapper on first build. Performs an immediate load and
  /// starts the polling loop.
  Future<void> start() async {
    if (state.status.isLoaded || state.status.isLoading) return;
    emit(state.copyWith(status: AccountStatusViewStatus.loading));
    await _load(isManual: false);
    _startPolling();
  }

  /// Manual refresh – e.g. pull-to-refresh or "Check again" button.
  Future<void> refresh() async {
    if (state.isRefreshing) return;
    emit(state.copyWith(isRefreshing: true));
    try {
      await _load(isManual: true);
    } finally {
      if (!isClosed) {
        emit(state.copyWith(isRefreshing: false));
      }
    }
  }

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(_pollInterval, (_) {
      if (isClosed) return;
      // Skip if a request is already in flight to avoid pile-up under slow
      // network conditions.
      if (state.isRefreshing) return;
      unawaited(_load(isManual: false));
    });
  }

  Future<void> _load({required bool isManual}) async {
    try {
      final entity = await _repository.getStatus();
      if (isClosed) return;

      final previousStatus = state.entity.status;
      emit(
        state.copyWith(
          status: AccountStatusViewStatus.loaded,
          entity: entity,
          errorMessage: null,
        ),
      );

      // Detect pending → active transition. We trust the repository's
      // returned entity over the cached one.
      final justActivated =
          previousStatus == ParentStatus.pending && entity.isActive;

      if (justActivated) {
        await _promoteToActiveUser();
        emitPresentation(const AccountStatusApprovedPresentationEvent());
      }
    } catch (e) {
      if (isClosed) return;
      final message = e.describeError();
      emit(
        state.copyWith(
          status: state.entity.status == ParentStatus.pending &&
                  state.status.isLoaded
              // Keep showing the last-known pending view; surface the error
              // as a transient banner instead of replacing the entire page.
              ? AccountStatusViewStatus.loaded
              : AccountStatusViewStatus.failure,
          errorMessage: message,
        ),
      );
      if (isUnauthorizedError(e)) {
        emitPresentation(const AccountStatusUnauthorizedPresentationEvent());
      } else if (isManual) {
        emitPresentation(
          AccountStatusLoadFailedPresentationEvent(message: message),
        );
      }
    }
  }

  /// When the repository reports the account has been approved, ask it for
  /// the up-to-date [ParentEntity] and push it into the global auth cubit so
  /// the rest of the app (router, home, profile, etc.) reflects the change.
  Future<void> _promoteToActiveUser() async {
    try {
      final refreshed = await _repository.refreshAuthenticatedUser();
      if (isClosed) return;
      if (refreshed != null) {
        _appAuthCubit.update(refreshed);
      }
    } catch (_) {
      // Failing to refresh the user is non-fatal: the presentation event
      // still fires and the router will retry via its own auth refresh on
      // the next navigation.
    }
  }

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    _pollTimer = null;
    return super.close();
  }
}
