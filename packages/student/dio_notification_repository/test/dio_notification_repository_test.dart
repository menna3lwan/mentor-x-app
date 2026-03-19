import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio_notification_repository/src/dio_notification_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late DioNotificationRepository repository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = DioNotificationRepository(httpClient: mockHttpClient);
  });

  group('DioNotificationRepository', () {
    test('getNotifications returns list of notifications', () async {
      final mockResponse = {
        'data': [
          {
            'id': 'n1',
            'type': 'announcement',
            'title': 'New Course',
            'body': 'A new course is available',
            'createdAt': DateTime.now().toIso8601String(),
          }
        ]
      };

      when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getNotifications();

      expect(result.length, 1);
      expect(result.first.title, 'New Course');
    });

    test('getUnreadCount returns correct count', () async {
      final mockResponse = {'data': {'count': 5}};

      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getUnreadCount();

      expect(result, 5);
    });

    test('markAsRead returns success', () async {
      when(() => mockHttpClient.post(any()))
          .thenAnswer((_) async => HttpClientResponse(
                data: {},
                statusCode: 200,
              ));

      await repository.markAsRead('n1');

      verify(() => mockHttpClient.post(any())).called(1);
    });
  });
}
