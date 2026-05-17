part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class ProfileStarted extends ProfileEvent {
  const ProfileStarted();
}

final class ProfileSettingsUpdated extends ProfileEvent {
  final Map<String, dynamic> settings;
  const ProfileSettingsUpdated(this.settings);

  @override
  List<Object?> get props => [settings];
}
