import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/bloc_error_helpers.dart';

part 'courses_event.dart';
part 'courses_state.dart';

sealed class CoursesPresentationEvent {
  const CoursesPresentationEvent();
}

final class CoursesFailurePresentationEvent extends CoursesPresentationEvent {
  final String message;
  const CoursesFailurePresentationEvent({required this.message});
}

final class CoursesUnauthorizedPresentationEvent
    extends CoursesPresentationEvent {
  const CoursesUnauthorizedPresentationEvent();
}

/// Drives the parent academic-monitor screen.
final class CoursesBloc extends Bloc<CoursesEvent, CoursesState>
    with BlocPresentationMixin<CoursesState, CoursesPresentationEvent> {
  final ParentCourseRepository _courseRepository;
  final ParentGradeRepository _gradeRepository;

  CoursesBloc({
    required ParentCourseRepository courseRepository,
    required ParentGradeRepository gradeRepository,
  }) : _courseRepository = courseRepository,
       _gradeRepository = gradeRepository,
       super(CoursesState.initial()) {
    on<CoursesStarted>(_onStarted);
    on<CoursesRefreshRequested>(_onRefreshRequested);
    on<CoursesRetrySectionRequested>(_onRetrySection);
  }

  Future<void> _onStarted(
    CoursesStarted event,
    Emitter<CoursesState> emit,
  ) async {
    if (state.childId == event.childId &&
        (state.coursesSection.isLoaded || state.coursesSection.isLoading)) {
      return;
    }
    emit(state.copyWith(childId: event.childId));
    await _loadAll(emit, event.childId);
  }

  Future<void> _onRefreshRequested(
    CoursesRefreshRequested event,
    Emitter<CoursesState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true, childId: event.childId));
    try {
      await _loadAll(emit, event.childId);
    } finally {
      if (!emit.isDone) emit(state.copyWith(isRefreshing: false));
    }
  }

  Future<void> _onRetrySection(
    CoursesRetrySectionRequested event,
    Emitter<CoursesState> emit,
  ) async {
    final childId = state.childId;
    if (childId == null) return;

    switch (event.section) {
      case CoursesSection.courses:
        emit(state.copyWith(coursesSection: state.coursesSection.toLoading()));
        await _loadCourses(emit, childId);
      case CoursesSection.summary:
        emit(state.copyWith(summarySection: state.summarySection.toLoading()));
        await _loadSummary(emit, childId);
      case CoursesSection.trend:
        emit(state.copyWith(trendSection: state.trendSection.toLoading()));
        await _loadTrend(emit, childId);
    }
  }

  Future<void> _loadAll(Emitter<CoursesState> emit, String childId) async {
    emit(
      state.copyWith(
        coursesSection: state.coursesSection.toLoading(),
        summarySection: state.summarySection.toLoading(),
        trendSection: state.trendSection.toLoading(),
      ),
    );

    await Future.wait([
      _loadCourses(emit, childId),
      _loadSummary(emit, childId),
      _loadTrend(emit, childId),
    ]);
  }

  Future<void> _loadCourses(
    Emitter<CoursesState> emit,
    String childId,
  ) async {
    try {
      final courses = await _courseRepository.getCourses(childId);
      if (emit.isDone) return;
      emit(state.copyWith(coursesSection: CoursesAsyncSection.loaded(courses)));
    } catch (e) {
      if (emit.isDone) return;
      final message = e.describeError();
      emit(state.copyWith(coursesSection: CoursesAsyncSection.failure(message)));
      _maybeEmitUnauthorized(e);
      emitPresentation(CoursesFailurePresentationEvent(message: message));
    }
  }

  Future<void> _loadSummary(
    Emitter<CoursesState> emit,
    String childId,
  ) async {
    try {
      final summary = await _gradeRepository.getGradeSummary(childId);
      if (emit.isDone) return;
      emit(state.copyWith(summarySection: CoursesAsyncSection.loaded(summary)));
    } catch (e) {
      if (emit.isDone) return;
      emit(state.copyWith(summarySection: CoursesAsyncSection.failure(e.describeError())));
      _maybeEmitUnauthorized(e);
      // Grade summary is non-critical — don't toast.
    }
  }

  Future<void> _loadTrend(
    Emitter<CoursesState> emit,
    String childId,
  ) async {
    try {
      final trend = await _gradeRepository.getGradeTrend(childId);
      if (emit.isDone) return;
      emit(state.copyWith(trendSection: CoursesAsyncSection.loaded(trend)));
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          trendSection: CoursesAsyncSection.failure(e.describeError()),
        ),
      );
      // Trend is non-blocking; don't toast.
    }
  }

  void _maybeEmitUnauthorized(Object error) {
    if (isUnauthorizedError(error)) {
      emitPresentation(const CoursesUnauthorizedPresentationEvent());
    }
  }
}
