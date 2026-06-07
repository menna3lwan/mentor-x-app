import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'my_courses_event.dart';
part 'my_courses_state.dart';

sealed class MyCoursesPresentationEvent {
  const MyCoursesPresentationEvent();
}

final class MyCoursesFailurePresentationEvent
    extends MyCoursesPresentationEvent {
  final String message;
  const MyCoursesFailurePresentationEvent({required this.message});
}

final class MyCoursesBloc
    extends Bloc<MyCoursesEvent, MyCoursesState>
    with
        BlocPresentationMixin<
          MyCoursesState,
          MyCoursesPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('MyCoursesBloc');

  final CourseRepository _courseRepository;
  final AnalyticsService _analyticsService;

  MyCoursesBloc({
    required CourseRepository courseRepository,
    required AnalyticsService analyticsService,
  }) : _courseRepository = courseRepository,
       _analyticsService = analyticsService,
       super(MyCoursesState.initial) {
    on<MyCoursesInitialized>(_onInitialized);
    on<MyCoursesTabChanged>(_onTabChanged);
    on<MyCoursesRefreshed>(_onRefreshed);
    on<MyCoursesSearchChanged>(_onSearchChanged);
  }

  Future<void> _onInitialized(
    MyCoursesInitialized event,
    Emitter<MyCoursesState> emit,
  ) async {
    _logger.info('_onInitialized entered');
    _analyticsService.logEvent(name: AnalyticsEvents.myCoursesViewed);
    await _loadCourses(emit: emit);
  }

  Future<void> _onTabChanged(
    MyCoursesTabChanged event,
    Emitter<MyCoursesState> emit,
  ) async {
    _logger.info('_onTabChanged entered');
    emit(
      state.copyWith(
        selectedTab: event.tab,
        loadingState: LoadingState.loading,
      ),
    );
    await _loadCourses(emit: emit);
  }

  Future<void> _onRefreshed(
    MyCoursesRefreshed event,
    Emitter<MyCoursesState> emit,
  ) async {
    _logger.info('_onRefreshed entered');
    await _loadCourses(emit: emit);
  }

  Future<void> _onSearchChanged(
    MyCoursesSearchChanged event,
    Emitter<MyCoursesState> emit,
  ) async {
    _logger.info('_onSearchChanged entered');
    emit(state.copyWith(searchQuery: event.query));
    await _loadCourses(emit: emit);
  }

  Future<void> _loadCourses({required Emitter<MyCoursesState> emit}) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final statusFilter = switch (state.selectedTab) {
        MyCoursesTab.inProgress => 'in_progress',
        MyCoursesTab.completed => 'completed',
        MyCoursesTab.expired => 'expired',
      };
      final courses = await _courseRepository.getEnrolledCourses(
        status: statusFilter,
        search: state.searchQuery.isNotEmpty ? state.searchQuery : null,
      );
      emit(state.copyWith(loadingState: LoadingState.loaded, courses: courses));
    } on CourseRepositoryException catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.message,
        ),
      );
      emitPresentation(
        MyCoursesFailurePresentationEvent(message: e.message ?? ''),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
      emitPresentation(
        MyCoursesFailurePresentationEvent(message: e.toString()),
      );
    }
  }
}
