import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_settings_repository/mock_settings_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/settings/pages/settings_list_page/bloc/settings_list_page_bloc.dart';

class MockAnalyticsService extends Mock implements AnalyticsService {}


void main() {
  late AnalyticsService analyticsService;
  late MockSettingsRepository settingsRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    settingsRepository = MockSettingsRepository(delay: Duration.zero);
  });

  group('SettingsListPageBloc', () {
    test('initial state is correct', () {
      final bloc = SettingsListPageBloc(settingsRepository: settingsRepository,
        analyticsService: analyticsService,
      );
      expect(bloc.state, SettingsListPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<SettingsListPageBloc, SettingsListPageState>(
      'emits [loading, loaded] when SettingsListPageLoadEvent is added',
      build: () => SettingsListPageBloc(settingsRepository: settingsRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const SettingsListPageLoadEvent()),
      expect: () => [
        isA<SettingsListPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<SettingsListPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
