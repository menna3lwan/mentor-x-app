part of 'profile_bloc.dart';

/// Minimal state — kept for backward compatibility. The active profile is
/// owned by `AppAuthenticationCubit`, not this bloc.
final class ProfileState extends Equatable {
  const ProfileState._();

  factory ProfileState.initial() = ProfileState._;

  @override
  List<Object?> get props => const [];
}
