import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import '../../../../../core/core.dart';
import 'package:analytics_service/analytics_service.dart';

part 'my_courses_page_event.dart';
part 'my_courses_page_state.dart';

sealed class MyCoursesPagePresentationEvent {
  const MyCoursesPagePresentationEvent();
}

final class MyCoursesPageFailurePresentationEvent
    extends MyCoursesPagePresentationEvent {
  final String message;
  const MyCoursesPageFailurePresentationEvent({required this.message});
}

final class MyCoursesPageBloc
    extends Bloc<MyCoursesPageEvent, MyCoursesPageState>
    with
        BlocPresentationMixin<
          MyCoursesPageState,
          MyCoursesPagePresentationEvent
        > {
  final CourseRepository _courseRepository;
  final AnalyticsService _analyticsService;

  MyCoursesPageBloc({
    required CourseRepository courseRepository,
    required AnalyticsService analyticsService,
  }) : _courseRepository = courseRepository,
       _analyticsService = analyticsService,
       super(MyCoursesPageState.initial) {
    on<MyCoursesPageInitialized>(_onInitialized);
    on<MyCoursesPageTabChanged>(_onTabChanged);
    on<MyCoursesPageRefreshed>(_onRefreshed);
    on<MyCoursesPageSearchChanged>(_onSearchChanged);
  }

  Future<void> _onInitialized(
    MyCoursesPageInitialized event,
    Emitter<MyCoursesPageState> emit,
  ) async {
    _analyticsService.logEvent(name: AnalyticsEvents.myCoursesViewed);
    await _loadCourses(emit: emit);
  }

  Future<void> _onTabChanged(
    MyCoursesPageTabChanged event,
    Emitter<MyCoursesPageState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedTab: event.tab,
        loadingState: LoadingState.loading,
      ),
    );
    await _loadCourses(emit: emit);
  }

  Future<void> _onRefreshed(
    MyCoursesPageRefreshed event,
    Emitter<MyCoursesPageState> emit,
  ) async {
    await _loadCourses(emit: emit);
  }

  Future<void> _onSearchChanged(
    MyCoursesPageSearchChanged event,
    Emitter<MyCoursesPageState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.query));
    await _loadCourses(emit: emit);
  }

  Future<void> _loadCourses({required Emitter<MyCoursesPageState> emit}) async {
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
        MyCoursesPageFailurePresentationEvent(message: e.message ?? ''),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
      emitPresentation(
        MyCoursesPageFailurePresentationEvent(message: e.toString()),
      );
    }
  }
}
