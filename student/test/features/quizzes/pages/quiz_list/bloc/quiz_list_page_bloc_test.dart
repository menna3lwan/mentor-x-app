import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_list/bloc/quiz_list_bloc.dart';

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
  late MockQuizRepository quizRepository;
  late _MockAnalyticsService analyticsService;

  setUp(() {
    quizRepository = const MockQuizRepository(delay: Duration.zero);
    analyticsService = _MockAnalyticsService();
  });

  group('QuizListBloc', () {
    test('initial state is correct', () {
      final bloc = QuizListBloc(
        quizRepository: quizRepository,
        analyticsService: analyticsService,
      );
      expect(bloc.state, QuizListState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizListBloc, QuizListState>(
      'emits [loading, loaded] when QuizListLoadEvent is added',
      build: () => QuizListBloc(
        quizRepository: quizRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const QuizListLoadEvent()),
      expect: () => [
        isA<QuizListState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizListState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
