import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/account_status/pages/status_blocked/bloc/status_blocked_bloc.dart';

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
  group('StatusBlockedBloc', () {
    late AnalyticsService analyticsService;

    setUp(() {
      analyticsService = MockAnalyticsService();
    });

    test('initial state is correct', () {
      final bloc = StatusBlockedBloc(analyticsService: analyticsService);
      expect(bloc.state, StatusBlockedState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<StatusBlockedBloc, StatusBlockedState>(
      'emits loaded when initialized',
      build: () => StatusBlockedBloc(analyticsService: analyticsService),
      act: (bloc) => bloc.add(const StatusBlockedInitialized()),
      expect: () => [
        isA<StatusBlockedState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
