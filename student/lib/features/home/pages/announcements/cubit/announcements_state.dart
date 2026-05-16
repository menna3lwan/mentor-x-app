part of 'announcements_cubit.dart';

sealed class AnnouncementsState {
  const AnnouncementsState();
}

final class AnnouncementsInitial extends AnnouncementsState {
  const AnnouncementsInitial();
}

final class AnnouncementsLoading extends AnnouncementsState {
  const AnnouncementsLoading();
}

final class AnnouncementsLoaded extends AnnouncementsState {
  final List<AnnouncementEntity> announcements;

  const AnnouncementsLoaded({required this.announcements});
}

final class AnnouncementsFailure extends AnnouncementsState {
  final String message;

  const AnnouncementsFailure({required this.message});
}
