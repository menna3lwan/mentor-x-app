part of 'courses_bloc.dart';

enum CoursesStatus { initial, loading, success, failure }

final class CoursesState extends Equatable {
  final CoursesStatus status;
  final List<CourseEntity> courses;
  final ParentGradeSummaryEntity? gradeSummary;
  final ParentGradeTrendEntity? gradeTrend;
  final String? errorMessage;

  const CoursesState({
    this.status = CoursesStatus.initial,
    this.courses = const [],
    this.gradeSummary,
    this.gradeTrend,
    this.errorMessage,
  });

  CoursesState copyWith({
    CoursesStatus? status,
    List<CourseEntity>? courses,
    ParentGradeSummaryEntity? gradeSummary,
    ParentGradeTrendEntity? gradeTrend,
    String? errorMessage,
  }) {
    return CoursesState(
      status: status ?? this.status,
      courses: courses ?? this.courses,
      gradeSummary: gradeSummary ?? this.gradeSummary,
      gradeTrend: gradeTrend ?? this.gradeTrend,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        courses,
        gradeSummary,
        gradeTrend,
        errorMessage,
      ];
}
