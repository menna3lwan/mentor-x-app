part of 'login_page_bloc.dart';

sealed class LoginPageEvent extends Equatable {
  const LoginPageEvent();

  @override
  List<Object?> get props => [];
}

final class LoginPagePhoneChanged extends LoginPageEvent {
  final String phoneNumber;

  const LoginPagePhoneChanged(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

final class LoginPageSubmitted extends LoginPageEvent {
  const LoginPageSubmitted();
}
