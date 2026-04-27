part of 'edit_profile_page_bloc.dart';

final class EditProfilePageState extends Equatable {
  final LoadingState loadingState;
  final String? errorMessage;

  const EditProfilePageState({
    this.loadingState = LoadingState.initial,
    this.errorMessage,
  });

  static const initial = EditProfilePageState();

  @override
  List<Object?> get props => [loadingState, errorMessage];

  EditProfilePageState copyWith({
    LoadingState? loadingState,
    MentorXNullableValue<String?>? errorMessage,
  }) {
    return EditProfilePageState(
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
    );
  }
}
