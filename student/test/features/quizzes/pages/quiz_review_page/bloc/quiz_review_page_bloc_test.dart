import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_review_page/bloc/quiz_review_page_bloc.dart';

class MockAnalyticsService extends Mock implements AnalyticsService {}


void main() {
  late AnalyticsService analyticsService;
  late MockQuizRepository quizRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    quizRepository = const MockQuizRepository(delay: Duration.zero);
  });

  group('QuizReviewPageBloc', () {
    test('initial state is correct', () {
      final bloc = QuizReviewPageBloc(quizRepository: quizRepository, analyticsService: analyticsService);
      expect(bloc.state, QuizReviewPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizReviewPageBloc, QuizReviewPageState>(
      'emits [loading, loaded] when QuizReviewPageLoadEvent is added',
      build: () => QuizReviewPageBloc(quizRepository: quizRepository, analyticsService: analyticsService),
      act: (bloc) => bloc.add(const QuizReviewPageLoadEvent()),
      expect: () => [
        isA<QuizReviewPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizReviewPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
