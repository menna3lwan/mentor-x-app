part of 'course_detail_page_bloc.dart';

sealed class CourseDetailPageEvent extends Equatable {
  const CourseDetailPageEvent();

  @override
  List<Object?> get props => [];
}

final class CourseDetailPageInitialized extends CourseDetailPageEvent {
  const CourseDetailPageInitialized();
}

final class CourseDetailPageTabChanged extends CourseDetailPageEvent {
  final CourseDetailTab tab;

  const CourseDetailPageTabChanged(this.tab);

  @override
  List<Object?> get props => [tab];
}

final class CourseDetailPageEnrollRequested extends CourseDetailPageEvent {
  const CourseDetailPageEnrollRequested();
}

final class CourseDetailPageRefreshed extends CourseDetailPageEvent {
  const CourseDetailPageRefreshed();
}
