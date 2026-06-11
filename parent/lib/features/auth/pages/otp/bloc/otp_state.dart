part of 'otp_bloc.dart';

enum OtpLoadingState {
  initial,
  loading,
  success,
  failure
  ;

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

  // Sentinel used by [copyWith] to distinguish "caller passed null to clear
  // the exception" from "caller didn't mention exception at all".
  static const _absent = Object();

  OtpState copyWith({
    OtpLoadingState? loadingState,
    Object? exception = _absent,
    int? resendCountdown,
    bool? isResending,
  }) {
    return OtpState(
      loadingState: loadingState ?? this.loadingState,
      exception: identical(exception, _absent)
          ? this.exception
          : exception as MentorXException?,
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
