import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/settings/pages/about/bloc/about_bloc.dart';

void main() {
  group('AboutBloc', () {
    test('initial state is correct', () {
      final bloc = AboutBloc();
      expect(bloc.state, AboutState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<AboutBloc, AboutState>(
      'emits [loading, loaded] when AboutLoadEvent is added',
      build: () => AboutBloc(),
      act: (bloc) => bloc.add(const AboutLoadEvent()),
      expect: () => [
        isA<AboutState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<AboutState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
