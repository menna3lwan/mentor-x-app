import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/shell/pages/shell_page/bloc/shell_page_bloc.dart';

void main() {
  group('ShellPageBloc', () {
    test('initial state is correct', () {
      final bloc = ShellPageBloc();
      expect(bloc.state, ShellPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<ShellPageBloc, ShellPageState>(
      'emits [loading, loaded] when ShellPageLoadEvent is added',
      build: ShellPageBloc.new,
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
