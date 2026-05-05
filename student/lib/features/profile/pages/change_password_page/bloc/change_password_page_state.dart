part of 'change_password_page_bloc.dart';

final class ChangePasswordPageState extends Equatable {
  final LoadingState loadingState;
  final String? errorMessage;

  const ChangePasswordPageState({
    this.loadingState = LoadingState.initial,
    this.errorMessage,
  });

  static const initial = ChangePasswordPageState();

  @override
  List<Object?> get props => [loadingState, errorMessage];

  ChangePasswordPageState copyWith({
    LoadingState? loadingState,
    MentorXNullableValue<String?>? errorMessage,
  }) {
    return ChangePasswordPageState(
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage != null
          ? errorMessage.value
          : this.errorMessage,
    );
  }
}
