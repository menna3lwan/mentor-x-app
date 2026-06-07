import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_result/bloc/quiz_result_bloc.dart';

class _MockAnalyticsService implements AnalyticsService {
  @override
  Future<void> initialize() async {}
  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters}) async {}
  @override
  Future<void> setCurrentScreen({required String screenName, String? screenClassOverride}) async {}
  @override
  Future<void> setUserId(String? id) async {}
  @override
  Future<void> setUserProperty({required String name, required String? value}) async {}
  @override
  Future<void> resetAnalyticsData() async {}
}


class MockQuizRepo extends Mock implements QuizRepository {}

class MockLeaderboardRepo extends Mock implements LeaderboardRepository {}

void main() {
  late AnalyticsService analyticsService;
  setUpAll(() {
    registerFallbackValue('');
  });

  late MockQuizRepo quizRepository;
  late MockLeaderboardRepo leaderboardRepository;

  setUp(() {
    analyticsService = _MockAnalyticsService();
    quizRepository = MockQuizRepo();
    leaderboardRepository = MockLeaderboardRepo();
  });

  group('QuizResultBloc', () {
    test('initial state is correct', () {
      final bloc = QuizResultBloc(quizRepository: quizRepository,
        leaderboardRepository: leaderboardRepository,
        analyticsService: analyticsService,
      );
      expect(bloc.state, QuizResultState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizResultBloc, QuizResultState>(
      'emits [loading, loaded] when QuizResultLoadEvent is added',
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
        return QuizResultBloc(quizRepository: quizRepository,
          leaderboardRepository: leaderboardRepository,
        analyticsService: analyticsService,
      );
      },
      act: (bloc) => bloc.add(const QuizResultLoadEvent(attemptId: '1')),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<QuizResultState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizResultState>()
            .having((s) => s.loadingState, 'loadingState', LoadingState.loaded)
            .having((s) => s.result, 'result', isNotNull)
            .having((s) => s.myRank, 'myRank', isNotNull)
            .having((s) => s.leaderboard, 'leaderboard', isNotEmpty),
      ],
    );

    blocTest<QuizResultBloc, QuizResultState>(
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
        return QuizResultBloc(quizRepository: quizRepository,
          leaderboardRepository: leaderboardRepository,
        analyticsService: analyticsService,
      );
      },
      act: (bloc) => bloc.add(const QuizResultLoadEvent(attemptId: '1')),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<QuizResultState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizResultState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.error,
        ),
      ],
    );
  });
}
