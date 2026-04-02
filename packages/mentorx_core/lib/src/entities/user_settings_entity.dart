part of '../../mentorx_core.dart';

base class UserSettingsEntity extends Equatable {
  final String language;
  final String theme;
  final bool pushNotifications;
  final Map<String, bool> notificationPreferences;
  final String? videoQualityDefault;
  final double? playbackSpeedDefault;

  const UserSettingsEntity({
    this.language = 'ar',
    this.theme = 'system',
    this.pushNotifications = true,
    this.notificationPreferences = const {},
    this.videoQualityDefault,
    this.playbackSpeedDefault,
  });

  static const placeholder = UserSettingsEntity();

  @override
  List<Object?> get props => [
    language,
    theme,
    pushNotifications,
    notificationPreferences,
    videoQualityDefault,
    playbackSpeedDefault,
  ];
}
