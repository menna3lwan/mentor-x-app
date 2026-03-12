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

  const OtpState({
    required this.loadingState,
    this.exception,
  });

  static const initial = OtpState(
    loadingState: OtpLoadingState.initial,
  );

  OtpState copyWith({
    OtpLoadingState? loadingState,
    MentorXException? exception,
  }) {
    return OtpState(
      loadingState: loadingState ?? this.loadingState,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [loadingState, exception];
}
