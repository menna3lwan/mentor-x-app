part of 'forget_password_bloc.dart';

enum ForgetPasswordLoadingState {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == ForgetPasswordLoadingState.loading;
  bool get isSuccess => this == ForgetPasswordLoadingState.success;
  bool get isFailure => this == ForgetPasswordLoadingState.failure;
}

final class ForgetPasswordState extends Equatable {
  final ForgetPasswordLoadingState loadingState;
  final MentorXException? exception;

  const ForgetPasswordState({
    required this.loadingState,
    this.exception,
  });

  static const initial = ForgetPasswordState(
    loadingState: ForgetPasswordLoadingState.initial,
  );

  ForgetPasswordState copyWith({
    ForgetPasswordLoadingState? loadingState,
    MentorXException? exception,
  }) =>
      ForgetPasswordState(
        loadingState: loadingState ?? this.loadingState,
        exception: exception ?? this.exception,
      );

  @override
  List<Object?> get props => [loadingState, exception];
}
