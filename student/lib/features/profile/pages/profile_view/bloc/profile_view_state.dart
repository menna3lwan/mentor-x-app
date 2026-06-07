part of 'profile_view_bloc.dart';

final class ProfileViewState extends Equatable {
  final LoadingState loadingState;

  const ProfileViewState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = ProfileViewState();

  @override
  List<Object?> get props => [loadingState];

  ProfileViewState copyWith({LoadingState? loadingState}) {
    return ProfileViewState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
