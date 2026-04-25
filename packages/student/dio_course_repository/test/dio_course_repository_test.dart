import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_course_repository/dio_course_repository.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioCourseRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioCourseRepository(httpClient: httpClient);
    registerFallbackValue(<String, dynamic>{});
  });

  group('DioCourseRepository', () {
    group('getEnrolledCourses', () {
      test('returns list of CourseSummaryEntity on success (paginated)', () async {
        final mockData = {
          'content': [
            {
              'id': 'c1',
              'title': 'Enrolled Course 1',
              'progress_percent': 25.0,
            }
          ]
        };

        when(() => httpClient.get(
          '/api/enrollments/my-enrollments',
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getEnrolledCourses();

        expect(result.length, 1);
        expect(result[0].id, 'c1');
        expect(result[0].title, 'Enrolled Course 1');
      });
    });

    group('getCourseDetail', () {
      test('returns CourseEntity on success', () async {
        final mockData = {
          'id': 'c1',
          'title': 'Course 1 Detail',
          'description': 'Description',
        };

        when(() => httpClient.get('/api/courses/c1')).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getCourseDetail('c1');
        expect(result.id, 'c1');
        expect(result.title, 'Course 1 Detail');
      });
    });

    group('getCourseSessions', () {
      test('returns list of SessionEntity on success', () async {
        final mockData = {
          'content': [
            {
              'id': 's1',
              'title': 'Session 1',
            }
          ]
        };

        when(() => httpClient.get('/api/sessions/course/c1')).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getCourseSessions('c1');
        expect(result.length, 1);
        expect(result[0].id, 's1');
      });
    });

    group('getStreamUrl', () {
      test('returns url string on success', () async {
        final mockData = {
          'stream_url': 'https://stream.com/video',
        };

        when(() => httpClient.get('/api/materials/m1')).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getStreamUrl('m1');
        expect(result, 'https://stream.com/video');
      });
    });
  });
}
