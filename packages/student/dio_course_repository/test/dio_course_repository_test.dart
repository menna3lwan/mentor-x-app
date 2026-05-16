import 'package:test/test.dart';
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
      test('returns list of EnrollmentEntity on success (paginated)', () async {
        final mockData = {
          'content': [
            {
              'id': 'e1',
              'course_id': 'c1',
              'course_title': 'Enrolled Course 1',
              'progress_percent': 25.0,
              'enrolled_at': '2026-05-14T09:35:45Z',
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
        expect(result[0].id, 'e1');
        expect(result[0].courseTitle, 'Enrolled Course 1');
      });
    });

    group('getSessionWeeks', () {
      test('returns weeks with items on success', () async {
        final mockWeeks = [
          {'id': 'w1', 'title': 'Week 1', 'session_ids': [1]}
        ];
        final mockMaterials = [
          {'id': 'm1', 'title': 'Material 1', 'week_ids': [1], 'materialType': 'VIDEO'}
        ];

        when(() => httpClient.get('/api/weeks/session/s1'))
            .thenAnswer((_) async => HttpClientResponse(data: mockWeeks, statusCode: 200));
        when(() => httpClient.get('/api/materials/lesson/w1'))
            .thenAnswer((_) async => HttpClientResponse(data: mockMaterials, statusCode: 200));

        final result = await repository.getSessionWeeks('s1');

        expect(result.length, 1);
        expect(result[0].title, 'Week 1');
        expect(result[0].materials.length, 1);
        expect(result[0].materials[0].title, 'Material 1');
      });
    });

    group('getSessionItems', () {
      test('returns flattened materials for session', () async {
        final mockWeeks = [
          {'id': 'w1', 'title': 'Week 1', 'session_ids': [1]}
        ];
        final mockMaterials = [
          {'id': 'm1', 'title': 'Material 1', 'week_ids': [1], 'materialType': 'VIDEO'}
        ];

        when(() => httpClient.get('/api/weeks/session/s1'))
            .thenAnswer((_) async => HttpClientResponse(data: mockWeeks, statusCode: 200));
        when(() => httpClient.get('/api/materials/lesson/w1'))
            .thenAnswer((_) async => HttpClientResponse(data: mockMaterials, statusCode: 200));

        final result = await repository.getSessionItems('s1');

        expect(result.length, 1);
        expect(result[0].id, 'm1');
      });
    });

    group('getStreamUrl', () {
      test('returns url string from embedUrl on success', () async {
        final mockData = {
          'embedUrl': 'https://stream.com/video',
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
