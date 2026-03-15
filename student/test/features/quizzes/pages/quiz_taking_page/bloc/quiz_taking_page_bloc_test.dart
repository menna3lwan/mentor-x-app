import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_taking_page/bloc/quiz_taking_page_bloc.dart';

void main() {
  late MockQuizRepository quizRepository;

  setUp(() {
    quizRepository = const MockQuizRepository(delay: Duration.zero);
  });

  group('QuizTakingPageBloc', () {
    test('initial state is correct', () {
      final bloc = QuizTakingPageBloc(quizRepository: quizRepository);
      expect(bloc.state, QuizTakingPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizTakingPageBloc, QuizTakingPageState>(
      'emits [loading, loaded] when QuizTakingPageLoadEvent is added',
      build: () => QuizTakingPageBloc(quizRepository: quizRepository),
      act: (bloc) => bloc.add(const QuizTakingPageLoadEvent()),
      expect: () => [
        isA<QuizTakingPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizTakingPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
