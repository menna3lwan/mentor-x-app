part of 'communication_bloc.dart';

sealed class CommunicationEvent extends Equatable {
  const CommunicationEvent();

  @override
  List<Object?> get props => [];
}

final class CommunicationStarted extends CommunicationEvent {
  final String childId;
  const CommunicationStarted(this.childId);

  @override
  List<Object?> get props => [childId];
}

final class CommunicationRefreshRequested extends CommunicationEvent {
  final String childId;
  const CommunicationRefreshRequested(this.childId);

  @override
  List<Object?> get props => [childId];
}

final class CommunicationRetrySectionRequested extends CommunicationEvent {
  final CommunicationSection section;
  const CommunicationRetrySectionRequested(this.section);

  @override
  List<Object?> get props => [section];
}
