part of 'change_password_bloc.dart';

final class ChangePasswordState extends Equatable {
  final LoadingState loadingState;
  final String? errorMessage;

  const ChangePasswordState({
    this.loadingState = LoadingState.initial,
    this.errorMessage,
  });

  static const initial = ChangePasswordState();

  @override
  List<Object?> get props => [loadingState, errorMessage];

  ChangePasswordState copyWith({
    LoadingState? loadingState,
    MentorXNullableValue<String?>? errorMessage,
  }) {
    return ChangePasswordState(
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage != null
          ? errorMessage.value
          : this.errorMessage,
    );
  }
}
