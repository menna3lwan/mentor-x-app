import 'package:mentorx_core/mentorx_core.dart';

sealed class AppAuthenticationEvent {
  const AppAuthenticationEvent();
}

final class AppAuthenticationUpdateEvent extends AppAuthenticationEvent {
  final StudentEntity? user;

  AppAuthenticationUpdateEvent({required this.user});
}

final class AppAuthenticationLogoutEvent extends AppAuthenticationEvent {
  const AppAuthenticationLogoutEvent();
}
