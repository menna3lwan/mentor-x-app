part of 'package:mentorx_core/mentorx_core.dart';

class UserSettingsEntity extends Equatable {
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

  UserSettingsEntity copyWith({
    String? language,
    String? theme,
    bool? pushNotifications,
    Map<String, bool>? notificationPreferences,
    String? videoQualityDefault,
    double? playbackSpeedDefault,
  }) {
    return UserSettingsEntity(
      language: language ?? this.language,
      theme: theme ?? this.theme,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      notificationPreferences:
          notificationPreferences ?? this.notificationPreferences,
      videoQualityDefault: videoQualityDefault ?? this.videoQualityDefault,
      playbackSpeedDefault: playbackSpeedDefault ?? this.playbackSpeedDefault,
    );
  }
}
