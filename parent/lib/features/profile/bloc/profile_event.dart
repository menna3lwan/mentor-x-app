part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileStarted extends ProfileEvent {}

class ProfileSettingsUpdated extends ProfileEvent {
  final Map<String, dynamic> settings;
  const ProfileSettingsUpdated(this.settings);

  @override
  List<Object?> get props => [settings];
}
