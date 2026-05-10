import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_notification_repository/dio_notification_repository.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioNotificationRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioNotificationRepository(httpClient: httpClient);
    registerFallbackValue(<String, dynamic>{});
  });

  group('DioNotificationRepository', () {
    group('getNotifications', () {
      test('returns list of NotificationEntity on success', () async {
        final mockData = {
          'content': [
            {
              'id': 'n1',
              'title': 'Notif 1',
              'body': 'Body 1',
              'is_read': false,
              'created_at': DateTime.now().toIso8601String(),
            }
          ]
        };

        when(() => httpClient.get(
          '/api/notifications/my',
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getNotifications();
        expect(result.length, 1);
        expect(result[0].id, 'n1');
      });
    });

    group('markAsRead', () {
      test('calls post and completes', () async {
        when(() => httpClient.post('/api/notifications/n1/read')).thenAnswer((_) async => const HttpClientResponse(
          data: {},
          statusCode: 200,
        ));

        await repository.markAsRead('n1');
        verify(() => httpClient.post('/api/notifications/n1/read')).called(1);
      });
    });
  });
}
