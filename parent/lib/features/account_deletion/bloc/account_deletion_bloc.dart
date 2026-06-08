import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/bloc_error_helpers.dart';

part 'account_deletion_event.dart';
part 'account_deletion_state.dart';

// ──── Presentation events ───────────────────────────────────────────────────

sealed class AccountDeletionPresentationEvent {
  const AccountDeletionPresentationEvent();
}

final class AccountDeletionSucceededPresentationEvent
    extends AccountDeletionPresentationEvent {
  const AccountDeletionSucceededPresentationEvent();
}

final class AccountDeletionFailedPresentationEvent
    extends AccountDeletionPresentationEvent {
  final AccountDeletionFailureKind kind;
  final String? message;
  const AccountDeletionFailedPresentationEvent({
    required this.kind,
    this.message,
  });
}

final class AccountDeletionUnauthorizedPresentationEvent
    extends AccountDeletionPresentationEvent {
  const AccountDeletionUnauthorizedPresentationEvent();
}

enum AccountDeletionFailureKind {
  validation,
  network,
  unauthorized,
  unknown,
}

// ──── Bloc ──────────────────────────────────────────────────────────────────

/// Drives the Account Deletion form.
///
/// State is intentionally local to the bloc — neither the reason nor the
/// confirmation phrase is persisted in cache, because:
/// 1. Both contain potentially sensitive copy.
/// 2. The flow is one-shot: after submission, the user is logged out and
///    the bloc is disposed.
///
/// The bloc enforces three guards before forwarding the request:
/// - `acknowledgedPermanent` must be `true`.
/// - The user must have typed the confirmation phrase exactly. The phrase
///   itself is provided by the page (so the UI can localise it) and stashed
///   in [AccountDeletionState.expectedPhrase] for the bloc to compare.
/// - Submit is debounced via `droppable()` so repeated taps don't fan out.
final class AccountDeletionBloc
    extends Bloc<AccountDeletionEvent, AccountDeletionState>
    with
        BlocPresentationMixin<
          AccountDeletionState,
          AccountDeletionPresentationEvent
        > {
  final ParentAccountDeletionRepository _repository;

  AccountDeletionBloc({
    required ParentAccountDeletionRepository repository,
    required String expectedPhrase,
  }) : _repository = repository,
       super(AccountDeletionState.initial(expectedPhrase: expectedPhrase)) {
    on<AccountDeletionReasonChanged>(_onReasonChanged);
    on<AccountDeletionConfirmationChanged>(_onConfirmationChanged);
    on<AccountDeletionAcknowledgementToggled>(_onAcknowledgementToggled);
    on<AccountDeletionDataExportToggled>(_onDataExportToggled);
    on<AccountDeletionSubmitted>(_onSubmitted, transformer: droppable());
  }

  void _onReasonChanged(
    AccountDeletionReasonChanged event,
    Emitter<AccountDeletionState> emit,
  ) {
    emit(state.copyWith(reason: event.reason));
  }

  void _onConfirmationChanged(
    AccountDeletionConfirmationChanged event,
    Emitter<AccountDeletionState> emit,
  ) {
    emit(state.copyWith(confirmationPhrase: event.value));
  }

  void _onAcknowledgementToggled(
    AccountDeletionAcknowledgementToggled event,
    Emitter<AccountDeletionState> emit,
  ) {
    emit(state.copyWith(acknowledgedPermanent: event.value));
  }

  void _onDataExportToggled(
    AccountDeletionDataExportToggled event,
    Emitter<AccountDeletionState> emit,
  ) {
    emit(state.copyWith(requestDataExport: event.value));
  }

  Future<void> _onSubmitted(
    AccountDeletionSubmitted event,
    Emitter<AccountDeletionState> emit,
  ) async {
    // Local guards first — surface as validation presentation events so the
    // user gets a localized message rather than relying on the backend.
    if (!state.acknowledgedPermanent) {
      emitPresentation(
        const AccountDeletionFailedPresentationEvent(
          kind: AccountDeletionFailureKind.validation,
        ),
      );
      return;
    }
    if (!state.isConfirmationPhraseValid) {
      emitPresentation(
        const AccountDeletionFailedPresentationEvent(
          kind: AccountDeletionFailureKind.validation,
        ),
      );
      return;
    }

    emit(state.copyWith(status: AccountDeletionStatus.submitting));
    try {
      await _repository.submitDeletion(
        ParentAccountDeletionRequest(
          reason: state.reason,
          confirmationPhrase: state.confirmationPhrase,
          acknowledgedPermanent: state.acknowledgedPermanent,
          requestDataExport: state.requestDataExport,
        ),
      );
      if (emit.isDone) return;
      emit(state.copyWith(status: AccountDeletionStatus.success));
      emitPresentation(const AccountDeletionSucceededPresentationEvent());
    } catch (e) {
      if (emit.isDone) return;
      emit(state.copyWith(status: AccountDeletionStatus.failure));
      if (isUnauthorizedError(e)) {
        emitPresentation(
          const AccountDeletionUnauthorizedPresentationEvent(),
        );
        return;
      }
      final kind = _classify(e);
      emitPresentation(
        AccountDeletionFailedPresentationEvent(
          kind: kind,
          message: e.describeError(),
        ),
      );
    }
  }

  AccountDeletionFailureKind _classify(Object error) {
    if (error is ParentAccountDeletionRepositoryException) {
      return switch (error.code) {
        ParentAccountDeletionRepositoryExceptionCode.validation =>
          AccountDeletionFailureKind.validation,
        ParentAccountDeletionRepositoryExceptionCode.unauthorized =>
          AccountDeletionFailureKind.unauthorized,
        ParentAccountDeletionRepositoryExceptionCode.networkError =>
          AccountDeletionFailureKind.network,
        ParentAccountDeletionRepositoryExceptionCode.submitError ||
        ParentAccountDeletionRepositoryExceptionCode.unknown =>
          AccountDeletionFailureKind.unknown,
      };
    }
    return AccountDeletionFailureKind.unknown;
  }
}
