import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_intro_page/bloc/quiz_intro_page_bloc.dart';

class MockAnalyticsService extends Mock implements AnalyticsService {}


void main() {
  late AnalyticsService analyticsService;
  late MockQuizRepository quizRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    quizRepository = const MockQuizRepository(delay: Duration.zero);
  });

  group('QuizIntroPageBloc', () {
    test('initial state is correct', () {
      final bloc = QuizIntroPageBloc(quizRepository: quizRepository, analyticsService: analyticsService);
      expect(bloc.state, QuizIntroPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizIntroPageBloc, QuizIntroPageState>(
      'emits [loading, loaded] when QuizIntroPageLoadEvent is added',
      build: () => QuizIntroPageBloc(quizRepository: quizRepository, analyticsService: analyticsService),
      act: (bloc) => bloc.add(const QuizIntroPageLoadEvent()),
      expect: () => [
        isA<QuizIntroPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizIntroPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
