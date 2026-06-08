part of 'course_progress_bloc.dart';

sealed class CourseProgressEvent extends Equatable {
  const CourseProgressEvent();

  @override
  List<Object?> get props => const [];
}

final class CourseProgressStarted extends CourseProgressEvent {
  final String childId;
  final String courseId;
  const CourseProgressStarted({
    required this.childId,
    required this.courseId,
  });

  @override
  List<Object?> get props => [childId, courseId];
}

final class CourseProgressRefreshRequested extends CourseProgressEvent {
  const CourseProgressRefreshRequested();
}
