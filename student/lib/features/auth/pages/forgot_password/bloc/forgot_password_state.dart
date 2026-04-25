part of 'forgot_password_bloc.dart';

final class ForgotPasswordState extends Equatable {
  final String phone;
  final LoadingState loadingState;
  final String? errorMessage;

  const ForgotPasswordState({
    this.phone = '',
    this.loadingState = LoadingState.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [phone, loadingState, errorMessage];

  ForgotPasswordState copyWith({
    String? phone,
    LoadingState? loadingState,
    MentorXNullableValue<String?>? errorMessage,
  }) {
    return ForgotPasswordState(
      phone: phone ?? this.phone,
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
    );
  }
}
