part of 'reset_password_bloc.dart';

final class ResetPasswordState extends Equatable {
  final String phoneNumber;
  final String otp;
  final String newPassword;
  final String confirmPassword;
  final LoadingState loadingState;
  final String? errorMessage;

  const ResetPasswordState({
    required this.phoneNumber,
    this.otp = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.loadingState = LoadingState.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    phoneNumber,
    otp,
    newPassword,
    confirmPassword,
    loadingState,
    errorMessage,
  ];

  ResetPasswordState copyWith({
    String? otp,
    String? newPassword,
    String? confirmPassword,
    LoadingState? loadingState,
    MentorXNullableValue<String?>? errorMessage,
  }) {
    return ResetPasswordState(
      phoneNumber: phoneNumber,
      otp: otp ?? this.otp,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage != null
          ? errorMessage.value
          : this.errorMessage,
    );
  }
}
