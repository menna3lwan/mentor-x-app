part of '../../mock_data.dart';

final class MockSettingsGenerator {
  MockSettingsGenerator._();

  static UserSettingsEntity settings() {
    return const UserSettingsEntity(
      language: 'ar',
      theme: 'system',
      pushNotifications: true,
      videoQualityDefault: '720p',
      playbackSpeedDefault: 1.0,
    );
  }
}
