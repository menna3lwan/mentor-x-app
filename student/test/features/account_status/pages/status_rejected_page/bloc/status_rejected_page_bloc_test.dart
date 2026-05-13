import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/account_status/pages/status_rejected_page/bloc/status_rejected_page_bloc.dart';

class MockAnalyticsService extends Mock implements AnalyticsService {}

void main() {
  group('StatusRejectedPageBloc', () {
    late AnalyticsService analyticsService;

    setUp(() {
      analyticsService = MockAnalyticsService();
    });

    test('initial state is correct', () {
      final bloc = StatusRejectedPageBloc(analyticsService: analyticsService);
      expect(bloc.state, StatusRejectedPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<StatusRejectedPageBloc, StatusRejectedPageState>(
      'emits loaded when initialized',
      build: () => StatusRejectedPageBloc(analyticsService: analyticsService),
      act: (bloc) => bloc.add(const StatusRejectedPageInitialized()),
      expect: () => [
        isA<StatusRejectedPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
