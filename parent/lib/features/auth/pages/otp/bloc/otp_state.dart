part of 'otp_bloc.dart';

enum OtpLoadingState {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == OtpLoadingState.loading;
  bool get isSuccess => this == OtpLoadingState.success;
  bool get isFailure => this == OtpLoadingState.failure;
}

final class OtpState extends Equatable {
  final OtpLoadingState loadingState;
  final MentorXException? exception;
  final int resendCountdown;
  final bool isResending;

  const OtpState({
    required this.loadingState,
    this.exception,
    this.resendCountdown = 60,
    this.isResending = false,
  });

  static const initial = OtpState(
    loadingState: OtpLoadingState.initial,
  );

  bool get canResend => resendCountdown <= 0 && !isResending;

  String get formattedCountdown {
    final minutes = resendCountdown ~/ 60;
    final seconds = resendCountdown % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  OtpState copyWith({
    OtpLoadingState? loadingState,
    MentorXException? exception,
    int? resendCountdown,
    bool? isResending,
  }) {
    return OtpState(
      loadingState: loadingState ?? this.loadingState,
      exception: exception ?? this.exception,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      isResending: isResending ?? this.isResending,
    );
  }

  @override
  List<Object?> get props => [
    loadingState,
    exception,
    resendCountdown,
    isResending,
  ];
}
