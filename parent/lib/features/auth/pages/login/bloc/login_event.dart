part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

final class LoginInitialEvent extends LoginEvent {
  const LoginInitialEvent();
}

final class LoginSubmittedEvent extends LoginEvent {
  final String phoneNumber;
  final String password;

  const LoginSubmittedEvent({
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [phoneNumber, password];
}
