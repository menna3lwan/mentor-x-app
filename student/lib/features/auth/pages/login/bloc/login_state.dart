part of 'login_bloc.dart';

final class LoginState extends Equatable {
  final String phoneNumber;
  final String password;
  final bool obscurePassword;
  final LoadingState loadingState;
  final String? errorMessage;

  const LoginState({
    required this.phoneNumber,
    required this.password,
    required this.obscurePassword,
    required this.loadingState,
    this.errorMessage,
  });

  static const initial = LoginState(
    phoneNumber: '',
    password: '',
    obscurePassword: true,
    loadingState: LoadingState.initial,
  );

  bool get isLoading => loadingState.isLoading;

  LoginState copyWith({
    String? phoneNumber,
    String? password,
    bool? obscurePassword,
    LoadingState? loadingState,
    String? errorMessage,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    phoneNumber,
    password,
    obscurePassword,
    loadingState,
    errorMessage,
  ];
}
