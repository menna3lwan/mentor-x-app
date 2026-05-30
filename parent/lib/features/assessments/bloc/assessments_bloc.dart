import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'assessments_event.dart';
part 'assessments_state.dart';

sealed class AssessmentsPresentationEvent {
  const AssessmentsPresentationEvent();
}

/// Classifies failures so the UI can show contextual copy.
enum AssessmentsFailureKind {
  unknown,
  network,
  notFound,
  unauthorized,
}

final class AssessmentsFailurePresentationEvent
    extends AssessmentsPresentationEvent {
  final AssessmentsFailureKind kind;
  final String? rawMessage;
  const AssessmentsFailurePresentationEvent({
    required this.kind,
    this.rawMessage,
  });
}

/// Fired on auth failures so the wrapper can redirect to login.
final class AssessmentsUnauthorizedPresentationEvent
    extends AssessmentsPresentationEvent {
  const AssessmentsUnauthorizedPresentationEvent();
}

/// Drives the parent grade-monitor screen. Loads three independent sections
/// (assessment history, overall summary, monthly trend) so a partial failure
/// doesn't blank the whole page.
final class AssessmentsBloc extends Bloc<AssessmentsEvent, AssessmentsState>
    with BlocPresentationMixin<AssessmentsState, AssessmentsPresentationEvent> {
  final ParentGradeRepository _repository;

  AssessmentsBloc({required ParentGradeRepository repository})
    : _repository = repository,
      super(AssessmentsState.initial()) {
    on<AssessmentsStarted>(_onStarted);
    // Drop rapid refresh taps — only one full reload at a time.
    on<AssessmentsRefreshRequested>(
      _onRefreshRequested,
      transformer: droppable(),
    );
    on<AssessmentsRetrySectionRequested>(_onRetrySection);
  }

  Future<void> _onStarted(
    AssessmentsStarted event,
    Emitter<AssessmentsState> emit,
  ) async {
    if (state.childId == event.childId &&
        (state.assessmentsSection.isLoaded ||
            state.assessmentsSection.isLoading)) {
      return;
    }
    emit(state.copyWith(childId: event.childId));
    await _loadAll(emit, event.childId);
  }

  Future<void> _onRefreshRequested(
    AssessmentsRefreshRequested event,
    Emitter<AssessmentsState> emit,
  ) async {
    if (state.isRefreshing) return;
    emit(state.copyWith(isRefreshing: true, childId: event.childId));
    try {
      await _loadAll(emit, event.childId);
    } finally {
      if (!emit.isDone) {
        emit(state.copyWith(isRefreshing: false));
      }
    }
  }

  Future<void> _onRetrySection(
    AssessmentsRetrySectionRequested event,
    Emitter<AssessmentsState> emit,
  ) async {
    final childId = state.childId;
    if (childId == null) return;

    switch (event.section) {
      case AssessmentsSection.history:
        emit(
          state.copyWith(
            assessmentsSection: state.assessmentsSection.toLoading(),
          ),
        );
        await _loadHistory(emit, childId);
      case AssessmentsSection.summary:
        emit(
          state.copyWith(
            summarySection: state.summarySection.toLoading(),
          ),
        );
        await _loadSummary(emit, childId);
      case AssessmentsSection.trend:
        emit(state.copyWith(trendSection: state.trendSection.toLoading()));
        await _loadTrend(emit, childId);
    }
  }

  Future<void> _loadAll(Emitter<AssessmentsState> emit, String childId) async {
    emit(
      state.copyWith(
        assessmentsSection: state.assessmentsSection.toLoading(),
        summarySection: state.summarySection.toLoading(),
        trendSection: state.trendSection.toLoading(),
      ),
    );

    await Future.wait([
      _loadHistory(emit, childId),
      _loadSummary(emit, childId),
      _loadTrend(emit, childId),
    ]);
  }

  Future<void> _loadHistory(
    Emitter<AssessmentsState> emit,
    String childId,
  ) async {
    try {
      final list = await _repository.getAssessments(childId);
      if (emit.isDone) return;
      emit(
        state.copyWith(
          assessmentsSection: AssessmentsAsyncSection.loaded(list),
        ),
      );
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          assessmentsSection: AssessmentsAsyncSection.failure(_describe(e)),
        ),
      );
      _emitFailure(e);
    }
  }

  Future<void> _loadSummary(
    Emitter<AssessmentsState> emit,
    String childId,
  ) async {
    try {
      final summary = await _repository.getGradeSummary(childId);
      if (emit.isDone) return;
      emit(
        state.copyWith(
          summarySection: AssessmentsAsyncSection.loaded(summary),
        ),
      );
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          summarySection: AssessmentsAsyncSection.failure(_describe(e)),
        ),
      );
      // Summary failure is non-critical — don't toast.
      _maybeEmitUnauthorized(e);
    }
  }

  Future<void> _loadTrend(
    Emitter<AssessmentsState> emit,
    String childId,
  ) async {
    try {
      final trend = await _repository.getGradeTrend(childId);
      if (emit.isDone) return;
      emit(
        state.copyWith(
          trendSection: AssessmentsAsyncSection.loaded(trend),
        ),
      );
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          trendSection: AssessmentsAsyncSection.failure(_describe(e)),
        ),
      );
      // Trend is non-critical — don't toast.
      _maybeEmitUnauthorized(e);
    }
  }

  // ───────────────────────────────────────────────────────────────────────
  // Helpers
  // ───────────────────────────────────────────────────────────────────────

  void _emitFailure(Object error) {
    _maybeEmitUnauthorized(error);
    emitPresentation(
      AssessmentsFailurePresentationEvent(
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

  AssessmentsFailureKind _classifyFailure(Object error) {
    if (error is HttpClientResponse) {
      return switch (error.statusCode) {
        401 || 403 => AssessmentsFailureKind.unauthorized,
        404 => AssessmentsFailureKind.notFound,
        _ => AssessmentsFailureKind.unknown,
      };
    }
    return AssessmentsFailureKind.unknown;
  }

  void _maybeEmitUnauthorized(Object error) {
    if (error is HttpClientResponse &&
        (error.statusCode == 401 || error.statusCode == 403)) {
      emitPresentation(const AssessmentsUnauthorizedPresentationEvent());
    }
  }
}
