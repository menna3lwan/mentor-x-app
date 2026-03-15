part of '../../mentorx_core.dart';

enum SettingsRepositoryExceptionCode {
  unknown,
  failedToLoadSettings,
  failedToUpdateSettings,
}

final class SettingsRepositoryException
    extends MentorXException<SettingsRepositoryExceptionCode> {
  SettingsRepositoryException({required super.code, super.message});
}

abstract interface class SettingsRepository {
  /// Get the current user's settings.
  Future<UserSettingsEntity> getSettings();

  /// Update user settings.
  Future<UserSettingsEntity> updateSettings(UserSettingsEntity settings);
}
