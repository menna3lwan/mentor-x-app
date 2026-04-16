part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class ProfileStarted extends ProfileEvent {
  const ProfileStarted();
}

final class SettingsLanguageChanged extends ProfileEvent {
  final String languageCode;

  const SettingsLanguageChanged(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}

final class SettingsThemeChanged extends ProfileEvent {
  final String themeMode;

  const SettingsThemeChanged(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

final class SettingsPushToggleChanged extends ProfileEvent {
  final bool enabled;

  const SettingsPushToggleChanged(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

final class SettingsSaved extends ProfileEvent {
  const SettingsSaved();
}
