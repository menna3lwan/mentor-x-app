part of 'login_page_bloc.dart';

enum LoginPageStatus { initial, loading, success, failure }

final class LoginPageState extends Equatable {
  final String phoneNumber;
  final LoginPageStatus status;
  final String? errorMessage;
  final int? otpLength;
  final Duration? otpDuration;

  const LoginPageState({
    this.phoneNumber = '',
    this.status = LoginPageStatus.initial,
    this.errorMessage,
    this.otpLength,
    this.otpDuration,
  });

  bool get isLoading => status == LoginPageStatus.loading;
  bool get isSuccess => status == LoginPageStatus.success;
  bool get isFailure => status == LoginPageStatus.failure;

  LoginPageState copyWith({
    String? phoneNumber,
    LoginPageStatus? status,
    String? errorMessage,
    int? otpLength,
    Duration? otpDuration,
  }) {
    return LoginPageState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      errorMessage: errorMessage,
      otpLength: otpLength ?? this.otpLength,
      otpDuration: otpDuration ?? this.otpDuration,
    );
  }

  @override
  List<Object?> get props => [
    phoneNumber,
    status,
    errorMessage,
    otpLength,
    otpDuration,
  ];
}
