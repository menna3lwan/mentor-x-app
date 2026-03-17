import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'course_detail_page_event.dart';
part 'course_detail_page_state.dart';

sealed class CourseDetailPagePresentationEvent {
  const CourseDetailPagePresentationEvent();
}

final class CourseDetailPageEnrollSuccessPresentationEvent
    extends CourseDetailPagePresentationEvent {
  const CourseDetailPageEnrollSuccessPresentationEvent();
}

final class CourseDetailPageEnrollFailurePresentationEvent
    extends CourseDetailPagePresentationEvent {
  final String message;
  const CourseDetailPageEnrollFailurePresentationEvent({required this.message});
}

final class CourseDetailPageFailurePresentationEvent
    extends CourseDetailPagePresentationEvent {
  final String message;
  const CourseDetailPageFailurePresentationEvent({required this.message});
}

final class CourseDetailPageBloc
    extends Bloc<CourseDetailPageEvent, CourseDetailPageState>
    with
        BlocPresentationMixin<
          CourseDetailPageState,
          CourseDetailPagePresentationEvent
        > {
  final CourseRepository _courseRepository;

  CourseDetailPageBloc({
    required CourseRepository courseRepository,
    required String courseId,
  }) : _courseRepository = courseRepository,
       super(CourseDetailPageState(courseId: courseId)) {
    on<CourseDetailPageInitialized>(_onInitialized);
    on<CourseDetailPageTabChanged>(_onTabChanged);
    on<CourseDetailPageEnrollRequested>(_onEnrollRequested);
    on<CourseDetailPageRefreshed>(_onRefreshed);
  }

  Future<void> _onInitialized(
    CourseDetailPageInitialized event,
    Emitter<CourseDetailPageState> emit,
  ) async {
    await _loadAll(emit: emit);
  }

  Future<void> _onTabChanged(
    CourseDetailPageTabChanged event,
    Emitter<CourseDetailPageState> emit,
  ) {
    emit(state.copyWith(selectedTab: event.tab));
    return Future.value();
  }

  Future<void> _onEnrollRequested(
    CourseDetailPageEnrollRequested event,
    Emitter<CourseDetailPageState> emit,
  ) async {
    emit(state.copyWith(enrollStatus: EnrollActionStatus.loading));
    try {
      final enrollment = await _courseRepository.enrollInCourse(state.courseId);
      emit(
        state.copyWith(
          enrollStatus: EnrollActionStatus.success,
          enrollment: enrollment,
        ),
      );
      emitPresentation(const CourseDetailPageEnrollSuccessPresentationEvent());
    } on CourseRepositoryException catch (e) {
      emit(
        state.copyWith(
          enrollStatus: EnrollActionStatus.failure,
          enrollErrorMessage: e.message,
        ),
      );
      emitPresentation(
        CourseDetailPageEnrollFailurePresentationEvent(
          message: e.message ?? '',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          enrollStatus: EnrollActionStatus.failure,
          enrollErrorMessage: e.toString(),
        ),
      );
      emitPresentation(
        CourseDetailPageEnrollFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _onRefreshed(
    CourseDetailPageRefreshed event,
    Emitter<CourseDetailPageState> emit,
  ) async {
    await _loadAll(emit: emit);
  }

  Future<void> _loadAll({required Emitter<CourseDetailPageState> emit}) async {
    emit(
      state.copyWith(
        courseStatus: DetailSectionStatus.loading,
        sessionsStatus: DetailSectionStatus.loading,
      ),
    );
    await Future.wait([
      _loadCourseDetail(emit),
      _loadSessions(emit),
      _loadEnrollment(emit),
    ]);
  }

  Future<void> _loadCourseDetail(Emitter<CourseDetailPageState> emit) async {
    try {
      final course = await _courseRepository.getCourseDetail(state.courseId);
      emit(
        state.copyWith(
          courseStatus: DetailSectionStatus.loaded,
          course: course,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          courseStatus: DetailSectionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _loadSessions(Emitter<CourseDetailPageState> emit) async {
    try {
      final sessions = await _courseRepository.getCourseSessions(
        state.courseId,
      );
      emit(
        state.copyWith(
          sessionsStatus: DetailSectionStatus.loaded,
          sessions: sessions,
        ),
      );
      final itemFutures = <String, Future<List<SessionItemEntity>>>{};
      for (final session in sessions) {
        itemFutures[session.id] = _courseRepository.getSessionItems(session.id);
      }
      final itemsMap = <String, List<SessionItemEntity>>{};
      for (final entry in itemFutures.entries) {
        try {
          itemsMap[entry.key] = await entry.value;
        } catch (_) {
          itemsMap[entry.key] = [];
        }
      }
      emit(state.copyWith(sessionItems: itemsMap));
    } catch (e) {
      emit(state.copyWith(sessionsStatus: DetailSectionStatus.failure));
    }
  }

  Future<void> _loadEnrollment(Emitter<CourseDetailPageState> emit) async {
    try {
      final enrollment = await _courseRepository.getCourseProgress(
        state.courseId,
      );
      emit(
        state.copyWith(
          enrollment: enrollment,
          clearEnrollment: enrollment == null,
        ),
      );
    } catch (_) {}
  }
}
