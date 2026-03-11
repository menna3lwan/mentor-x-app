import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'my_courses_page_event.dart';
part 'my_courses_page_state.dart';

final class MyCoursesPageBloc
    extends Bloc<MyCoursesPageEvent, MyCoursesPageState> {
  final CourseRepository _courseRepository;

  MyCoursesPageBloc({
    required CourseRepository courseRepository,
  }) : _courseRepository = courseRepository,
       super(const MyCoursesPageState()) {
    on<MyCoursesPageInitialized>(_onInitialized);
    on<MyCoursesPageTabChanged>(_onTabChanged);
    on<MyCoursesPageRefreshed>(_onRefreshed);
    on<MyCoursesPageSearchChanged>(_onSearchChanged);
  }

  Future<void> _onInitialized(
    MyCoursesPageInitialized event,
    Emitter<MyCoursesPageState> emit,
  ) async {
    await _loadCourses(emit: emit);
  }

  Future<void> _onTabChanged(
    MyCoursesPageTabChanged event,
    Emitter<MyCoursesPageState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedTab: event.tab,
        status: MyCoursesPageStatus.loading,
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

  Future<void> _loadCourses({
    required Emitter<MyCoursesPageState> emit,
  }) async {
    emit(state.copyWith(status: MyCoursesPageStatus.loading));

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

      emit(
        state.copyWith(
          status: MyCoursesPageStatus.loaded,
          courses: courses,
        ),
      );
    } on CourseRepositoryException catch (e) {
      emit(
        state.copyWith(
          status: MyCoursesPageStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MyCoursesPageStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
