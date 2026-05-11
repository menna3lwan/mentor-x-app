import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_result_page/bloc/quiz_result_page_bloc.dart';

class MockQuizRepo extends Mock implements QuizRepository {}

class MockLeaderboardRepo extends Mock implements LeaderboardRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue('');
  });

  late MockQuizRepo quizRepository;
  late MockLeaderboardRepo leaderboardRepository;

  setUp(() {
    quizRepository = MockQuizRepo();
    leaderboardRepository = MockLeaderboardRepo();
  });

  group('QuizResultPageBloc', () {
    test('initial state is correct', () {
      final bloc = QuizResultPageBloc(
        quizRepository: quizRepository,
        leaderboardRepository: leaderboardRepository,
      );
      expect(bloc.state, QuizResultPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizResultPageBloc, QuizResultPageState>(
      'emits [loading, loaded] when QuizResultPageLoadEvent is added',
      build: () {
        final attempt = QuizAttemptEntity(
          id: '1',
          quizId: 'q1',
          attemptNumber: 1,
          status: QuizAttemptStatus.submitted,
          score: 80,
          totalMarks: 100,
          percentage: 80.0,
          passed: true,
          startedAt: DateTime.now(),
        );
        final entry = const LeaderboardEntryEntity(
          rank: 1,
          studentId: 's1',
          studentName: 'Student 1',
          points: 100,
          score: 100,
          quizCount: 1,
        );
        when(
          () => quizRepository.getResults(any()),
        ).thenAnswer((_) async => attempt);
        when(
          () => leaderboardRepository.getMyQuizRank(any()),
        ).thenAnswer((_) async => entry);
        when(
          () => leaderboardRepository.getQuizLeaderboard(any()),
        ).thenAnswer((_) async => [entry]);
        return QuizResultPageBloc(
          quizRepository: quizRepository,
          leaderboardRepository: leaderboardRepository,
        );
      },
      act: (bloc) => bloc.add(const QuizResultPageLoadEvent(attemptId: '1')),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<QuizResultPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizResultPageState>()
            .having((s) => s.loadingState, 'loadingState', LoadingState.loaded)
            .having((s) => s.result, 'result', isNotNull)
            .having((s) => s.myRank, 'myRank', isNotNull)
            .having((s) => s.leaderboard, 'leaderboard', isNotEmpty),
      ],
    );

    blocTest<QuizResultPageBloc, QuizResultPageState>(
      'emits [loading, error] when leaderboard fetching fails',
      build: () {
        final attempt = QuizAttemptEntity(
          id: '1',
          quizId: 'q1',
          attemptNumber: 1,
          status: QuizAttemptStatus.submitted,
          score: 80,
          totalMarks: 100,
          percentage: 80.0,
          passed: true,
          startedAt: DateTime.now(),
        );
        when(
          () => quizRepository.getResults(any()),
        ).thenAnswer((_) async => attempt);
        when(
          () => leaderboardRepository.getMyQuizRank(any()),
        ).thenThrow(Exception('Leaderboard Error'));
        when(
          () => leaderboardRepository.getQuizLeaderboard(any()),
        ).thenAnswer((_) async => []);
        return QuizResultPageBloc(
          quizRepository: quizRepository,
          leaderboardRepository: leaderboardRepository,
        );
      },
      act: (bloc) => bloc.add(const QuizResultPageLoadEvent(attemptId: '1')),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<QuizResultPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizResultPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.error,
        ),
      ],
    );
  });
}
