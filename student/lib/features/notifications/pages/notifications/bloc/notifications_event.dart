part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object?> get props => [];
}

final class NotificationsLoadEvent extends NotificationsEvent {
  const NotificationsLoadEvent();
}

final class NotificationsLoadMoreEvent extends NotificationsEvent {
  const NotificationsLoadMoreEvent();
}

final class NotificationsMarkAsReadEvent extends NotificationsEvent {
  final String notificationId;
  const NotificationsMarkAsReadEvent(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

final class NotificationsMarkAllAsReadEvent extends NotificationsEvent {
  const NotificationsMarkAllAsReadEvent();
}
