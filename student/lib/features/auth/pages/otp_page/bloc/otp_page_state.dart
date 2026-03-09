part of 'otp_page_bloc.dart';

enum OtpPageStatus { initial, loading, success, failure }

final class OtpPageState extends Equatable {
  final String phoneNumber;
  final String otp;
  final int otpLength;
  final OtpPageStatus status;
  final String? errorMessage;
  final StudentEntity? user;
  final int resendCountdown;
  final bool isResending;

  const OtpPageState({
    required this.phoneNumber,
    this.otp = '',
    this.otpLength = 6,
    this.status = OtpPageStatus.initial,
    this.errorMessage,
    this.user,
    this.resendCountdown = 60,
    this.isResending = false,
  });

  bool get isLoading => status == OtpPageStatus.loading;
  bool get isSuccess => status == OtpPageStatus.success;
  bool get isFailure => status == OtpPageStatus.failure;
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
    OtpPageStatus? status,
    String? errorMessage,
    StudentEntity? user,
    int? resendCountdown,
    bool? isResending,
  }) {
    return OtpPageState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      otpLength: otpLength ?? this.otpLength,
      status: status ?? this.status,
      errorMessage: errorMessage,
      user: user ?? this.user,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      isResending: isResending ?? this.isResending,
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        otp,
        otpLength,
        status,
        errorMessage,
        user,
        resendCountdown,
        isResending,
      ];
}
