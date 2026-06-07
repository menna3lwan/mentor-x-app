part of 'my_courses_bloc.dart';

sealed class MyCoursesEvent extends Equatable {
  const MyCoursesEvent();

  @override
  List<Object?> get props => [];
}

final class MyCoursesInitialized extends MyCoursesEvent {
  const MyCoursesInitialized();
}

final class MyCoursesTabChanged extends MyCoursesEvent {
  final MyCoursesTab tab;

  const MyCoursesTabChanged(this.tab);

  @override
  List<Object?> get props => [tab];
}

final class MyCoursesRefreshed extends MyCoursesEvent {
  const MyCoursesRefreshed();
}

final class MyCoursesSearchChanged extends MyCoursesEvent {
  final String query;

  const MyCoursesSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}
