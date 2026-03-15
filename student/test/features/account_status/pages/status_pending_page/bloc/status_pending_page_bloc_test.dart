import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/account_status/pages/status_pending_page/bloc/status_pending_page_bloc.dart';

void main() {
  group('StatusPendingPageBloc', () {
    test('initial state is correct', () {
      final bloc = StatusPendingPageBloc();
      expect(bloc.state, StatusPendingPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<StatusPendingPageBloc, StatusPendingPageState>(
      'emits loaded when initialized',
      build: StatusPendingPageBloc.new,
      act: (bloc) => bloc.add(const StatusPendingPageInitialized()),
      expect: () => [
        isA<StatusPendingPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
