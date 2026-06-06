import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/bloc_error_helpers.dart';

part 'top_up_event.dart';
part 'top_up_state.dart';

// ──── Presentation events ──────────────────────────────────────────────────

sealed class TopUpPresentationEvent {
  const TopUpPresentationEvent();
}

final class TopUpSucceededPresentationEvent extends TopUpPresentationEvent {
  final WalletSummaryEntity wallet;
  const TopUpSucceededPresentationEvent({required this.wallet});
}

final class TopUpFailedPresentationEvent extends TopUpPresentationEvent {
  final TopUpFailureKind kind;
  const TopUpFailedPresentationEvent({required this.kind});
}

final class TopUpUnauthorizedPresentationEvent extends TopUpPresentationEvent {
  const TopUpUnauthorizedPresentationEvent();
}

enum TopUpFailureKind {
  unknown,
  invalidAmount,
  belowMinimum,
  insufficientFunds,
  network,
}

// ──── Bloc ─────────────────────────────────────────────────────────────────

/// Drives the wallet top-up screen. Owns the working amount, runs local
/// validation, and submits via the financial repository. Optional
/// [studentId] makes the same bloc reusable for both parent-self and
/// child-targeted top-ups.
final class TopUpBloc extends Bloc<TopUpEvent, TopUpState>
    with BlocPresentationMixin<TopUpState, TopUpPresentationEvent> {
  final ParentFinancialRepository _repository;
  final String? _studentId;
  static final MentorXLogger _logger = MentorXLogger('TopUpBloc');

  static const double _minAmount = 10;

  TopUpBloc({
    required ParentFinancialRepository repository,
    String? studentId,
  }) : _repository = repository,
       _studentId = studentId,
       super(TopUpState.initial()) {
    on<TopUpAmountChanged>(_onAmountChanged);
    on<TopUpPresetSelected>(_onPresetSelected);
    on<TopUpSubmitted>(_onSubmitted, transformer: droppable());
  }

  void _onAmountChanged(
    TopUpAmountChanged event,
    Emitter<TopUpState> emit,
  ) {
    emit(state.copyWith(amountInput: event.value));
  }

  void _onPresetSelected(
    TopUpPresetSelected event,
    Emitter<TopUpState> emit,
  ) {
    emit(state.copyWith(amountInput: event.amount.toStringAsFixed(0)));
  }

  Future<void> _onSubmitted(
    TopUpSubmitted event,
    Emitter<TopUpState> emit,
  ) async {
    final amount = double.tryParse(state.amountInput.trim());
    if (amount == null || amount <= 0) {
      emitPresentation(
        const TopUpFailedPresentationEvent(
          kind: TopUpFailureKind.invalidAmount,
        ),
      );
      return;
    }
    if (amount < _minAmount) {
      emitPresentation(
        const TopUpFailedPresentationEvent(
          kind: TopUpFailureKind.belowMinimum,
        ),
      );
      return;
    }

    emit(state.copyWith(status: TopUpStatus.submitting));
    try {
      final wallet = await _repository.topUpWallet(
        amount: amount,
        studentId: _studentId,
      );
      emit(state.copyWith(status: TopUpStatus.success));
      emitPresentation(TopUpSucceededPresentationEvent(wallet: wallet));
    } catch (e, s) {
      _logger.error('Top-up failed: $e', e, s);
      emit(state.copyWith(status: TopUpStatus.failure));
      if (isUnauthorizedError(e)) {
        emitPresentation(const TopUpUnauthorizedPresentationEvent());
        return;
      }
      emitPresentation(TopUpFailedPresentationEvent(kind: _classify(e)));
    }
  }

  TopUpFailureKind _classify(Object error) {
    if (error is ParentFinancialRepositoryException) {
      return switch (error.code) {
        ParentFinancialRepositoryExceptionCode.invalidAmount =>
          TopUpFailureKind.invalidAmount,
        ParentFinancialRepositoryExceptionCode.insufficientFunds =>
          TopUpFailureKind.insufficientFunds,
        _ => TopUpFailureKind.unknown,
      };
    }
    return switch (classifyHttpFailure(error)) {
      GenericFailureKind.network => TopUpFailureKind.network,
      _ => TopUpFailureKind.unknown,
    };
  }
}
