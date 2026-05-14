import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_home_repository/dio_home_repository.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioStudentHomeRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioStudentHomeRepository(httpClient: httpClient);
  });

  group('DioStudentHomeRepository', () {
    group('getWalletSummary', () {
      test('returns WalletSummaryEntity on success', () async {
        final mockData = {
          'balance': 1000.5,
          'total_points': 500,
          'spent_this_month': 200.0,
          'total_credits_this_month': 150.0,
          'total_transactions': 10,
        };

        when(() => httpClient.get('/api/payment/wallet/balance')).thenAnswer(
          (_) async => HttpClientResponse(
            data: mockData,
            statusCode: 200,
          ),
        );

        final result = await repository.getWalletSummary();

        expect(result.walletBalance, 1000.5);
      });

      test('throws StudentHomeRepositoryException on failure', () async {
        when(() => httpClient.get('/api/payment/wallet/balance')).thenThrow(
          const HttpClientResponse(
            data: {'message': 'Error'},
            statusCode: 400,
          ),
        );

        expect(
          () => repository.getWalletSummary(),
          throwsA(isA<StudentHomeRepositoryException>()),
        );
      });
    });

    group('getUnreadNotificationsCount', () {
      test('returns count on success (count field)', () async {
        when(() => httpClient.get('/api/notifications/unread-count')).thenAnswer(
          (_) async => HttpClientResponse(
            data: {'count': 5},
            statusCode: 200,
          ),
        );

        final result = await repository.getUnreadNotificationsCount();

        expect(result, 5);
      });

      test('returns count on success (unreadCount field)', () async {
        when(() => httpClient.get('/api/notifications/unread-count')).thenAnswer(
          (_) async => HttpClientResponse(
            data: {'unreadCount': 10},
            statusCode: 200,
          ),
        );

        final result = await repository.getUnreadNotificationsCount();

        expect(result, 10);
      });

      test('returns count on success (wrapped in data)', () async {
        when(() => httpClient.get('/api/notifications/unread-count')).thenAnswer(
          (_) async => HttpClientResponse(
            data: {
              'data': {'count': 3}
            },
            statusCode: 200,
          ),
        );

        final result = await repository.getUnreadNotificationsCount();

        expect(result, 3);
      });
    });

    group('getHomeBanners', () {
      test('returns list of BannerEntity on success', () async {
        final mockData = [
          {
            'id': '1',
            'image_url': 'https://example.com/banner1.jpg',
            'title': 'Banner 1',
          }
        ];

        when(() => httpClient.get(
              '/api/banners/active',
              queryParameters: any(named: 'queryParameters'),
            )).thenAnswer(
          (_) async => HttpClientResponse(
            data: mockData,
            statusCode: 200,
          ),
        );

        final result = await repository.getHomeBanners(gradeId: 'grade-1');

        expect(result.length, 1);
        expect(result[0].id, '1');
      });

      test('returns empty list on 403', () async {
        when(() => httpClient.get(
              '/api/banners/active',
              queryParameters: any(named: 'queryParameters'),
            )).thenThrow(
          const HttpClientResponse(
            data: {'message': 'Forbidden'},
            statusCode: 403,
          ),
        );

        final result = await repository.getHomeBanners();

        expect(result, isEmpty);
      });
    });

    group('getContinueLearningCourses', () {
      test('returns list of CourseSummaryEntity on success', () async {
        final mockData = {
          'content': [
            {
              'courseId': 'c1',
              'courseTitle': 'Course 1',
              'progress': 50.0,
            }
          ]
        };

        when(() => httpClient.get(
              '/api/enrollments/my-enrollments',
              queryParameters: any(named: 'queryParameters'),
            )).thenAnswer(
          (_) async => HttpClientResponse(
            data: mockData,
            statusCode: 200,
          ),
        );

        final result = await repository.getContinueLearningCourses();

        expect(result.length, 1);
        expect(result[0].id, 'c1');
        expect(result[0].title, 'Course 1');
      });
    });

    group('getFeaturedCourses', () {
      test('returns list of CourseSummaryEntity on success', () async {
        final mockData = {
          'content': [
            {
              'id': 'c1',
              'title': 'Course 1',
              'price': 99.99,
            }
          ]
        };

        when(() => httpClient.get(
              '/api/courses',
              queryParameters: any(named: 'queryParameters'),
            )).thenAnswer(
          (_) async => HttpClientResponse(
            data: mockData,
            statusCode: 200,
          ),
        );

        final result = await repository.getFeaturedCourses(gradeId: 'grade-1');

        expect(result.length, 1);
        expect(result[0].id, 'c1');
      });
    });

    group('getRecentAnnouncements', () {
      test('returns list of AnnouncementEntity on success', () async {
        final mockData = [
          {
            'id': 'a1',
            'title': 'Announcement 1',
            'content': 'Content 1',
            'created_at': '2024-01-01T00:00:00Z',
          }
        ];

        when(() => httpClient.get(
              '/api/announcements/active',
              queryParameters: any(named: 'queryParameters'),
            )).thenAnswer(
          (_) async => HttpClientResponse(
            data: mockData,
            statusCode: 200,
          ),
        );

        final result = await repository.getRecentAnnouncements();

        expect(result.length, 1);
      });
    });

    group('trackBannerClick', () {
      test('calls post endpoint', () async {
        when(() => httpClient.post('/api/banners/b1/click')).thenAnswer(
          (_) async => const HttpClientResponse(data: {}, statusCode: 200),
        );

        await repository.trackBannerClick('b1');

        verify(() => httpClient.post('/api/banners/b1/click')).called(1);
      });
    });

    group('banner CRUD', () {
      test('createBanner returns BannerEntity', () async {
        final data = {'title': 'New'};
        when(() => httpClient.post('/api/banners', data: data)).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {'id': 'new-id', 'image_url': 'url'},
            statusCode: 200,
          ),
        );

        final result = await repository.createBanner(data);

        expect(result.id, 'new-id');
      });

      test('updateBanner calls patch endpoint', () async {
        final data = {'title': 'Updated'};
        when(() => httpClient.patch('/api/banners/b1', data: data)).thenAnswer(
          (_) async => const HttpClientResponse(data: {}, statusCode: 200),
        );

        await repository.updateBanner('b1', data);

        verify(() => httpClient.patch('/api/banners/b1', data: data)).called(1);
      });

      test('deleteBanner calls delete endpoint', () async {
        when(() => httpClient.delete('/api/banners/b1')).thenAnswer(
          (_) async => const HttpClientResponse(data: {}, statusCode: 200),
        );

        await repository.deleteBanner('b1');

        verify(() => httpClient.delete('/api/banners/b1')).called(1);
      });
    });
  });
}
