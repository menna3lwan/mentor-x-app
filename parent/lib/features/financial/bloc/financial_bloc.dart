import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'financial_event.dart';
part 'financial_state.dart';

sealed class FinancialPresentationEvent {
  const FinancialPresentationEvent();
}

final class FinancialFailurePresentationEvent
    extends FinancialPresentationEvent {
  final String message;
  const FinancialFailurePresentationEvent({required this.message});
}

/// Drives the parent financial-monitor screen. Loads four independent
/// sections so a partial backend failure doesn't blank the page.
final class FinancialBloc extends Bloc<FinancialEvent, FinancialState>
    with BlocPresentationMixin<FinancialState, FinancialPresentationEvent> {
  final ParentFinancialRepository _repository;

  FinancialBloc({required ParentFinancialRepository repository})
      : _repository = repository,
        super(FinancialState.initial()) {
    on<FinancialStarted>(_onStarted);
    on<FinancialRefreshRequested>(_onRefreshRequested);
    on<FinancialRetrySectionRequested>(_onRetrySection);
  }

  Future<void> _onStarted(
    FinancialStarted event,
    Emitter<FinancialState> emit,
  ) async {
    final childId = event.childId;
    if (childId == null || childId.isEmpty) {
      emit(state.copyWith(
        transactionsSection: const FinancialAsyncSection.failure(
          'Child ID is required',
        ),
      ));
      return;
    }
    if (state.childId == childId &&
        (state.transactionsSection.isLoaded ||
            state.transactionsSection.isLoading)) {
      return;
    }
    emit(state.copyWith(childId: childId));
    await _loadAll(emit, childId);
  }

  Future<void> _onRefreshRequested(
    FinancialRefreshRequested event,
    Emitter<FinancialState> emit,
  ) async {
    final childId = event.childId;
    if (childId == null || childId.isEmpty) return;
    emit(state.copyWith(isRefreshing: true, childId: childId));
    await _loadAll(emit, childId);
    emit(state.copyWith(isRefreshing: false));
  }

  Future<void> _onRetrySection(
    FinancialRetrySectionRequested event,
    Emitter<FinancialState> emit,
  ) async {
    final childId = state.childId;
    if (childId == null) return;

    switch (event.section) {
      case FinancialSection.transactions:
        emit(state.copyWith(
          transactionsSection: state.transactionsSection.toLoading(),
        ));
        await _loadTransactions(emit, childId);
      case FinancialSection.summary:
        emit(state.copyWith(summarySection: state.summarySection.toLoading()));
        await _loadSummary(emit, childId);
      case FinancialSection.payments:
        emit(state.copyWith(
          paymentsSection: state.paymentsSection.toLoading(),
        ));
        await _loadPayments(emit, childId);
      case FinancialSection.analytics:
        emit(state.copyWith(
          analyticsSection: state.analyticsSection.toLoading(),
        ));
        await _loadAnalytics(emit, childId);
    }
  }

  Future<void> _loadAll(Emitter<FinancialState> emit, String childId) async {
    emit(state.copyWith(
      transactionsSection: state.transactionsSection.toLoading(),
      summarySection: state.summarySection.toLoading(),
      paymentsSection: state.paymentsSection.toLoading(),
      analyticsSection: state.analyticsSection.toLoading(),
    ));

    await Future.wait([
      _loadTransactions(emit, childId),
      _loadSummary(emit, childId),
      _loadPayments(emit, childId),
      _loadAnalytics(emit, childId),
    ]);
  }

  Future<void> _loadTransactions(
    Emitter<FinancialState> emit,
    String childId,
  ) async {
    try {
      final txs = await _repository.getTransactions(childId);
      emit(state.copyWith(
        transactionsSection: FinancialAsyncSection.loaded(txs),
      ));
    } catch (e) {
      emit(state.copyWith(
        transactionsSection: FinancialAsyncSection.failure(e.toString()),
      ));
      emitPresentation(
        FinancialFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _loadSummary(
    Emitter<FinancialState> emit,
    String childId,
  ) async {
    try {
      final summary = await _repository.getWalletSummary(childId);
      emit(state.copyWith(
        summarySection: FinancialAsyncSection.loaded(summary),
      ));
    } catch (e) {
      emit(state.copyWith(
        summarySection: FinancialAsyncSection.failure(e.toString()),
      ));
      emitPresentation(
        FinancialFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _loadPayments(
    Emitter<FinancialState> emit,
    String childId,
  ) async {
    try {
      final payments = await _repository.getPayments(childId);
      emit(state.copyWith(
        paymentsSection: FinancialAsyncSection.loaded(payments),
      ));
    } catch (e) {
      emit(state.copyWith(
        paymentsSection: FinancialAsyncSection.failure(e.toString()),
      ));
      // Payments are non-blocking; don't toast for them.
    }
  }

  Future<void> _loadAnalytics(
    Emitter<FinancialState> emit,
    String childId,
  ) async {
    try {
      final analytics = await _repository.getWalletAnalytics(childId);
      emit(state.copyWith(
        analyticsSection: FinancialAsyncSection.loaded(analytics),
      ));
    } catch (e) {
      emit(state.copyWith(
        analyticsSection: FinancialAsyncSection.failure(e.toString()),
      ));
      // Analytics are non-blocking; don't toast for them.
    }
  }
}
