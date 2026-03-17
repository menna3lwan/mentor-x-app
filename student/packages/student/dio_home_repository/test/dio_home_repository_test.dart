import 'package:dio_home_repository/dio_home_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioHomeRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioHomeRepository(httpClient: httpClient);
  });

  group('DioHomeRepository', () {
    test('getWalletSummary returns wallet status on success', () async {
      // arrange
      when(() => httpClient.get('/api/student/wallet/summary'))
          .thenAnswer((_) async => const HttpClientResponse(
                data: {
                  'data': {'walletBalance': 150.5, 'totalPoints': 1000}
                },
                statusCode: 200,
              ));

      // act
      final result = await repository.getWalletSummary();

      // assert
      expect(result.walletBalance, 150.5);
      expect(result.points, 1000);
      verify(() => httpClient.get('/api/student/wallet/summary')).called(1);
    });

    test('getUnreadNotificationsCount returns count on success', () async {
      // arrange
      when(() => httpClient.get('/api/notifications/unread-count'))
          .thenAnswer((_) async => const HttpClientResponse(
                data: {'count': 5},
                statusCode: 200,
              ));

      // act
      final result = await repository.getUnreadNotificationsCount();

      // assert
      expect(result, 5);
      verify(() => httpClient.get('/api/notifications/unread-count')).called(1);
    });

    test('getHomeBanners returns list of banners', () async {
      // arrange
      when(() => httpClient.get(
            '/api/banners',
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => const HttpClientResponse(
            data: [
              {
                'id': '1',
                'image_url': 'http://image.png',
                'title': 'Banner 1',
                'action_type': 'course',
                'action_value': '1'
              }
            ],
            statusCode: 200,
          ));

      // act
      final result = await repository.getHomeBanners();

      // assert
      expect(result, isA<List<BannerEntity>>());
      expect(result.length, 1);
      expect(result.first.id, '1');
    });

    test('getRecentAnnouncements returns list of announcements', () async {
      // arrange
      when(() => httpClient.get(
            '/api/announcements',
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => const HttpClientResponse(
            data: [
              {
                'id': '1',
                'title': 'News',
                'preview': 'Check this out',
                'created_at': '2023-01-01T00:00:00Z'
              }
            ],
            statusCode: 200,
          ));

      // act
      final result = await repository.getRecentAnnouncements();

      // assert
      expect(result.length, 1);
      expect(result.first.title, 'News');
    });

    test('trackBannerClick calls post and returns normally', () async {
      // arrange
      when(() => httpClient.post('/api/banners/1/click'))
          .thenAnswer((_) async => const HttpClientResponse(
                data: {},
                statusCode: 200,
              ));

      // act & assert
      await expectLater(repository.trackBannerClick('1'), completes);
      verify(() => httpClient.post('/api/banners/1/click')).called(1);
    });
  });
}
