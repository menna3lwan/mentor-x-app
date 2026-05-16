part of 'my_courses_page_bloc.dart';

sealed class MyCoursesPageEvent extends Equatable {
  const MyCoursesPageEvent();

  @override
  List<Object?> get props => [];
}

final class MyCoursesPageInitialized extends MyCoursesPageEvent {
  const MyCoursesPageInitialized();
}

final class MyCoursesPageTabChanged extends MyCoursesPageEvent {
  final MyCoursesTab tab;

  const MyCoursesPageTabChanged(this.tab);

  @override
  List<Object?> get props => [tab];
}

final class MyCoursesPageRefreshed extends MyCoursesPageEvent {
  const MyCoursesPageRefreshed();
}

final class MyCoursesPageSearchChanged extends MyCoursesPageEvent {
  final String query;

  const MyCoursesPageSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}
