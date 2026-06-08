part of 'course_progress_bloc.dart';

enum CourseProgressStatus { initial, loading, loaded, failure }

final class CourseProgressState extends Equatable {
  final CourseProgressStatus status;
  final String? childId;
  final String? courseId;
  final CourseSummaryEntity? summary;
  final String? errorMessage;
  final bool isRefreshing;

  const CourseProgressState({
    required this.status,
    this.childId,
    this.courseId,
    this.summary,
    this.errorMessage,
    this.isRefreshing = false,
  });

  factory CourseProgressState.initial() =>
      const CourseProgressState(status: CourseProgressStatus.initial);

  bool get isLoading => status == CourseProgressStatus.loading;
  bool get isLoaded => status == CourseProgressStatus.loaded;
  bool get isFailure => status == CourseProgressStatus.failure;

  CourseProgressState copyWith({
    CourseProgressStatus? status,
    String? childId,
    String? courseId,
    CourseSummaryEntity? summary,
    String? errorMessage,
    bool? isRefreshing,
  }) {
    return CourseProgressState(
      status: status ?? this.status,
      childId: childId ?? this.childId,
      courseId: courseId ?? this.courseId,
      summary: summary ?? this.summary,
      errorMessage: errorMessage ?? this.errorMessage,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
    status,
    childId,
    courseId,
    summary,
    errorMessage,
    isRefreshing,
  ];
}
