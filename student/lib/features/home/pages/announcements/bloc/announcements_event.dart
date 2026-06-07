part of 'announcements_bloc.dart';

sealed class AnnouncementsEvent extends Equatable {
  const AnnouncementsEvent();

  @override
  List<Object?> get props => [];
}

final class AnnouncementsLoadRequested extends AnnouncementsEvent {
  const AnnouncementsLoadRequested();
}
