import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final ParentCourseRepository _courseRepository;
  final ParentGradeRepository _gradeRepository;

  CoursesBloc({
    required ParentCourseRepository courseRepository,
    required ParentGradeRepository gradeRepository,
  })  : _courseRepository = courseRepository,
        _gradeRepository = gradeRepository,
        super(const CoursesState()) {
    on<CoursesStarted>(_onStarted);
    on<CoursesRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onStarted(
      CoursesStarted event, Emitter<CoursesState> emit) async {
    emit(state.copyWith(status: CoursesStatus.loading));
    try {
      final results = await Future.wait([
        _courseRepository.getCourses(event.childId),
        _gradeRepository.getGradeSummary(event.childId),
        _gradeRepository.getGradeTrend(event.childId),
      ]);

      emit(state.copyWith(
        status: CoursesStatus.success,
        courses: results[0] as List<CourseEntity>,
        gradeSummary: results[1] as ParentGradeSummaryEntity,
        gradeTrend: results[2] as ParentGradeTrendEntity,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CoursesStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshRequested(
      CoursesRefreshRequested event, Emitter<CoursesState> emit) async {
    add(CoursesStarted(event.childId));
  }
}
