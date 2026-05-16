part of 'my_grades_page_bloc.dart';

sealed class MyGradesPageEvent extends Equatable {
  const MyGradesPageEvent();

  @override
  List<Object?> get props => [];
}

final class MyGradesPageInitialized extends MyGradesPageEvent {
  const MyGradesPageInitialized();
}

final class MyGradesPageRefreshed extends MyGradesPageEvent {
  const MyGradesPageRefreshed();
}

final class MyGradesPageCourseFilterChanged extends MyGradesPageEvent {
  final String? courseId;

  const MyGradesPageCourseFilterChanged({this.courseId});

  @override
  List<Object?> get props => [courseId];
}
