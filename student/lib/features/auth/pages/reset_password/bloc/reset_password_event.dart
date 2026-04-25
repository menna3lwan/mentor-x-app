part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

final class ResetPasswordOtpChanged extends ResetPasswordEvent {
  final String otp;
  const ResetPasswordOtpChanged(this.otp);
  @override
  List<Object> get props => [otp];
}

final class ResetPasswordNewPasswordChanged extends ResetPasswordEvent {
  final String password;
  const ResetPasswordNewPasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

final class ResetPasswordConfirmPasswordChanged extends ResetPasswordEvent {
  final String password;
  const ResetPasswordConfirmPasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

final class ResetPasswordSubmitted extends ResetPasswordEvent {
  const ResetPasswordSubmitted();
}
