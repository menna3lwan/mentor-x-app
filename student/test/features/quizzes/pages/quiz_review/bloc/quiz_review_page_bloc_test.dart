import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_review/bloc/quiz_review_bloc.dart';

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


void main() {
  late AnalyticsService analyticsService;
  late MockQuizRepository quizRepository;

  setUp(() {
    analyticsService = _MockAnalyticsService();
    quizRepository = const MockQuizRepository(delay: Duration.zero);
  });

  group('QuizReviewBloc', () {
    test('initial state is correct', () {
      final bloc = QuizReviewBloc(
        quizRepository: quizRepository,
        analyticsService: analyticsService,
        quizId: 'q1',
        attemptId: 'attempt_1',
      );
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizReviewBloc, QuizReviewState>(
      'emits [loading, loaded] when QuizReviewLoadEvent is added',
      build: () => QuizReviewBloc(
        quizRepository: quizRepository,
        analyticsService: analyticsService,
        quizId: 'q1',
        attemptId: 'attempt_1',
      ),
      act: (bloc) => bloc.add(const QuizReviewLoadEvent()),
      expect: () => [
        isA<QuizReviewState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizReviewState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
