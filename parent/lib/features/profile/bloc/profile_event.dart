part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => const [];
}

/// Pull-to-refresh / initial load.
final class ProfileLoadRequested extends ProfileEvent {
  const ProfileLoadRequested();
}

/// Called by the edit-screen wrapper when it opens — seeds [draftName] from
/// the cached profile in case the wrapper was previously cancelled.
final class ProfileEditStarted extends ProfileEvent {
  const ProfileEditStarted();
}

/// Reverts draft fields to the persisted profile (back button without save).
final class ProfileEditCancelled extends ProfileEvent {
  const ProfileEditCancelled();
}

/// User typed into the name field on the edit screen.
final class ProfileNameChanged extends ProfileEvent {
  final String name;
  const ProfileNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

/// User tapped "Save changes". Bloc validates draft fields, then PUTs.
final class ProfileSaveRequested extends ProfileEvent {
  const ProfileSaveRequested();
}

/// User picked an avatar — local filesystem path from `image_picker`.
final class ProfileAvatarSelected extends ProfileEvent {
  final String imagePath;
  const ProfileAvatarSelected(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}
