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
      language: json['language'] as String? ?? 'en',
      theme: json['theme'] as String? ?? 'light',
      pushNotifications: json['pushNotifications'] ?? json['push_notifications'] ?? true,
      notificationPreferences: Map<String, bool>.from(
        json['notificationPreferences'] ?? json['notification_preferences'] ?? {},
      ),
      videoQualityDefault: json['videoQualityDefault']?.toString() ?? json['video_quality_default']?.toString(),
      playbackSpeedDefault: (json['playbackSpeedDefault'] ?? json['playback_speed_default'])?.toDouble(),
    );
  }
}
