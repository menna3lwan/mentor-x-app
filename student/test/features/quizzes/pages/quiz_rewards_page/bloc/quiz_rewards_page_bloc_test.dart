import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_rewards_page/bloc/quiz_rewards_page_bloc.dart';

void main() {
  late MockQuizRepository quizRepository;

  setUp(() {
    quizRepository = const MockQuizRepository(delay: Duration.zero);
  });

  group('QuizRewardsPageBloc', () {
    test('initial state is correct', () {
      final bloc = QuizRewardsPageBloc(quizRepository: quizRepository);
      expect(bloc.state, QuizRewardsPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizRewardsPageBloc, QuizRewardsPageState>(
      'emits [loading, loaded] when QuizRewardsPageLoadEvent is added',
      build: () => QuizRewardsPageBloc(quizRepository: quizRepository),
      act: (bloc) => bloc.add(const QuizRewardsPageLoadEvent()),
      expect: () => [
        isA<QuizRewardsPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizRewardsPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
