part of 'notifications_page_bloc.dart';

sealed class NotificationsPageEvent extends Equatable {
  const NotificationsPageEvent();

  @override
  List<Object?> get props => [];
}

final class NotificationsPageLoadEvent extends NotificationsPageEvent {
  const NotificationsPageLoadEvent();
}

final class NotificationsPageLoadMoreEvent extends NotificationsPageEvent {
  const NotificationsPageLoadMoreEvent();
}

final class NotificationsPageMarkAsReadEvent extends NotificationsPageEvent {
  final String notificationId;
  const NotificationsPageMarkAsReadEvent(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

final class NotificationsPageMarkAllAsReadEvent extends NotificationsPageEvent {
  const NotificationsPageMarkAllAsReadEvent();
}
