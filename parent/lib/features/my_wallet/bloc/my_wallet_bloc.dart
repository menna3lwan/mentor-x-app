import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/bloc_error_helpers.dart';

part 'my_wallet_event.dart';
part 'my_wallet_state.dart';

// ──── Presentation events ──────────────────────────────────────────────────

sealed class MyWalletPresentationEvent {
  const MyWalletPresentationEvent();
}

final class MyWalletFailurePresentationEvent extends MyWalletPresentationEvent {
  final String message;
  const MyWalletFailurePresentationEvent({required this.message});
}

final class MyWalletUnauthorizedPresentationEvent
    extends MyWalletPresentationEvent {
  const MyWalletUnauthorizedPresentationEvent();
}

// ──── Bloc ─────────────────────────────────────────────────────────────────

/// Drives the parent's own wallet screen (summary + transactions).
/// Two independent sections so a transactions-fetch failure does not blank
/// the balance card and vice versa.
final class MyWalletBloc extends Bloc<MyWalletEvent, MyWalletState>
    with BlocPresentationMixin<MyWalletState, MyWalletPresentationEvent> {
  final ParentFinancialRepository _repository;

  MyWalletBloc({required ParentFinancialRepository repository})
    : _repository = repository,
      super(MyWalletState.initial()) {
    on<MyWalletStarted>(_onStarted);
    on<MyWalletRefreshRequested>(
      _onRefreshRequested,
      transformer: droppable(),
    );
    on<MyWalletRetrySectionRequested>(_onRetrySection);
  }

  Future<void> _onStarted(
    MyWalletStarted event,
    Emitter<MyWalletState> emit,
  ) async {
    if (state.summary.isLoaded || state.summary.isLoading) return;
    await _loadAll(emit);
  }

  Future<void> _onRefreshRequested(
    MyWalletRefreshRequested event,
    Emitter<MyWalletState> emit,
  ) async {
    if (state.isRefreshing) return;
    emit(state.copyWith(isRefreshing: true));
    try {
      await _loadAll(emit);
    } finally {
      if (!emit.isDone) emit(state.copyWith(isRefreshing: false));
    }
  }

  Future<void> _onRetrySection(
    MyWalletRetrySectionRequested event,
    Emitter<MyWalletState> emit,
  ) async {
    switch (event.section) {
      case MyWalletSection.summary:
        emit(state.copyWith(summary: state.summary.toLoading()));
        await _loadSummary(emit);
      case MyWalletSection.transactions:
        emit(state.copyWith(transactions: state.transactions.toLoading()));
        await _loadTransactions(emit);
    }
  }

  Future<void> _loadAll(Emitter<MyWalletState> emit) async {
    emit(
      state.copyWith(
        summary: state.summary.toLoading(),
        transactions: state.transactions.toLoading(),
      ),
    );
    await Future.wait([_loadSummary(emit), _loadTransactions(emit)]);
  }

  Future<void> _loadSummary(Emitter<MyWalletState> emit) async {
    try {
      final data = await _repository.getMyWallet();
      if (emit.isDone) return;
      emit(state.copyWith(summary: MyWalletAsyncSection.loaded(data)));
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          summary: MyWalletAsyncSection.failure(e.describeError()),
        ),
      );
      _maybeAuth(e);
      emitPresentation(
        MyWalletFailurePresentationEvent(message: e.describeError()),
      );
    }
  }

  Future<void> _loadTransactions(Emitter<MyWalletState> emit) async {
    try {
      final data = await _repository.getMyTransactions();
      if (emit.isDone) return;
      emit(state.copyWith(transactions: MyWalletAsyncSection.loaded(data)));
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          transactions: MyWalletAsyncSection.failure(e.describeError()),
        ),
      );
      _maybeAuth(e);
    }
  }

  void _maybeAuth(Object error) {
    if (isUnauthorizedError(error)) {
      emitPresentation(const MyWalletUnauthorizedPresentationEvent());
    }
  }
}
