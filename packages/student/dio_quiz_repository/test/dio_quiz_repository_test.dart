import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_quiz_repository/dio_quiz_repository.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioQuizRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioQuizRepository(httpClient: httpClient);
    registerFallbackValue(<String, dynamic>{});
  });

  group('DioQuizRepository', () {
    group('startQuiz', () {
      test('returns attempt and questions on success', () async {
        final mockData = {
          'attempt': {
            'id': 'a1',
            'status': 'inProgress',
            'quiz_id': 'q1',
            'started_at': DateTime.now().toIso8601String(),
          },
          'questions': [
            {
              'id': 'q1',
              'question_text': 'Question 1',
              'question_type': 'multipleChoice',
              'marks': 10,
              'options': [
                'Option 1',
                'Option 2',
              ],
            }
          ]
        };

        when(() => httpClient.post('/api/quizzes/q1/start')).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.startQuiz('q1');
        expect(result.attempt.id, 'a1');
        expect(result.questions.length, 1);
        expect(result.questions[0].questionText, 'Question 1');
      });
    });

    group('submitQuiz', () {
      test('returns QuizAttemptEntity on success', () async {
        final mockData = {
          'id': 'a1',
          'status': 'submitted',
          'score': 85.0,
          'quiz_id': 'q1',
          'started_at': DateTime.now().toIso8601String(),
        };

        when(() => httpClient.post('/api/quiz-attempts/a1/submit')).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.submitQuiz('a1');
        expect(result.id, 'a1');
        expect(result.status, QuizAttemptStatus.submitted);
      });
    });

    group('getResults', () {
      test('returns QuizAttemptEntity on success', () async {
        final mockData = {
          'id': 'a1',
          'status': 'submitted',
          'score': 90.0,
          'quiz_id': 'q1',
          'started_at': DateTime.now().toIso8601String(),
        };

        when(() => httpClient.get('/api/quiz-attempts/a1')).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getResults('a1');
        expect(result.id, 'a1');
        expect(result.score, 90.0);
      });
    });
  });
}
