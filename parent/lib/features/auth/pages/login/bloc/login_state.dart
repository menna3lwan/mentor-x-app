part of 'login_bloc.dart';

enum LoginLoadingState {
  initial,
  loading,
  success,
  failure
  ;

  bool get isLoading => this == LoginLoadingState.loading;
  bool get isSuccess => this == LoginLoadingState.success;
  bool get isFailure => this == LoginLoadingState.failure;
}

final class LoginState extends Equatable {
  final LoginLoadingState loadingState;
  final MentorXException? exception;

  const LoginState({
    required this.loadingState,
    this.exception,
  });

  static const initial = LoginState(
    loadingState: LoginLoadingState.initial,
  );

  LoginState copyWith({
    LoginLoadingState? loadingState,
    MentorXException? exception,
  }) {
    return LoginState(
      loadingState: loadingState ?? this.loadingState,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [loadingState, exception];
}
