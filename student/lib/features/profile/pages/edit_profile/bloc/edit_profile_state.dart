part of 'edit_profile_bloc.dart';

final class EditProfileState extends Equatable {
  final LoadingState loadingState;
  final String? errorMessage;

  const EditProfileState({
    this.loadingState = LoadingState.initial,
    this.errorMessage,
  });

  static const initial = EditProfileState();

  @override
  List<Object?> get props => [loadingState, errorMessage];

  EditProfileState copyWith({
    LoadingState? loadingState,
    MentorXNullableValue<String?>? errorMessage,
  }) {
    return EditProfileState(
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage != null
          ? errorMessage.value
          : this.errorMessage,
    );
  }
}
