import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_taking/bloc/quiz_taking_bloc.dart';

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
  late MockQuizRepository quizRepository;
  late MockAnalyticsService analyticsService;
  const testId = 'quiz-123';

  setUp(() {
    quizRepository = const MockQuizRepository(delay: Duration.zero);
    analyticsService = MockAnalyticsService();

  });

  group('QuizTakingBloc', () {
    test('initial state is correct', () {
      final bloc = QuizTakingBloc(
        quizRepository: quizRepository,
        analyticsService: analyticsService,
        quizId: testId,
      );
      expect(bloc.state.quizId, testId);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizTakingBloc, QuizTakingState>(
      'emits [loading, loaded] when QuizTakingLoadEvent is added',
      build: () => QuizTakingBloc(
        quizRepository: quizRepository,
        analyticsService: analyticsService,
        quizId: testId,
      ),
      act: (bloc) => bloc.add(const QuizTakingLoadEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<QuizTakingState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizTakingState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
