import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio_quiz_repository/src/dio_quiz_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late DioQuizRepository repository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = DioQuizRepository(httpClient: mockHttpClient);
  });

  group('DioQuizRepository', () {
    test('startQuiz returns attempt and questions on success', () async {
      final mockResponse = {
        'data': {
          'attempt': {
            'id': 'a1',
            'quizId': '1',
            'attemptNumber': 1,
            'status': 'inProgress',
            'score': 0,
            'totalMarks': 10,
            'percentage': 0.0,
            'passed': false,
            'startedAt': DateTime.now().toIso8601String(),
          },
          'questions': [
            {
              'id': 'q1',
              'questionType': 'mcqSingle',
              'questionText': 'What is Flutter?',
              'options': ['A', 'B', 'C'],
              'marks': 1,
            }
          ]
        }
      };

      when(() => mockHttpClient.post('/api/quizzes/1/start'))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.startQuiz('1');

      expect(result.attempt.id, 'a1');
      expect(result.questions.length, 1);
      expect(result.questions.first.questionText, 'What is Flutter?');
    });

    test('submitQuiz returns attempt entity on success', () async {
      final mockResponse = {
        'data': {
          'id': 'a1',
          'quizId': '1',
          'attemptNumber': 1,
          'status': 'submitted',
          'score': 8,
          'totalMarks': 10,
          'percentage': 80.0,
          'passed': true,
          'startedAt': DateTime.now().toIso8601String(),
          'submittedAt': DateTime.now().toIso8601String(),
        }
      };

      when(() => mockHttpClient.post('/api/quiz-attempts/a1/submit'))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.submitQuiz('a1');

      expect(result.id, 'a1');
      expect(result.score, 8);
      expect(result.passed, true);
    });
  });
}
