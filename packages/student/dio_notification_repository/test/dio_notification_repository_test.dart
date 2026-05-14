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
          'data': {
            'content': [
              {
                'id': 'n1',
                'title': 'Notif 1',
                'message': 'Body 1',
                'type': 'info',
                'is_read': false,
                'created_at': DateTime.now().toIso8601String(),
              }
            ]
          }
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
        expect(result[0].title, 'Notif 1');
      });

      test('returns list of NotificationEntity when data is directly an array', () async {
        final mockData = [
          {
            'id': 'n1',
            'title': 'Notif 1',
            'message': 'Body 1',
            'type': 'info',
            'is_read': false,
            'created_at': DateTime.now().toIso8601String(),
          }
        ];

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
      test('calls patch and completes', () async {
        when(() => httpClient.patch('/api/notifications/n1/read')).thenAnswer((_) async => const HttpClientResponse(
          data: {},
          statusCode: 200,
        ));

        await repository.markAsRead('n1');
        verify(() => httpClient.patch('/api/notifications/n1/read')).called(1);
      });
    });

    group('markAllAsRead', () {
      test('calls patch and completes', () async {
        when(() => httpClient.patch('/api/notifications/read-all')).thenAnswer((_) async => const HttpClientResponse(
          data: {},
          statusCode: 200,
        ));

        await repository.markAllAsRead();
        verify(() => httpClient.patch('/api/notifications/read-all')).called(1);
      });
    });

    group('deleteNotification', () {
      test('calls delete and completes', () async {
        when(() => httpClient.delete('/api/notifications/n1')).thenAnswer((_) async => const HttpClientResponse(
          data: {},
          statusCode: 200,
        ));

        await repository.deleteNotification('n1');
        verify(() => httpClient.delete('/api/notifications/n1')).called(1);
      });
    });

    group('getUnreadCount', () {
      test('returns unread count on success (as number)', () async {
        when(() => httpClient.get('/api/notifications/unread-count')).thenAnswer((_) async => const HttpClientResponse(
          data: 5,
          statusCode: 200,
        ));

        final result = await repository.getUnreadCount();
        expect(result, 5);
      });

      test('returns unread count on success (in data map)', () async {
        when(() => httpClient.get('/api/notifications/unread-count')).thenAnswer((_) async => const HttpClientResponse(
          data: {'data': 10},
          statusCode: 200,
        ));

        final result = await repository.getUnreadCount();
        expect(result, 10);
      });

      test('returns unread count on success (in map with count key)', () async {
        when(() => httpClient.get('/api/notifications/unread-count')).thenAnswer((_) async => const HttpClientResponse(
          data: {'count': 3},
          statusCode: 200,
        ));

        final result = await repository.getUnreadCount();
        expect(result, 3);
      });
    });

    group('updateFCMToken', () {
      test('calls post with token', () async {
        when(() => httpClient.post(
          '/api/notifications/fcm-token',
          data: any(named: 'data'),
        )).thenAnswer((_) async => const HttpClientResponse(
          data: {},
          statusCode: 200,
        ));

        await repository.updateFCMToken('new_token');
        verify(() => httpClient.post(
          '/api/notifications/fcm-token',
          data: {'token': 'new_token'},
        )).called(1);
      });
    });
  });
}
