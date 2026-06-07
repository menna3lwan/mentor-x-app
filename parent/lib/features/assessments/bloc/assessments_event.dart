part of 'assessments_bloc.dart';

sealed class AssessmentsEvent extends Equatable {
  const AssessmentsEvent();
  @override
  List<Object?> get props => [];
}

final class AssessmentsStarted extends AssessmentsEvent {
  final String childId;
  const AssessmentsStarted(this.childId);
  @override
  List<Object?> get props => [childId];
}

final class AssessmentsRefreshRequested extends AssessmentsEvent {
  final String childId;
  const AssessmentsRefreshRequested(this.childId);
  @override
  List<Object?> get props => [childId];
}
