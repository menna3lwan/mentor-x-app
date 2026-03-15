part of 'login_page_bloc.dart';

final class LoginPageState extends Equatable {
  final String phoneNumber;
  final LoadingState loadingState;
  final String? errorMessage;

  const LoginPageState({
    required this.phoneNumber,
    required this.loadingState,
    this.errorMessage,
  });

  static const initial = LoginPageState(
    phoneNumber: '',
    loadingState: LoadingState.initial,
  );

  bool get isLoading => loadingState.isLoading;

  LoginPageState copyWith({
    String? phoneNumber,
    LoadingState? loadingState,
    String? errorMessage,
  }) {
    return LoginPageState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    phoneNumber,
    loadingState,
    errorMessage,
  ];
}
