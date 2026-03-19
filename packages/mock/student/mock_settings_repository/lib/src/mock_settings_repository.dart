import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockSettingsRepository implements SettingsRepository {
  final Duration delay;

  MockSettingsRepository({required this.delay});

  @override
  Future<void> initialize() async {}

  UserSettingsEntity _currentSettings = MockSettingsGenerator.settings();

  @override
  Future<UserSettingsEntity> getSettings() async {
    await Future<void>.delayed(delay);
    return _currentSettings;
  }

  @override
  Future<UserSettingsEntity> updateSettings(
    UserSettingsEntity settings,
  ) async {
    await Future<void>.delayed(delay);
    _currentSettings = settings;
    return _currentSettings;
  }
}
