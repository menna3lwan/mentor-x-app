part of 'assessments_bloc.dart';

sealed class AssessmentsEvent extends Equatable {
  const AssessmentsEvent();

  @override
  List<Object?> get props => [];
}

final class AssessmentsStarted extends AssessmentsEvent {
  final String? childId;

  const AssessmentsStarted({this.childId});

  @override
  List<Object?> get props => [childId];
}

final class AssessmentsFilterChanged extends AssessmentsEvent {
  final String filter;

  const AssessmentsFilterChanged(this.filter);

  @override
  List<Object?> get props => [filter];
}

final class AssessmentSelected extends AssessmentsEvent {
  final String assessmentId;

  const AssessmentSelected(this.assessmentId);

  @override
  List<Object?> get props => [assessmentId];
}
