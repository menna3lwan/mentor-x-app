part of 'edit_profile_page_bloc.dart';

final class EditProfilePageState extends Equatable {
  final LoadingState loadingState;

  const EditProfilePageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = EditProfilePageState();

  @override
  List<Object?> get props => [loadingState];

  EditProfilePageState copyWith({LoadingState? loadingState}) {
    return EditProfilePageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
