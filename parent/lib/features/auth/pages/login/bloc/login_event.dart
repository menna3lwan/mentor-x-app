part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

final class LoginSubmittedEvent extends LoginEvent {
  final String phoneNumber;
  final String password;
  final String? deviceHash;
  final String? deviceName;
  final String? fcmToken;
  final String? appVersion;

  const LoginSubmittedEvent({
    required this.phoneNumber,
    required this.password,
    this.deviceHash,
    this.deviceName,
    this.fcmToken,
    this.appVersion,
  });

  @override
  List<Object?> get props => [
    phoneNumber,
    password,
    deviceHash,
    deviceName,
    fcmToken,
    appVersion,
  ];
}
