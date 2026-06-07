part of 'course_detail_bloc.dart';

sealed class CourseDetailEvent extends Equatable {
  const CourseDetailEvent();

  @override
  List<Object?> get props => [];
}

final class CourseDetailInitialized extends CourseDetailEvent {
  const CourseDetailInitialized();
}

final class CourseDetailTabChanged extends CourseDetailEvent {
  final CourseDetailTab tab;

  const CourseDetailTabChanged(this.tab);

  @override
  List<Object?> get props => [tab];
}

final class CourseDetailEnrollRequested extends CourseDetailEvent {
  const CourseDetailEnrollRequested();
}

final class CourseDetailRefreshed extends CourseDetailEvent {
  const CourseDetailRefreshed();
}

final class CourseDetailApplyCouponRequested extends CourseDetailEvent {
  final String code;
  const CourseDetailApplyCouponRequested(this.code);

  @override
  List<Object?> get props => [code];
}

final class CourseDetailRemoveCouponRequested extends CourseDetailEvent {
  const CourseDetailRemoveCouponRequested();
}
