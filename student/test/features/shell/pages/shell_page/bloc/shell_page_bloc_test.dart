import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/shell/pages/shell_page/bloc/shell_page_bloc.dart';

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

  setUp(() {
    analyticsService = MockAnalyticsService();
  });
  group('ShellPageBloc', () {
    test('initial state is correct', () {
      final bloc = ShellPageBloc(analyticsService: analyticsService);
      expect(bloc.state, ShellPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<ShellPageBloc, ShellPageState>(
      'emits [loading, loaded] when ShellPageLoadEvent is added',
      build: () => ShellPageBloc(analyticsService: analyticsService),
      act: (bloc) => bloc.add(const ShellPageLoadEvent()),
      expect: () => [
        isA<ShellPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<ShellPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
