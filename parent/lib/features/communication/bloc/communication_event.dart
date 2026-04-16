part of 'communication_bloc.dart';

sealed class CommunicationEvent extends Equatable {
  const CommunicationEvent();

  @override
  List<Object?> get props => [];
}

final class CommunicationStarted extends CommunicationEvent {
  final String? childId;

  const CommunicationStarted({this.childId});

  @override
  List<Object?> get props => [childId];
}

final class AnnouncementsSearchChanged extends CommunicationEvent {
  final String query;

  const AnnouncementsSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}
