part of 'otp_page_bloc.dart';

sealed class OtpPageEvent extends Equatable {
  const OtpPageEvent();

  @override
  List<Object?> get props => [];
}

final class OtpPageOtpChanged extends OtpPageEvent {
  final String otp;

  const OtpPageOtpChanged(this.otp);

  @override
  List<Object?> get props => [otp];
}

final class OtpPageSubmitted extends OtpPageEvent {
  const OtpPageSubmitted();
}

final class OtpPageResendRequested extends OtpPageEvent {
  const OtpPageResendRequested();
}

final class OtpPageCountdownTicked extends OtpPageEvent {
  const OtpPageCountdownTicked();
}
