part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

final class LoginSubmittedEvent extends LoginEvent {
  final String phoneNumber;
  final String password;
  final String? fcmToken;

  const LoginSubmittedEvent({
    required this.phoneNumber,
    required this.password,
    this.fcmToken,
  });

  @override
  List<Object?> get props => [
    phoneNumber,
    password,
    fcmToken,
  ];
}
