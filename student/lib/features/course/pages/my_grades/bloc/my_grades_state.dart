part of 'my_grades_bloc.dart';

final class CourseGradesSection extends Equatable {
  final EnrollmentEntity course;
  final List<QuizAttemptEntity> quizzes;
  final List<AssignmentSubmissionEntity> assignments;
  final double? averagePercentage;

  const CourseGradesSection({
    required this.course,
    required this.quizzes,
    required this.assignments,
    required this.averagePercentage,
  });

  @override
  List<Object?> get props => [course, quizzes, assignments, averagePercentage];
}

final class MyGradesState extends Equatable {
  final LoadingState loadingState;
  final List<EnrollmentEntity> courses;
  final List<CourseGradesSection> sections;
  final String? selectedCourseId;
  final double? overallAverage;
  final String? errorMessage;

  const MyGradesState({
    required this.loadingState,
    required this.courses,
    required this.sections,
    this.selectedCourseId,
    this.overallAverage,
    this.errorMessage,
  });

  static const initial = MyGradesState(
    loadingState: LoadingState.initial,
    courses: <EnrollmentEntity>[],
    sections: <CourseGradesSection>[],
  );

  MyGradesState copyWith({
    LoadingState? loadingState,
    List<EnrollmentEntity>? courses,
    List<CourseGradesSection>? sections,
    String? selectedCourseId,
    double? overallAverage,
    String? errorMessage,
  }) {
    return MyGradesState(
      loadingState: loadingState ?? this.loadingState,
      courses: courses ?? this.courses,
      sections: sections ?? this.sections,
      selectedCourseId: selectedCourseId ?? this.selectedCourseId,
      overallAverage: overallAverage ?? this.overallAverage,
      errorMessage: errorMessage,
    );
  }

  bool get isLoading =>
      loadingState.isLoading || loadingState == LoadingState.initial;

  @override
  List<Object?> get props => [
    loadingState,
    courses,
    sections,
    selectedCourseId,
    overallAverage,
    errorMessage,
  ];
}
