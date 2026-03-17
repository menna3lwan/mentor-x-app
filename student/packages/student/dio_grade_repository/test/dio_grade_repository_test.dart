import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio_grade_repository/src/dio_grade_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late DioGradeRepository repository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = DioGradeRepository(httpClient: mockHttpClient);
  });

  group('DioGradeRepository', () {
    test('getQuizGrades returns list of quiz attempts', () async {
      final mockResponse = {
        'data': [
          {
            'id': 'a1',
            'quizId': 'q1',
            'score': 85.0,
            'status': 'passed',
            'startedAt': DateTime.now().toIso8601String(),
            'completedAt': DateTime.now().toIso8601String(),
          }
        ]
      };

      when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getQuizGrades();

      expect(result.length, 1);
      expect(result.first.score, 85);
    });

    test('getAssignmentGrades returns list of submissions', () async {
      final mockResponse = {
        'data': [
          {
            'id': 's1',
            'assignmentId': 'a1',
            'score': 90,
            'status': 'graded',
            'submittedAt': DateTime.now().toIso8601String(),
          }
        ]
      };

      when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getAssignmentGrades();

      expect(result.length, 1);
      expect(result.first.score, 90);
    });
  });
}
