part of 'otp_bloc.dart';

final class OtpState extends Equatable {
  final String phoneNumber;
  final String otp;
  final int otpLength;
  final LoadingState loadingState;
  final String? errorMessage;
  final int resendCountdown;
  final bool isResending;
  final bool isResendingWhatsapp;

  const OtpState({
    required this.phoneNumber,
    this.otp = '',
    this.otpLength = 6,
    this.loadingState = LoadingState.initial,
    this.errorMessage,
    this.resendCountdown = 60,
    this.isResending = false,
    this.isResendingWhatsapp = false,
  });

  bool get isLoading => loadingState.isLoading;
  bool get canResend =>
      resendCountdown <= 0 && !isResending && !isResendingWhatsapp;

  String get formattedCountdown {
    final minutes = resendCountdown ~/ 60;
    final seconds = resendCountdown % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  OtpState copyWith({
    String? phoneNumber,
    String? otp,
    int? otpLength,
    LoadingState? loadingState,
    String? errorMessage,
    int? resendCountdown,
    bool? isResending,
    bool? isResendingWhatsapp,
  }) {
    return OtpState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      otpLength: otpLength ?? this.otpLength,
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      isResending: isResending ?? this.isResending,
      isResendingWhatsapp:
          isResendingWhatsapp ?? this.isResendingWhatsapp,
    );
  }

  @override
  List<Object?> get props => [
    phoneNumber,
    otp,
    otpLength,
    loadingState,
    errorMessage,
    resendCountdown,
    isResending,
    isResendingWhatsapp,
  ];
}
