part of 'profile_view_page_bloc.dart';

final class ProfileViewPageState extends Equatable {
  final LoadingState loadingState;

  const ProfileViewPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = ProfileViewPageState();

  @override
  List<Object?> get props => [loadingState];

  ProfileViewPageState copyWith({LoadingState? loadingState}) {
    return ProfileViewPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
