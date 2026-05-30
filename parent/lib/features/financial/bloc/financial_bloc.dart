import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'financial_event.dart';
part 'financial_state.dart';

sealed class FinancialPresentationEvent {
  const FinancialPresentationEvent();
}

/// Classifies financial failures so the UI can show contextual copy.
enum FinancialFailureKind {
  unknown,
  network,
  notFound,
  unauthorized,
  invalidChild,
}

final class FinancialFailurePresentationEvent
    extends FinancialPresentationEvent {
  final FinancialFailureKind kind;
  final String? rawMessage;
  const FinancialFailurePresentationEvent({
    required this.kind,
    this.rawMessage,
  });
}

final class FinancialUnauthorizedPresentationEvent
    extends FinancialPresentationEvent {
  const FinancialUnauthorizedPresentationEvent();
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
    on<FinancialRefreshRequested>(
      _onRefreshRequested,
      transformer: droppable(),
    );
    on<FinancialRetrySectionRequested>(_onRetrySection);
  }

  Future<void> _onStarted(
    FinancialStarted event,
    Emitter<FinancialState> emit,
  ) async {
    final childId = event.childId;
    if (childId == null || childId.isEmpty) {
      emit(state.copyWith(
        transactionsSection: const FinancialAsyncSection.failure(''),
      ));
      emitPresentation(
        const FinancialFailurePresentationEvent(
          kind: FinancialFailureKind.invalidChild,
        ),
      );
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
    if (state.isRefreshing) return;
    emit(state.copyWith(isRefreshing: true, childId: childId));
    try {
      await _loadAll(emit, childId);
    } finally {
      if (!emit.isDone) {
        emit(state.copyWith(isRefreshing: false));
      }
    }
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
      if (emit.isDone) return;
      emit(state.copyWith(
        transactionsSection: FinancialAsyncSection.loaded(txs),
      ));
    } catch (e) {
      if (emit.isDone) return;
      emit(state.copyWith(
        transactionsSection: FinancialAsyncSection.failure(_describe(e)),
      ));
      _emitFailure(e);
    }
  }

  Future<void> _loadSummary(
    Emitter<FinancialState> emit,
    String childId,
  ) async {
    try {
      final summary = await _repository.getWalletSummary(childId);
      if (emit.isDone) return;
      emit(state.copyWith(
        summarySection: FinancialAsyncSection.loaded(summary),
      ));
    } catch (e) {
      if (emit.isDone) return;
      emit(state.copyWith(
        summarySection: FinancialAsyncSection.failure(_describe(e)),
      ));
      _emitFailure(e);
    }
  }

  Future<void> _loadPayments(
    Emitter<FinancialState> emit,
    String childId,
  ) async {
    try {
      final payments = await _repository.getPayments(childId);
      if (emit.isDone) return;
      emit(state.copyWith(
        paymentsSection: FinancialAsyncSection.loaded(payments),
      ));
    } catch (e) {
      if (emit.isDone) return;
      emit(state.copyWith(
        paymentsSection: FinancialAsyncSection.failure(_describe(e)),
      ));
      // Payments are non-blocking; don't toast — but still trip auth.
      _maybeEmitUnauthorized(e);
    }
  }

  Future<void> _loadAnalytics(
    Emitter<FinancialState> emit,
    String childId,
  ) async {
    try {
      final analytics = await _repository.getWalletAnalytics(childId);
      if (emit.isDone) return;
      emit(state.copyWith(
        analyticsSection: FinancialAsyncSection.loaded(analytics),
      ));
    } catch (e) {
      if (emit.isDone) return;
      emit(state.copyWith(
        analyticsSection: FinancialAsyncSection.failure(_describe(e)),
      ));
      // Analytics are non-blocking; don't toast — but still trip auth.
      _maybeEmitUnauthorized(e);
    }
  }

  // ───────────────────────────────────────────────────────────────────────
  // Helpers
  // ───────────────────────────────────────────────────────────────────────

  void _emitFailure(Object error) {
    _maybeEmitUnauthorized(error);
    emitPresentation(
      FinancialFailurePresentationEvent(
        kind: _classifyFailure(error),
        rawMessage: _describe(error),
      ),
    );
  }

  String _describe(Object error) {
    if (error is MentorXException) {
      return error.message ?? error.toString();
    }
    if (error is HttpClientResponse) {
      return 'Request failed (${error.statusCode})';
    }
    return error.toString();
  }

  FinancialFailureKind _classifyFailure(Object error) {
    if (error is HttpClientResponse) {
      return switch (error.statusCode) {
        401 || 403 => FinancialFailureKind.unauthorized,
        404 => FinancialFailureKind.notFound,
        _ => FinancialFailureKind.unknown,
      };
    }
    return FinancialFailureKind.unknown;
  }

  void _maybeEmitUnauthorized(Object error) {
    if (error is HttpClientResponse &&
        (error.statusCode == 401 || error.statusCode == 403)) {
      emitPresentation(const FinancialUnauthorizedPresentationEvent());
    }
  }
}
