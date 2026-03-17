import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio_assignment_repository/src/dio_assignment_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late DioAssignmentRepository repository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = DioAssignmentRepository(httpClient: mockHttpClient);
  });

  group('DioAssignmentRepository', () {
    test('getAssignment returns assignment entity on success', () async {
      final mockResponse = {
        'data': {
          'id': '1',
          'title': 'Math Assignment',
          'description': 'Solve algebra problems',
          'dueDate': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
          'totalMarks': 100,
        }
      };

      when(() => mockHttpClient.get('/api/assignments/1'))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getAssignment('1');

      expect(result.id, '1');
      expect(result.title, 'Math Assignment');
    });

    test('submitAssignment returns submission entity on success', () async {
      final mockResponse = {
        'data': {
          'id': 's1',
          'assignmentId': '1',
          'status': 'submitted',
          'submittedAt': DateTime.now().toIso8601String(),
          'fileUrls': ['https://example.com/file.pdf'],
        }
      };

      when(() => mockHttpClient.post('/api/assignments/1/submit', data: any(named: 'data')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.submitAssignment('1', fileUrls: ['https://example.com/file.pdf']);

      expect(result.id, 's1');
      expect(result.status, SubmissionStatus.submitted);
    });
  });
}
