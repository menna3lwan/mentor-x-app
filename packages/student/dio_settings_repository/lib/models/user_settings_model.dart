import 'package:mentorx_core/mentorx_core.dart';

abstract final class UserSettingsModel {
  static UserSettingsEntity fromJson(Map<String, dynamic> json) {
    Map<String, bool> prefs = {};
    final rawPrefs = json['notificationPreferences'] ?? json['notification_preferences'];
    if (rawPrefs is Map) {
      prefs = rawPrefs.map((k, v) => MapEntry(k.toString(), v as bool? ?? true));
    }
    return UserSettingsEntity(
      language: json['language'] as String? ?? 'ar',
      theme: json['theme'] as String? ?? 'system',
      pushNotifications: json['pushNotifications'] as bool? ??
          json['push_notifications'] as bool? ??
          true,
      notificationPreferences: prefs,
      videoQualityDefault: json['videoQualityDefault'] as String? ??
          json['video_quality_default'] as String?,
      playbackSpeedDefault:
          (json['playbackSpeedDefault'] ?? json['playback_speed_default'] as num?)
              ?.toDouble(),
    );
  }
}
