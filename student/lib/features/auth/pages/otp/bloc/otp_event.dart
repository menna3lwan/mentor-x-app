part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

final class OtpOtpChanged extends OtpEvent {
  final String otp;

  const OtpOtpChanged(this.otp);

  @override
  List<Object?> get props => [otp];
}

final class OtpSubmitted extends OtpEvent {
  const OtpSubmitted();
}

final class OtpResendRequested extends OtpEvent {
  const OtpResendRequested();
}

final class OtpResendViaWhatsappRequested extends OtpEvent {
  const OtpResendViaWhatsappRequested();
}

final class OtpCountdownTicked extends OtpEvent {
  const OtpCountdownTicked();
}
