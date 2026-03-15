part of 'otp_page_bloc.dart';

final class OtpPageState extends Equatable {
  final String phoneNumber;
  final String otp;
  final int otpLength;
  final LoadingState loadingState;
  final String? errorMessage;
  final int resendCountdown;
  final bool isResending;

  const OtpPageState({
    required this.phoneNumber,
    this.otp = '',
    this.otpLength = 6,
    this.loadingState = LoadingState.initial,
    this.errorMessage,
    this.resendCountdown = 60,
    this.isResending = false,
  });

  bool get isLoading => loadingState.isLoading;
  bool get canResend => resendCountdown <= 0 && !isResending;

  String get formattedCountdown {
    final minutes = resendCountdown ~/ 60;
    final seconds = resendCountdown % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  OtpPageState copyWith({
    String? phoneNumber,
    String? otp,
    int? otpLength,
    LoadingState? loadingState,
    String? errorMessage,
    int? resendCountdown,
    bool? isResending,
  }) {
    return OtpPageState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      otpLength: otpLength ?? this.otpLength,
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      isResending: isResending ?? this.isResending,
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
  ];
}
