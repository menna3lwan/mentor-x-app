part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordPhoneChanged extends ForgotPasswordEvent {
  final String phone;

  const ForgotPasswordPhoneChanged(this.phone);

  @override
  List<Object> get props => [phone];
}

final class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  const ForgotPasswordSubmitted();
}
