import 'package:dio_course_repository/dio_course_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioCourseRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioCourseRepository(httpClient: httpClient);
  });

  group('DioCourseRepository', () {
    const tCourseId = 'course-1';
    const tSessionId = 'session-1';
    const tItemId = 'item-1';

    test('getEnrolledCourses returns list of courses', () async {
      when(() => httpClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => const HttpClientResponse(
                data: [
                  {'id': '1', 'title': 'Course 1'}
                ],
                statusCode: 200,
              ));

      final result = await repository.getEnrolledCourses();

      expect(result.length, 1);
      expect(result.first.title, 'Course 1');
    });

    test('getCategories returns list of categories', () async {
      when(() => httpClient.get('/api/categories', queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => const HttpClientResponse(
                data: [
                  {'id': '1', 'name': 'Programming'}
                ],
                statusCode: 200,
              ));

      final result = await repository.getCategories();

      expect(result.length, 1);
      expect(result.first.name, 'Programming');
    });

    test('getCourseDetail returns course entity', () async {
      when(() => httpClient.get('/api/courses/$tCourseId'))
          .thenAnswer((_) async => const HttpClientResponse(
                data: {
                  'id': tCourseId,
                  'title': 'Detailed Course',
                  'description': 'Desc'
                },
                statusCode: 200,
              ));

      final result = await repository.getCourseDetail(tCourseId);

      expect(result.id, tCourseId);
      expect(result.title, 'Detailed Course');
    });

    test('getCourseSessions returns list of sessions', () async {
      when(() => httpClient.get('/api/courses/$tCourseId/sessions'))
          .thenAnswer((_) async => const HttpClientResponse(
                data: [
                  {'id': tSessionId, 'title': 'Session 1', 'index': 1}
                ],
                statusCode: 200,
              ));

      final result = await repository.getCourseSessions(tCourseId);

      expect(result.length, 1);
      expect(result.first.id, tSessionId);
    });

    test('enrollInCourse calls post and returns enrollment', () async {
      when(() => httpClient.post('/api/student/enrollments', data: any(named: 'data')))
          .thenAnswer((_) async => HttpClientResponse(
                data: {
                  'id': 'e1', 
                  'course_id': tCourseId, 
                  'status': 'enrolled',
                  'enrolled_at': DateTime.now().toIso8601String(),
                },
                statusCode: 200,
              ));

      final result = await repository.enrollInCourse(tCourseId);

      expect(result.courseId, tCourseId);
      verify(() => httpClient.post('/api/student/enrollments', data: {'course_id': tCourseId})).called(1);
    });

    test('updateProgress calls post and completes', () async {
      when(() => httpClient.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => const HttpClientResponse(
                data: {},
                statusCode: 200,
              ));

      await expectLater(
        repository.updateProgress(tItemId, progressPercent: 0.5),
        completes,
      );
    });
  });
}
