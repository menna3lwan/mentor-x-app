part of 'courses_bloc.dart';

abstract class CoursesEvent extends Equatable {
  const CoursesEvent();
  @override
  List<Object?> get props => [];
}

class CoursesStarted extends CoursesEvent {
  final String childId;
  const CoursesStarted(this.childId);
  @override
  List<Object?> get props => [childId];
}

class CoursesRefreshRequested extends CoursesEvent {
  final String childId;
  const CoursesRefreshRequested(this.childId);
  @override
  List<Object?> get props => [childId];
}

class CourseSelected extends CoursesEvent {
  final String courseId;
  const CourseSelected(this.courseId);
  @override
  List<Object?> get props => [courseId];
}
