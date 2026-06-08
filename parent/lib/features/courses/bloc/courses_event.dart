part of 'courses_bloc.dart';

sealed class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object?> get props => [];
}

final class CoursesStarted extends CoursesEvent {
  final String childId;
  const CoursesStarted(this.childId);

  @override
  List<Object?> get props => [childId];
}

final class CoursesRefreshRequested extends CoursesEvent {
  final String childId;
  const CoursesRefreshRequested(this.childId);

  @override
  List<Object?> get props => [childId];
}

final class CoursesRetrySectionRequested extends CoursesEvent {
  final CoursesSection section;
  const CoursesRetrySectionRequested(this.section);

  @override
  List<Object?> get props => [section];
}
