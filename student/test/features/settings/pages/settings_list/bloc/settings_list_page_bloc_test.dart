import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_settings_repository/mock_settings_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/settings/pages/settings_list/bloc/settings_list_bloc.dart';

class MockAnalyticsService implements AnalyticsService {
  @override
  Future<void> initialize() async {}
  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters}) async {}
  @override
  Future<void> setCurrentScreen({required String screenName, String? screenClassOverride}) async {}
  @override
  Future<void> setUserId(String? id) async {}
  @override
  Future<void> setUserProperty({required String name, required String? value}) async {}
  @override
  Future<void> resetAnalyticsData() async {}
}


void main() {
  late AnalyticsService analyticsService;
  late MockSettingsRepository settingsRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    settingsRepository = MockSettingsRepository(delay: Duration.zero);
  });

  group('SettingsListBloc', () {
    test('initial state is correct', () {
      final bloc = SettingsListBloc(settingsRepository: settingsRepository,
        analyticsService: analyticsService,
      );
      expect(bloc.state, SettingsListState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<SettingsListBloc, SettingsListState>(
      'emits [loading, loaded] when SettingsListLoadEvent is added',
      build: () => SettingsListBloc(settingsRepository: settingsRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const SettingsListLoadEvent()),
      expect: () => [
        isA<SettingsListState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<SettingsListState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
