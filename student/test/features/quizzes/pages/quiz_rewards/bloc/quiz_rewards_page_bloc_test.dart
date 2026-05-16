import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';
import 'package:mock_leaderboard_repository/mock_leaderboard_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_rewards/bloc/quiz_rewards_page_bloc.dart';

class MockAnalyticsService implements AnalyticsService {
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


void main() {
  late AnalyticsService analyticsService;
  late MockQuizRepository quizRepository;
  late MockLeaderboardRepository leaderboardRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    quizRepository = const MockQuizRepository(delay: Duration.zero);
    leaderboardRepository = MockLeaderboardRepository(delay: Duration.zero);
  });

  group('QuizRewardsPageBloc', () {
    test('initial state is correct', () {
      final bloc = QuizRewardsPageBloc(quizRepository: quizRepository,
        leaderboardRepository: leaderboardRepository,
        analyticsService: analyticsService,
      );
      expect(bloc.state, QuizRewardsPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizRewardsPageBloc, QuizRewardsPageState>(
      'emits [loading, loaded] when QuizRewardsPageLoadEvent is added',
      build: () => QuizRewardsPageBloc(quizRepository: quizRepository,
        leaderboardRepository: leaderboardRepository,
        analyticsService: analyticsService,
      ),
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
