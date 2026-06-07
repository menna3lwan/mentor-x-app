import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';

import 'package:mentorx_student/core/core.dart';

part 'my_grades_event.dart';
part 'my_grades_state.dart';

sealed class MyGradesPresentationEvent {
  const MyGradesPresentationEvent();
}

final class MyGradesFailurePresentationEvent
    extends MyGradesPresentationEvent {
  final String message;

  const MyGradesFailurePresentationEvent({required this.message});
}

final class MyGradesBloc extends Bloc<MyGradesEvent, MyGradesState>
    with
        BlocPresentationMixin<
          MyGradesState,
          MyGradesPresentationEvent
        > {
  final GradeRepository _gradeRepository;
  final CourseRepository _courseRepository;
  final AnalyticsService _analyticsService;

  MyGradesBloc({
    required GradeRepository gradeRepository,
    required CourseRepository courseRepository,
    required AnalyticsService analyticsService,
  }) : _gradeRepository = gradeRepository,
       _courseRepository = courseRepository,
       _analyticsService = analyticsService,
       super(MyGradesState.initial) {
    on<MyGradesInitialized>(_onInitialized);
    on<MyGradesRefreshed>(_onRefreshed);
    on<MyGradesCourseFilterChanged>(_onCourseFilterChanged);
  }

  Future<void> _onInitialized(
    MyGradesInitialized event,
    Emitter<MyGradesState> emit,
  ) async {
    _analyticsService.logEvent(name: AnalyticsEvents.myGradesViewed);
    await _load(emit: emit);
  }

  Future<void> _onRefreshed(
    MyGradesRefreshed event,
    Emitter<MyGradesState> emit,
  ) async {
    await _load(emit: emit);
  }

  Future<void> _onCourseFilterChanged(
    MyGradesCourseFilterChanged event,
    Emitter<MyGradesState> emit,
  ) async {
    emit(state.copyWith(selectedCourseId: event.courseId));
    await _load(emit: emit);
  }

  Future<void> _load({required Emitter<MyGradesState> emit}) async {
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );

    try {
      final courses = await _courseRepository.getEnrolledCourses();
      final selectedCourseId = state.selectedCourseId;

      final visibleCourses =
          selectedCourseId == null || selectedCourseId == 'all'
          ? courses
          : courses.where((course) => course.id == selectedCourseId).toList();

      final sections = await Future.wait(
        visibleCourses.map((course) async {
          final quizzes = await _gradeRepository.getQuizGrades(
            courseId: course.courseId,
          );
          final assignments = await _gradeRepository.getAssignmentGrades(
            courseId: course.courseId,
          );

          final percentageValues = <double>[];
          for (final quiz in quizzes) {
            percentageValues.add(quiz.percentage);
          }
          for (final assignment in assignments) {
            final percentage = assignment.percentage;
            if (percentage != null) {
              percentageValues.add(percentage);
            }
          }

          final courseAverage = percentageValues.isEmpty
              ? null
              : percentageValues.reduce((a, b) => a + b) /
                    percentageValues.length;

          return CourseGradesSection(
            course: course,
            quizzes: quizzes,
            assignments: assignments,
            averagePercentage: courseAverage,
          );
        }),
      );

      final nonEmptySections = sections
          .where(
            (section) =>
                section.quizzes.isNotEmpty || section.assignments.isNotEmpty,
          )
          .toList();

      final allPercentages = <double>[];
      for (final section in nonEmptySections) {
        for (final quiz in section.quizzes) {
          allPercentages.add(quiz.percentage);
        }
        for (final assignment in section.assignments) {
          final percentage = assignment.percentage;
          if (percentage != null) {
            allPercentages.add(percentage);
          }
        }
      }

      final overallAverage = allPercentages.isEmpty
          ? null
          : allPercentages.reduce((a, b) => a + b) / allPercentages.length;

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          courses: courses,
          sections: nonEmptySections,
          overallAverage: overallAverage,
        ),
      );
    } on GradeRepositoryException catch (e) {
      final message = e.message ?? 'Failed to load grades.';
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(MyGradesFailurePresentationEvent(message: message));
    } on CourseRepositoryException catch (e) {
      final message = e.message ?? 'Failed to load courses.';
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(MyGradesFailurePresentationEvent(message: message));
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(MyGradesFailurePresentationEvent(message: message));
    }
  }
}
