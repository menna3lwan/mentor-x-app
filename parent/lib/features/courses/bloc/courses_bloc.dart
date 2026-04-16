import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../portal_data/portal_data.dart';

part 'courses_event.dart';
part 'courses_state.dart';

final class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final ParentPortalRepository _repository;

  CoursesBloc({required ParentPortalRepository repository})
    : _repository = repository,
      super(const CoursesState()) {
    on<CoursesStarted>(_onStarted);
    on<CourseSelected>(_onSelected);
  }

  Future<void> _onStarted(
    CoursesStarted event,
    Emitter<CoursesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final courses = await _repository.getCourses(childId: event.childId);
      emit(
        state.copyWith(
          isLoading: false,
          courses: courses,
          selectedCourseId: courses.isEmpty ? null : courses.first.id,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void _onSelected(CourseSelected event, Emitter<CoursesState> emit) {
    emit(state.copyWith(selectedCourseId: event.courseId));
  }
}
