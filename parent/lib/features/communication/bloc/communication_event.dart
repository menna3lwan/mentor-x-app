part of 'communication_bloc.dart';

abstract class CommunicationEvent extends Equatable {
  const CommunicationEvent();
  @override
  List<Object?> get props => [];
}

class CommunicationStarted extends CommunicationEvent {
  final String childId;
  const CommunicationStarted(this.childId);
  @override
  List<Object?> get props => [childId];
}

class CommunicationRefreshRequested extends CommunicationEvent {
  final String childId;
  const CommunicationRefreshRequested(this.childId);
  @override
  List<Object?> get props => [childId];
}

class AnnouncementsSearchChanged extends CommunicationEvent {
  final String query;
  const AnnouncementsSearchChanged(this.query);
  @override
  List<Object?> get props => [query];
}
