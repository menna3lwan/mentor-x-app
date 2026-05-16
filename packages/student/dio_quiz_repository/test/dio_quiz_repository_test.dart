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
    group('getQuiz', () {
      test('returns QuizEntity on success', () async {
        final mockData = {
          'id': 'q1',
          'title': 'Test Quiz',
          'duration_minutes': 30,
          'total_marks': 100,
          'questions': [
            {
              'id': 'q1',
              'text': 'Question 1',
              'type': 'multipleChoice',
              'mark': 10,
              'options': [
                'Option 1',
                'Option 2',
              ],
            },
          ],
        };

        when(() => httpClient.get('/api/quizzes/q1')).thenAnswer(
          (_) async => HttpClientResponse(
            data: {'data': mockData},
            statusCode: 200,
          ),
        );

        final result = await repository.getQuiz('q1');
        expect(result.id, 'q1');
        expect(result.questions.length, 1);
        expect(result.questions[0].description, 'Question 1');
      });
    });

    group('submitQuiz', () {
      test('returns QuizAttemptEntity on success', () async {
        final mockData = {
          'id': 'a1',
          'status': 'submitted',
          'score': 85,
          'total_marks': 100,
          'quiz_id': 'q1',
          'started_at': DateTime.now().toIso8601String(),
        };

        when(
          () => httpClient.post(
            '/api/quizzes/q1/submit',
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => HttpClientResponse(
            data: {'data': mockData},
            statusCode: 200,
          ),
        );

        final result = await repository.submitQuiz(
          'q1',
          answers: {'q1': 'Option 1'},
        );
        expect(result.id, 'a1');
        expect(result.status, QuizAttemptStatus.submitted);
      });
    });

    group('getResults', () {
      test('returns QuizAttemptEntity on success', () async {
        final mockData = {
          'id': 'a1',
          'status': 'submitted',
          'score': 90,
          'total_marks': 100,
          'quiz_id': 'q1',
          'started_at': DateTime.now().toIso8601String(),
        };

        when(() => httpClient.get('/api/quiz-attempts/a1/results')).thenAnswer(
          (_) async => HttpClientResponse(
            data: {'data': mockData},
            statusCode: 200,
          ),
        );

        final result = await repository.getResults('a1');
        expect(result.id, 'a1');
        expect(result.score, 90.0);
      });
    });

    group('getQuizzes', () {
      test('returns List<QuizEntity> on success', () async {
        final mockData = [
          {
            'id': 'q1',
            'title': 'Quiz 1',
            'duration_minutes': 30,
            'total_marks': 100,
          },
          {
            'id': 'q2',
            'title': 'Quiz 2',
            'duration_minutes': 45,
            'total_marks': 100,
          },
        ];

        when(() => httpClient.get('/api/quizzes')).thenAnswer(
          (_) async => HttpClientResponse(
            data: {'data': mockData},
            statusCode: 200,
          ),
        );

        final result = await repository.getQuizzes();
        expect(result.length, 2);
        expect(result[0].id, 'q1');
        expect(result[1].id, 'q2');
      });
    });

    group('getQuizQuestions', () {
      test('returns List<QuizQuestionEntity> on success', () async {
        final mockData = [
          {
            'id': 'qq1',
            'text': 'Question 1',
            'type': 'multipleChoice',
          },
          {
            'id': 'qq2',
            'text': 'Question 2',
            'type': 'trueFalse',
          },
        ];

        when(() => httpClient.get('/api/questions/quiz/q1')).thenAnswer(
          (_) async => HttpClientResponse(
            data: {'data': mockData},
            statusCode: 200,
          ),
        );

        final result = await repository.getQuizQuestions('q1');
        expect(result.length, 2);
        expect(result[0].id, 'qq1');
        expect(result[1].type, QuizQuestionType.trueFalse);
      });
    });

    group('startQuiz', () {
      test('returns attempt and questions on success', () async {
        final mockData = {
          'attempt': {
            'id': 'a1',
            'quiz_id': 'q1',
            'status': 'in_progress',
            'started_at': DateTime.now().toIso8601String(),
            'attempt_number': 1,
            'score': 0,
            'total_marks': 100,
            'percentage': 0,
            'passed': false,
          },
          'questions': [
            {'id': 'qq1', 'text': 'Q1', 'type': 'mcq'},
          ],
        };

        when(() => httpClient.post('/api/quizzes/q1/start')).thenAnswer(
          (_) async => HttpClientResponse(
            data: {'data': mockData},
            statusCode: 200,
          ),
        );

        final (attempt, questions) = await repository.startQuiz('q1');
        expect(attempt.id, 'a1');
        expect(questions.length, 1);
        expect(questions[0].id, 'qq1');
      });

      test('throws QuizAlreadyStarted exception on 409', () async {
        when(() => httpClient.post('/api/quizzes/q1/start')).thenThrow(
          HttpClientResponse(
            data: {'message': 'Already started'},
            statusCode: 409,
          ),
        );

        expect(
          () => repository.startQuiz('q1'),
          throwsA(
            isA<QuizRepositoryException>().having(
              (e) => e.code,
              'code',
              QuizRepositoryExceptionCode.quizAlreadyStarted,
            ),
          ),
        );
      });
    });

    group('saveAnswer', () {
      test('calls put with correct data', () async {
        when(
          () => httpClient.put(
            any(),
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => const HttpClientResponse(data: {}, statusCode: 200),
        );

        await repository.saveAnswer(
          attemptId: 'a1',
          questionId: 'qq1',
          selectedOptions: ['Option A'],
        );

        verify(
          () => httpClient.put(
            '/api/quiz-attempts/a1/answer',
            data: any(named: 'data', that: containsPair('questionId', 'qq1')),
          ),
        ).called(1);
      });
    });

    group('submitQuizAttempt', () {
      test('returns QuizAttemptEntity on success', () async {
        final mockData = {
          'id': 'a1',
          'status': 'submitted',
          'score': 80,
          'total_marks': 100,
          'quiz_id': 'q1',
          'started_at': DateTime.now().toIso8601String(),
        };

        when(
          () => httpClient.post(
            '/api/quiz-attempts/a1/submit',
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => HttpClientResponse(
            data: {'data': mockData},
            statusCode: 200,
          ),
        );

        final result = await repository.submitQuizAttempt('a1');
        expect(result.status, QuizAttemptStatus.submitted);
      });
    });

    group('getStudentAttemptForQuiz', () {
      test('returns QuizAttemptEntity if exists', () async {
        final mockData = {
          'id': 'a1',
          'quiz_id': 'q1',
          'status': 'in_progress',
          'started_at': DateTime.now().toIso8601String(),
          'total_marks': 100,
          'score': 0,
        };

        when(
          () => httpClient.get('/api/quiz-attempts/student/s1/quiz/q1'),
        ).thenAnswer(
          (_) async => HttpClientResponse(
            data: {'data': mockData},
            statusCode: 200,
          ),
        );

        final result = await repository.getStudentAttemptForQuiz('s1', 'q1');
        expect(result?.id, 'a1');
      });

      test('returns null if 404', () async {
        when(
          () => httpClient.get('/api/quiz-attempts/student/s1/quiz/q1'),
        ).thenThrow(
          const HttpClientResponse(
            data: {'message': 'Not found'},
            statusCode: 404,
          ),
        );

        final result = await repository.getStudentAttemptForQuiz('s1', 'q1');
        expect(result, isNull);
      });
    });
    group('getStudentAttempts', () {
      test('returns List<QuizAttemptEntity> on success', () async {
        when(() => httpClient.get('/api/quiz-attempts/student/s1')).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {
              'data': [
                {
                  'id': 'a1',
                  'quiz_id': 'q1',
                  'status': 'submitted',
                  'score': 10,
                  'total_marks': 10,
                },
              ],
            },
            statusCode: 200,
          ),
        );

        final result = await repository.getStudentAttempts('s1');
        expect(result.length, 1);
        expect(result[0].id, 'a1');
      });
    });

    group('getAttemptsForQuiz', () {
      test('returns List<QuizAttemptEntity> on success', () async {
        when(() => httpClient.get('/api/quiz-attempts/quiz/q1')).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {
              'data': [
                {
                  'id': 'a1',
                  'quiz_id': 'q1',
                  'status': 'submitted',
                  'score': 10,
                  'total_marks': 10,
                },
              ],
            },
            statusCode: 200,
          ),
        );

        final result = await repository.getAttemptsForQuiz('q1');
        expect(result.length, 1);
        expect(result[0].id, 'a1');
      });
    });

    group('getStudentQuizStatus', () {
      test('returns status map on success', () async {
        when(
          () => httpClient.get('/api/quiz-attempts/student/s1/status'),
        ).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {
              'data': {'completed': 5, 'pending': 2},
            },
            statusCode: 200,
          ),
        );

        final result = await repository.getStudentQuizStatus('s1');
        expect(result['completed'], 5);
        expect(result['pending'], 2);
      });
    });

    group('getQuizStatistics', () {
      test('returns statistics map on success', () async {
        when(
          () => httpClient.get('/api/quiz-attempts/quiz/q1/statistics'),
        ).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {
              'data': {'averageScore': 75.5},
            },
            statusCode: 200,
          ),
        );

        final result = await repository.getQuizStatistics('q1');
        expect(result['averageScore'], 75.5);
      });
    });
  });
}
