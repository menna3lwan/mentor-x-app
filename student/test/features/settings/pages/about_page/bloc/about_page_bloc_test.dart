import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/settings/pages/about_page/bloc/about_page_bloc.dart';

void main() {
  group('AboutPageBloc', () {
    test('initial state is correct', () {
      final bloc = AboutPageBloc();
      expect(bloc.state, AboutPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<AboutPageBloc, AboutPageState>(
      'emits [loading, loaded] when AboutPageLoadEvent is added',
      build: () => AboutPageBloc(),
      act: (bloc) => bloc.add(const AboutPageLoadEvent()),
      expect: () => [
        isA<AboutPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<AboutPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
