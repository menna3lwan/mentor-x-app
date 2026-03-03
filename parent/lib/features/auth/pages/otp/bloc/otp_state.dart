part of 'otp_bloc.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object?> get props => [];
}

final class OtpInitial extends OtpState {}

final class OtpLoading extends OtpState {}

final class OtpSuccess extends OtpState {}

final class OtpFailure extends OtpState {
  final MentorXException exception;
  const OtpFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
