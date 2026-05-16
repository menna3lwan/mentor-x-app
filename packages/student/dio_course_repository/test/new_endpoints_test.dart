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

  group('DioCourseRepository New Endpoints', () {
    test('getLevels returns list of LevelEntity', () async {
      final mockData = [
        {'id': 'l1', 'name': 'Level 1', 'orderNumber': 1}
      ];

      when(() => httpClient.get('/api/levels')).thenAnswer((_) async => HttpClientResponse(
        data: mockData,
        statusCode: 200,
      ));

      final result = await repository.getLevels();
      expect(result.length, 1);
      expect(result[0].name, 'Level 1');
    });

    test('getLessonStatus calls correct endpoint', () async {
      when(() => httpClient.get('/api/weeks/w1/status')).thenAnswer((_) async => HttpClientResponse(
        data: {'status': 'COMPLETED'},
        statusCode: 200,
      ));

      final result = await repository.getLessonStatus('w1');
      expect(result['status'], 'COMPLETED');
    });

    test('completeLesson calls correct endpoint', () async {
      when(() => httpClient.post(
        '/api/weeks/w1/complete',
        queryParameters: any(named: 'queryParameters'),
      )).thenAnswer((_) async => HttpClientResponse(data: {}, statusCode: 200));

      await repository.completeLesson('w1', quizScore: 80.0);
      verify(() => httpClient.post('/api/weeks/w1/complete', queryParameters: {'quizScore': 80.0})).called(1);
    });

    test('getSessionProgress calls correct endpoint', () async {
      when(() => httpClient.get('/api/weeks/session/s1/my-progress')).thenAnswer((_) async => HttpClientResponse(
        data: [{'weekId': 'w1', 'status': 'COMPLETED'}],
        statusCode: 200,
      ));

      final result = await repository.getSessionProgress('s1');
      expect(result.length, 1);
      expect(result[0]['weekId'], 'w1');
    });
  });
}
