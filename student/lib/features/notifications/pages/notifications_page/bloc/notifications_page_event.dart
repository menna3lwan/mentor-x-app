part of 'notifications_page_bloc.dart';

sealed class NotificationsPageEvent extends Equatable {
  const NotificationsPageEvent();

  @override
  List<Object?> get props => [];
}

final class NotificationsPageLoadEvent extends NotificationsPageEvent {
  const NotificationsPageLoadEvent();
}
