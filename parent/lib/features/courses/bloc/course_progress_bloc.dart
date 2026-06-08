import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/bloc_error_helpers.dart';

part 'course_progress_event.dart';
part 'course_progress_state.dart';

// ──── Presentation events ──────────────────────────────────────────────────

sealed class CourseProgressPresentationEvent {
  const CourseProgressPresentationEvent();
}

final class CourseProgressFailurePresentationEvent
    extends CourseProgressPresentationEvent {
  final String message;
  const CourseProgressFailurePresentationEvent({required this.message});
}

final class CourseProgressUnauthorizedPresentationEvent
    extends CourseProgressPresentationEvent {
  const CourseProgressUnauthorizedPresentationEvent();
}

// ──── Bloc ─────────────────────────────────────────────────────────────────

/// Drives the per-course progress detail screen.
///
/// Fetches a single [CourseSummaryEntity] for a given (childId, courseId)
/// pair. The screen is read-only so the bloc only exposes a Start and a
/// Refresh event (both droppable so a double-tap can't double-fetch).
final class CourseProgressBloc
    extends Bloc<CourseProgressEvent, CourseProgressState>
    with
        BlocPresentationMixin<
          CourseProgressState,
          CourseProgressPresentationEvent
        > {
  final ParentCourseRepository _courseRepository;

  CourseProgressBloc({required ParentCourseRepository courseRepository})
    : _courseRepository = courseRepository,
      super(CourseProgressState.initial()) {
    on<CourseProgressStarted>(_onStarted);
    on<CourseProgressRefreshRequested>(
      _onRefreshRequested,
      transformer: droppable(),
    );
  }

  Future<void> _onStarted(
    CourseProgressStarted event,
    Emitter<CourseProgressState> emit,
  ) async {
    emit(
      state.copyWith(
        childId: event.childId,
        courseId: event.courseId,
        status: CourseProgressStatus.loading,
      ),
    );
    await _load(emit, event.childId, event.courseId);
  }

  Future<void> _onRefreshRequested(
    CourseProgressRefreshRequested event,
    Emitter<CourseProgressState> emit,
  ) async {
    final childId = state.childId;
    final courseId = state.courseId;
    if (childId == null || courseId == null) return;
    if (state.isRefreshing) return;
    emit(state.copyWith(isRefreshing: true));
    try {
      await _load(emit, childId, courseId);
    } finally {
      if (!emit.isDone) emit(state.copyWith(isRefreshing: false));
    }
  }

  Future<void> _load(
    Emitter<CourseProgressState> emit,
    String childId,
    String courseId,
  ) async {
    try {
      final summary = await _courseRepository.getCourseProgress(
        childId,
        courseId,
      );
      if (emit.isDone) return;
      emit(
        state.copyWith(
          status: CourseProgressStatus.loaded,
          summary: summary,
        ),
      );
    } catch (e) {
      if (emit.isDone) return;
      final message = e.describeError();
      emit(
        state.copyWith(
          status: CourseProgressStatus.failure,
          errorMessage: message,
        ),
      );
      if (isUnauthorizedError(e)) {
        emitPresentation(const CourseProgressUnauthorizedPresentationEvent());
        return;
      }
      emitPresentation(
        CourseProgressFailurePresentationEvent(message: message),
      );
    }
  }
}
