part of 'assessments_bloc.dart';

abstract class AssessmentsEvent extends Equatable {
  const AssessmentsEvent();
  @override
  List<Object?> get props => [];
}

class AssessmentsStarted extends AssessmentsEvent {
  final String childId;
  const AssessmentsStarted(this.childId);
  @override
  List<Object?> get props => [childId];
}

class AssessmentsRefreshRequested extends AssessmentsEvent {
  final String childId;
  const AssessmentsRefreshRequested(this.childId);
  @override
  List<Object?> get props => [childId];
}
