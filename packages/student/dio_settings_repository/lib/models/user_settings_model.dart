import 'package:mentorx_core/mentorx_core.dart';

final class UserSettingsModel extends UserSettingsEntity {
  const UserSettingsModel({
    super.language = 'en',
    super.theme = 'light',
    super.pushNotifications = true,
    super.notificationPreferences = const {},
    super.videoQualityDefault,
    super.playbackSpeedDefault,
  });

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsModel(
      language: ModelParser.asString(json['language'], fallback: 'en'),
      theme: ModelParser.asString(json['theme'], fallback: 'light'),
      pushNotifications: ModelParser.asBool(
        json['pushNotifications'] ?? json['push_notifications'],
        fallback: true,
      ),
      notificationPreferences:
          ModelParser.asMap(
            json['notificationPreferences'] ?? json['notification_preferences'],
          ).map(
            (k, v) => MapEntry(k, ModelParser.asBool(v)),
          ),
      videoQualityDefault: ModelParser.asString(
        json['videoQualityDefault'] ?? json['video_quality_default'],
      ),
      playbackSpeedDefault: ModelParser.asDouble(
        json['playbackSpeedDefault'] ?? json['playback_speed_default'],
      ),
    );
  }
}
