import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_list_page/bloc/quiz_list_page_bloc.dart';

void main() {
  late MockQuizRepository quizRepository;

  setUp(() {
    quizRepository = const MockQuizRepository(delay: Duration.zero);
  });

  group('QuizListPageBloc', () {
    test('initial state is correct', () {
      final bloc = QuizListPageBloc(quizRepository: quizRepository);
      expect(bloc.state, QuizListPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizListPageBloc, QuizListPageState>(
      'emits [loading, loaded] when QuizListPageLoadEvent is added',
      build: () => QuizListPageBloc(quizRepository: quizRepository),
      act: (bloc) => bloc.add(const QuizListPageLoadEvent()),
      expect: () => [
        isA<QuizListPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizListPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
