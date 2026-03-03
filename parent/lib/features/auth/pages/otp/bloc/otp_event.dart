part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

final class OtpSubmittedEvent extends OtpEvent {
  final String phone;
  final String code;

  const OtpSubmittedEvent({required this.phone, required this.code});

  @override
  List<Object?> get props => [phone, code];
}
