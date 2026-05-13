import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/account_status/pages/status_blocked_page/bloc/status_blocked_page_bloc.dart';

class MockAnalyticsService extends Mock implements AnalyticsService {}

void main() {
  group('StatusBlockedPageBloc', () {
    late AnalyticsService analyticsService;

    setUp(() {
      analyticsService = MockAnalyticsService();
    });

    test('initial state is correct', () {
      final bloc = StatusBlockedPageBloc(analyticsService: analyticsService);
      expect(bloc.state, StatusBlockedPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<StatusBlockedPageBloc, StatusBlockedPageState>(
      'emits loaded when initialized',
      build: () => StatusBlockedPageBloc(analyticsService: analyticsService),
      act: (bloc) => bloc.add(const StatusBlockedPageInitialized()),
      expect: () => [
        isA<StatusBlockedPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
