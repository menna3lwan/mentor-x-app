part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

final class LoginPhoneChanged extends LoginEvent {
  final String phoneNumber;
  const LoginPhoneChanged(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

final class LoginPasswordChanged extends LoginEvent {
  final String password;
  const LoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

final class LoginObscurePasswordToggled extends LoginEvent {
  const LoginObscurePasswordToggled();
}

final class LoginRememberMeToggled extends LoginEvent {
  const LoginRememberMeToggled();
}

final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
