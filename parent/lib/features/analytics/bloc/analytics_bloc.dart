import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/bloc_error_helpers.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

// ──── Presentation events ──────────────────────────────────────────────────

sealed class AnalyticsPresentationEvent {
  const AnalyticsPresentationEvent();
}

final class AnalyticsFailurePresentationEvent
    extends AnalyticsPresentationEvent {
  final String message;
  const AnalyticsFailurePresentationEvent({required this.message});
}

final class AnalyticsUnauthorizedPresentationEvent
    extends AnalyticsPresentationEvent {
  const AnalyticsUnauthorizedPresentationEvent();
}

// ──── Bloc ─────────────────────────────────────────────────────────────────

/// Drives the parent analytics screen. Six independent sections (grade
/// comparison / course progress / active hours / achievements / streak /
/// quiz speed) load in parallel, each with its own retry path so a single
/// 5xx never blanks the whole screen.
final class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState>
    with BlocPresentationMixin<AnalyticsState, AnalyticsPresentationEvent> {
  final ParentAnalyticsRepository _repository;

  AnalyticsBloc({required ParentAnalyticsRepository repository})
    : _repository = repository,
      super(AnalyticsState.initial()) {
    on<AnalyticsStarted>(_onStarted);
    on<AnalyticsRefreshRequested>(
      _onRefreshRequested,
      transformer: droppable(),
    );
    on<AnalyticsRetrySectionRequested>(_onRetrySection);
  }

  Future<void> _onStarted(
    AnalyticsStarted event,
    Emitter<AnalyticsState> emit,
  ) async {
    if (state.childId == event.childId &&
        (state.gradeComparison.isLoaded || state.gradeComparison.isLoading)) {
      return;
    }
    emit(state.copyWith(childId: event.childId));
    await _loadAll(emit, event.childId);
  }

  Future<void> _onRefreshRequested(
    AnalyticsRefreshRequested event,
    Emitter<AnalyticsState> emit,
  ) async {
    if (state.isRefreshing) return;
    emit(state.copyWith(isRefreshing: true, childId: event.childId));
    try {
      await _loadAll(emit, event.childId);
    } finally {
      if (!emit.isDone) emit(state.copyWith(isRefreshing: false));
    }
  }

  Future<void> _onRetrySection(
    AnalyticsRetrySectionRequested event,
    Emitter<AnalyticsState> emit,
  ) async {
    final childId = state.childId;
    if (childId == null) return;
    switch (event.section) {
      case AnalyticsSection.gradeComparison:
        emit(
          state.copyWith(gradeComparison: state.gradeComparison.toLoading()),
        );
        await _loadGradeComparison(emit, childId);
      case AnalyticsSection.courseProgress:
        emit(state.copyWith(courseProgress: state.courseProgress.toLoading()));
        await _loadCourseProgress(emit, childId);
      case AnalyticsSection.activeHours:
        emit(state.copyWith(activeHours: state.activeHours.toLoading()));
        await _loadActiveHours(emit, childId);
      case AnalyticsSection.achievements:
        emit(state.copyWith(achievements: state.achievements.toLoading()));
        await _loadAchievements(emit, childId);
      case AnalyticsSection.streak:
        emit(state.copyWith(streak: state.streak.toLoading()));
        await _loadStreak(emit, childId);
      case AnalyticsSection.quizSpeed:
        emit(state.copyWith(quizSpeed: state.quizSpeed.toLoading()));
        await _loadQuizSpeed(emit, childId);
    }
  }

  Future<void> _loadAll(Emitter<AnalyticsState> emit, String childId) async {
    emit(
      state.copyWith(
        gradeComparison: state.gradeComparison.toLoading(),
        courseProgress: state.courseProgress.toLoading(),
        activeHours: state.activeHours.toLoading(),
        achievements: state.achievements.toLoading(),
        streak: state.streak.toLoading(),
        quizSpeed: state.quizSpeed.toLoading(),
      ),
    );
    await Future.wait([
      _loadGradeComparison(emit, childId),
      _loadCourseProgress(emit, childId),
      _loadActiveHours(emit, childId),
      _loadAchievements(emit, childId),
      _loadStreak(emit, childId),
      _loadQuizSpeed(emit, childId),
    ]);
  }

  Future<void> _loadGradeComparison(
    Emitter<AnalyticsState> emit,
    String childId,
  ) async {
    try {
      final data = await _repository.getGradeComparison(childId);
      if (emit.isDone) return;
      emit(
        state.copyWith(
          gradeComparison: AnalyticsAsyncSection.loaded(data),
        ),
      );
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          gradeComparison: AnalyticsAsyncSection.failure(e.describeError()),
        ),
      );
      _maybeAuth(e);
    }
  }

  Future<void> _loadCourseProgress(
    Emitter<AnalyticsState> emit,
    String childId,
  ) async {
    try {
      final data = await _repository.getCourseProgress(childId);
      if (emit.isDone) return;
      emit(
        state.copyWith(
          courseProgress: AnalyticsAsyncSection.loaded(data),
        ),
      );
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          courseProgress: AnalyticsAsyncSection.failure(e.describeError()),
        ),
      );
      _maybeAuth(e);
    }
  }

  Future<void> _loadActiveHours(
    Emitter<AnalyticsState> emit,
    String childId,
  ) async {
    try {
      final data = await _repository.getActiveHours(childId);
      if (emit.isDone) return;
      emit(
        state.copyWith(activeHours: AnalyticsAsyncSection.loaded(data)),
      );
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          activeHours: AnalyticsAsyncSection.failure(e.describeError()),
        ),
      );
      _maybeAuth(e);
    }
  }

  Future<void> _loadAchievements(
    Emitter<AnalyticsState> emit,
    String childId,
  ) async {
    try {
      final data = await _repository.getAchievements(childId);
      if (emit.isDone) return;
      emit(
        state.copyWith(achievements: AnalyticsAsyncSection.loaded(data)),
      );
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          achievements: AnalyticsAsyncSection.failure(e.describeError()),
        ),
      );
      _maybeAuth(e);
    }
  }

  Future<void> _loadStreak(
    Emitter<AnalyticsState> emit,
    String childId,
  ) async {
    try {
      final data = await _repository.getStreak(childId);
      if (emit.isDone) return;
      emit(state.copyWith(streak: AnalyticsAsyncSection.loaded(data)));
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          streak: AnalyticsAsyncSection.failure(e.describeError()),
        ),
      );
      _maybeAuth(e);
    }
  }

  Future<void> _loadQuizSpeed(
    Emitter<AnalyticsState> emit,
    String childId,
  ) async {
    try {
      final data = await _repository.getQuizSpeed(childId);
      if (emit.isDone) return;
      emit(state.copyWith(quizSpeed: AnalyticsAsyncSection.loaded(data)));
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          quizSpeed: AnalyticsAsyncSection.failure(e.describeError()),
        ),
      );
      _maybeAuth(e);
    }
  }

  void _maybeAuth(Object error) {
    if (isUnauthorizedError(error)) {
      emitPresentation(const AnalyticsUnauthorizedPresentationEvent());
    }
  }
}
