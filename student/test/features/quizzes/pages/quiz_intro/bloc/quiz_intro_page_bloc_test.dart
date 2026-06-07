import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_quiz_repository/mock_quiz_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/quizzes/pages/quiz_intro/bloc/quiz_intro_bloc.dart';

class _MockProfileRepository extends Mock implements ProfileRepository {}

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
  late _MockProfileRepository profileRepository;
  late _MockAnalyticsService analyticsService;
  const testId = 'quiz-123';

  setUp(() {
    quizRepository = const MockQuizRepository(delay: Duration.zero);
    profileRepository = _MockProfileRepository();
    analyticsService = _MockAnalyticsService();

    when(() => profileRepository.getProfile()).thenAnswer(
      (_) async => StudentEntity(
        id: '1',
        firstName: 'Test',
        lastName: 'Student',
        phoneNumber: '01000000000',
        studentCode: 'ST-001',
        status: StudentStatus.active,
        createdAt: DateTime(2025),
        updatedAt: DateTime(2025),
      ),
    );
  });

  group('QuizIntroBloc', () {
    test('initial state is correct', () {
      final bloc = QuizIntroBloc(
        quizRepository: quizRepository,
        profileRepository: profileRepository,
        analyticsService: analyticsService,
        quizId: testId,
      );
      expect(bloc.state.quizId, testId);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<QuizIntroBloc, QuizIntroState>(
      'emits [loading, loaded] when QuizIntroLoadEvent is added',
      build: () => QuizIntroBloc(
        quizRepository: quizRepository,
        profileRepository: profileRepository,
        analyticsService: analyticsService,
        quizId: testId,
      ),
      act: (bloc) => bloc.add(const QuizIntroLoadEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<QuizIntroState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<QuizIntroState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
