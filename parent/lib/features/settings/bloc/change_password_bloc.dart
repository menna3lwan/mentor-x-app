import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/bloc_error_helpers.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

// ──── Presentation events ──────────────────────────────────────────────────

sealed class ChangePasswordPresentationEvent {
  const ChangePasswordPresentationEvent();
}

final class ChangePasswordSucceededPresentationEvent
    extends ChangePasswordPresentationEvent {
  const ChangePasswordSucceededPresentationEvent();
}

final class ChangePasswordFailedPresentationEvent
    extends ChangePasswordPresentationEvent {
  final ChangePasswordFailureKind kind;
  const ChangePasswordFailedPresentationEvent({required this.kind});
}

final class ChangePasswordUnauthorizedPresentationEvent
    extends ChangePasswordPresentationEvent {
  const ChangePasswordUnauthorizedPresentationEvent();
}

enum ChangePasswordFailureKind {
  unknown,
  wrongCurrentPassword,
  passwordTooWeak,
  passwordsMismatch,
  network,
  unauthorized,
}

// ──── Bloc ─────────────────────────────────────────────────────────────────

/// Drives the change-password screen. Manages three form fields, runs the
/// validation locally, and surfaces backend results as presentation events.
///
/// Concurrency: submit is droppable so a double-tap cannot send the request
/// twice.
final class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState>
    with
        BlocPresentationMixin<
          ChangePasswordState,
          ChangePasswordPresentationEvent
        > {
  final ParentProfileRepository _profileRepository;
  static final MentorXLogger _logger = MentorXLogger('ChangePasswordBloc');

  static const int _minPasswordLength = 8;

  ChangePasswordBloc({required ParentProfileRepository profileRepository})
    : _profileRepository = profileRepository,
      super(ChangePasswordState.initial()) {
    on<ChangePasswordCurrentChanged>(_onCurrentChanged);
    on<ChangePasswordNewChanged>(_onNewChanged);
    on<ChangePasswordConfirmChanged>(_onConfirmChanged);
    on<ChangePasswordSubmitted>(_onSubmitted, transformer: droppable());
  }

  void _onCurrentChanged(
    ChangePasswordCurrentChanged event,
    Emitter<ChangePasswordState> emit,
  ) {
    emit(state.copyWith(currentPassword: event.value));
  }

  void _onNewChanged(
    ChangePasswordNewChanged event,
    Emitter<ChangePasswordState> emit,
  ) {
    emit(state.copyWith(newPassword: event.value));
  }

  void _onConfirmChanged(
    ChangePasswordConfirmChanged event,
    Emitter<ChangePasswordState> emit,
  ) {
    emit(state.copyWith(confirmPassword: event.value));
  }

  Future<void> _onSubmitted(
    ChangePasswordSubmitted event,
    Emitter<ChangePasswordState> emit,
  ) async {
    final current = state.currentPassword;
    final next = state.newPassword;
    final confirm = state.confirmPassword;

    if (current.isEmpty) {
      emitPresentation(
        const ChangePasswordFailedPresentationEvent(
          kind: ChangePasswordFailureKind.wrongCurrentPassword,
        ),
      );
      return;
    }
    if (next.length < _minPasswordLength) {
      emitPresentation(
        const ChangePasswordFailedPresentationEvent(
          kind: ChangePasswordFailureKind.passwordTooWeak,
        ),
      );
      return;
    }
    if (next != confirm) {
      emitPresentation(
        const ChangePasswordFailedPresentationEvent(
          kind: ChangePasswordFailureKind.passwordsMismatch,
        ),
      );
      return;
    }

    emit(state.copyWith(status: ChangePasswordStatus.submitting));
    try {
      await _profileRepository.changePassword(
        currentPassword: current,
        newPassword: next,
      );
      emit(state.copyWith(status: ChangePasswordStatus.success));
      emitPresentation(const ChangePasswordSucceededPresentationEvent());
    } catch (e, s) {
      _logger.error('Change password failed: $e', e, s);
      emit(state.copyWith(status: ChangePasswordStatus.failure));
      if (isUnauthorizedError(e)) {
        emitPresentation(
          const ChangePasswordUnauthorizedPresentationEvent(),
        );
        return;
      }
      emitPresentation(
        ChangePasswordFailedPresentationEvent(kind: _classify(e)),
      );
    }
  }

  ChangePasswordFailureKind _classify(Object error) {
    if (error is ParentProfileRepositoryException) {
      return switch (error.code) {
        ParentProfileRepositoryExceptionCode.wrongCurrentPassword =>
          ChangePasswordFailureKind.wrongCurrentPassword,
        ParentProfileRepositoryExceptionCode.invalidPassword =>
          ChangePasswordFailureKind.passwordTooWeak,
        ParentProfileRepositoryExceptionCode.networkError =>
          ChangePasswordFailureKind.network,
        ParentProfileRepositoryExceptionCode.unauthorized =>
          ChangePasswordFailureKind.unauthorized,
        _ => ChangePasswordFailureKind.unknown,
      };
    }
    return switch (classifyHttpFailure(error)) {
      GenericFailureKind.unauthorized =>
        ChangePasswordFailureKind.unauthorized,
      GenericFailureKind.network => ChangePasswordFailureKind.network,
      _ => ChangePasswordFailureKind.unknown,
    };
  }
}
