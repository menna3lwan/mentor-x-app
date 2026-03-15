import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/settings/pages/support_page/bloc/support_page_bloc.dart';

void main() {
  group('SupportPageBloc', () {
    test('initial state is correct', () {
      final bloc = SupportPageBloc();
      expect(bloc.state, SupportPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<SupportPageBloc, SupportPageState>(
      'emits [loading, loaded] when SupportPageLoadEvent is added',
      build: () => SupportPageBloc(),
      act: (bloc) => bloc.add(const SupportPageLoadEvent()),
      expect: () => [
        isA<SupportPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<SupportPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
