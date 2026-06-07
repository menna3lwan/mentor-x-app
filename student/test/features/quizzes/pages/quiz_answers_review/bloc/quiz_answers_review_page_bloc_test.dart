import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_answers_review/bloc/quiz_answers_review_bloc.dart';

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

  setUp(() {
    analyticsService = MockAnalyticsService();
    quizRepository = const MockQuizRepository(delay: Duration.zero);
  });

  group('QuizAnswersReviewBloc', () {
    test('initial state is correct', () {
      final bloc = QuizAnswersReviewBloc(quizRepository: quizRepository, analyticsService: analyticsService);
      expect(bloc.state, QuizAnswersReviewState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizAnswersReviewBloc, QuizAnswersReviewState>(
      'emits [loading, loaded] when QuizAnswersReviewLoadEvent is added',
      build: () => QuizAnswersReviewBloc(quizRepository: quizRepository, analyticsService: analyticsService),
      act: (bloc) => bloc.add(const QuizAnswersReviewLoadEvent()),
      expect: () => [
        isA<QuizAnswersReviewState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizAnswersReviewState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
