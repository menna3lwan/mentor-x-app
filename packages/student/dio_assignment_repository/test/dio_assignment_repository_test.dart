import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_assignment_repository/dio_assignment_repository.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioAssignmentRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioAssignmentRepository(httpClient: httpClient);
    registerFallbackValue(<String, dynamic>{});
  });

  group('DioAssignmentRepository', () {
    group('getAssignment', () {
      test('returns AssignmentEntity on success', () async {
        final mockData = {
          'id': 'as1',
          'title': 'Assignment 1',
          'description': 'Description',
          'due_date': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
        };

        when(() => httpClient.get('/api/assignments/as1')).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getAssignment('as1');
        expect(result.id, 'as1');
        expect(result.title, 'Assignment 1');
      });
    });

    group('getSubmission', () {
      test('returns AssignmentSubmissionEntity on success', () async {
        final mockData = {
          'id': 'sub1',
          'assignment_id': 'as1',
          'status': 'submitted',
          'submitted_at': DateTime.now().toIso8601String(),
        };

        when(() => httpClient.get('/api/assignment-attempts/student/me/assignment/as1')).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getSubmission('as1');
        expect(result?.id, 'sub1');
      });
    });

    group('submitAssignment', () {
      test('returns AssignmentSubmissionEntity on success', () async {
        final mockData = {
          'id': 'sub2',
          'status': 'submitted',
        };

        when(() => httpClient.post(
          '/api/assignments/as1/submit',
          data: any(named: 'data'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.submitAssignment('as1', fileUrls: ['url1']);
        expect(result.id, 'sub2');
        expect(result.status, SubmissionStatus.submitted);
      });
    });
  });
}
