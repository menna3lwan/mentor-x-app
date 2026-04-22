import 'package:mentorx_core/mentorx_core.dart';
import '../models/user_settings_model.dart';

final class DioSettingsRepository
    extends HttpClientRepository<SettingsRepositoryExceptionCode>
    implements SettingsRepository {
  @override
  Never throwException(SettingsRepositoryExceptionCode code,
          {String? message}) =>
      throw SettingsRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioSettingsRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<UserSettingsEntity> getSettings() async {
    try {
      final response = await httpClient.get('/api/student/settings');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return UserSettingsModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: SettingsRepositoryExceptionCode.failedToLoadSettings,
      );
    }
  }

  @override
  Future<UserSettingsEntity> updateSettings(
    UserSettingsEntity settings,
  ) async {
    try {
      final body = {
        'language': settings.language,
        'theme': settings.theme,
        'pushNotifications': settings.pushNotifications,
        'notificationPreferences': settings.notificationPreferences,
        if (settings.videoQualityDefault != null)
          'videoQualityDefault': settings.videoQualityDefault,
        if (settings.playbackSpeedDefault != null)
          'playbackSpeedDefault': settings.playbackSpeedDefault,
      };

      final response = await httpClient.patch(
        '/api/student/settings',
        data: body,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return UserSettingsModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: SettingsRepositoryExceptionCode.failedToUpdateSettings,
      );
    }
  }

}
