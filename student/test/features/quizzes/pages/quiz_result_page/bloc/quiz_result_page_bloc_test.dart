import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_result_page/bloc/quiz_result_page_bloc.dart';

void main() {
  late MockQuizRepository quizRepository;

  setUp(() {
    quizRepository = const MockQuizRepository(delay: Duration.zero);
  });

  group('QuizResultPageBloc', () {
    test('initial state is correct', () {
      final bloc = QuizResultPageBloc(quizRepository: quizRepository);
      expect(bloc.state, QuizResultPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizResultPageBloc, QuizResultPageState>(
      'emits [loading, loaded] when QuizResultPageLoadEvent is added',
      build: () => QuizResultPageBloc(quizRepository: quizRepository),
      act: (bloc) => bloc.add(const QuizResultPageLoadEvent()),
      expect: () => [
        isA<QuizResultPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizResultPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
