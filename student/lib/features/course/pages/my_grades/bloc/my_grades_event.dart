part of 'my_grades_bloc.dart';

sealed class MyGradesEvent extends Equatable {
  const MyGradesEvent();

  @override
  List<Object?> get props => [];
}

final class MyGradesInitialized extends MyGradesEvent {
  const MyGradesInitialized();
}

final class MyGradesRefreshed extends MyGradesEvent {
  const MyGradesRefreshed();
}

final class MyGradesCourseFilterChanged extends MyGradesEvent {
  final String? courseId;

  const MyGradesCourseFilterChanged({this.courseId});

  @override
  List<Object?> get props => [courseId];
}
