import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_announcement_repository/dio_announcement_repository.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioAnnouncementRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioAnnouncementRepository(httpClient: httpClient);
    registerFallbackValue(<String, dynamic>{});
  });

  group('DioAnnouncementRepository', () {
    group('getAnnouncements', () {
      test('returns list of AnnouncementEntity when data is top-level list', () async {
        final mockData = [
          {
            'id': 'a1',
            'title': 'Announcement 1',
            'content': 'Content 1',
            'created_at': DateTime.now().toIso8601String(),
          }
        ];

        when(() => httpClient.get(
          '/api/announcements',
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getAnnouncements();
        expect(result.length, 1);
        expect(result[0].id, 'a1');
      });

      test('returns list of AnnouncementEntity when data is wrapped in "content"', () async {
        final mockData = {
          'content': [
            {
              'id': 'a1',
              'title': 'Announcement 1',
              'content': 'Content 1',
              'created_at': DateTime.now().toIso8601String(),
            }
          ]
        };

        when(() => httpClient.get(
          '/api/announcements',
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getAnnouncements();
        expect(result.length, 1);
        expect(result[0].id, 'a1');
      });

      test('returns list of AnnouncementEntity when data is wrapped in "data.content"', () async {
        final mockData = {
          'data': {
            'content': [
              {
                'id': 'a1',
                'title': 'Announcement 1',
                'content': 'Content 1',
                'created_at': DateTime.now().toIso8601String(),
              }
            ]
          }
        };

        when(() => httpClient.get(
          '/api/announcements',
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getAnnouncements();
        expect(result.length, 1);
        expect(result[0].id, 'a1');
      });

      test('throws AnnouncementRepositoryException on 500', () async {
        when(() => httpClient.get(
          '/api/announcements',
          queryParameters: any(named: 'queryParameters'),
        )).thenThrow(HttpClientResponse(
          data: {'message': 'Server Error'},
          statusCode: 500,
          exception: HttpClientException(
            code: HttpClientExceptionCode.serverError,
            message: 'Server Error',
          ),
        ));

        expect(
          () => repository.getAnnouncements(),
          throwsA(isA<AnnouncementRepositoryException>().having(
            (e) => e.code,
            'code',
            AnnouncementRepositoryExceptionCode.failedToLoadAnnouncements,
          )),
        );
      });

      test('sends correct query parameters', () async {
        when(() => httpClient.get(
          '/api/announcements',
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer((_) async => const HttpClientResponse(
          data: [],
          statusCode: 200,
        ));

        await repository.getAnnouncements(
          search: 'test',
          pinned: true,
          paginationInfo: const MentorXPaginationInfo(page: 1, limit: 10),
        );

        verify(() => httpClient.get(
          '/api/announcements',
          queryParameters: {
            'search': 'test',
            'pinned': true,
            'page': 1,
            'limit': 10,
          },
        )).called(1);
      });
    });

    group('getAnnouncementDetail', () {
      test('returns AnnouncementEntity on success (unwrapped)', () async {
        final mockData = {
          'id': 'a1',
          'title': 'Announcement 1',
          'content': 'Detailed Content',
          'created_at': DateTime.now().toIso8601String(),
        };

        when(() => httpClient.get('/api/announcements/a1')).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getAnnouncementDetail('a1');
        expect(result.id, 'a1');
        expect(result.content, 'Detailed Content');
      });

      test('returns AnnouncementEntity on success (wrapped in data)', () async {
        final mockData = {
          'data': {
            'id': 'a1',
            'title': 'Announcement 1',
            'content': 'Detailed Content',
            'created_at': DateTime.now().toIso8601String(),
          }
        };

        when(() => httpClient.get('/api/announcements/a1')).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getAnnouncementDetail('a1');
        expect(result.id, 'a1');
      });

      test('throws AnnouncementRepositoryException on 404', () async {
        when(() => httpClient.get('/api/announcements/a1')).thenThrow(HttpClientResponse(
          data: {'message': 'Not Found'},
          statusCode: 404,
          exception: HttpClientException(
            code: HttpClientExceptionCode.notFound,
            message: 'Not Found',
          ),
        ));

        expect(
          () => repository.getAnnouncementDetail('a1'),
          throwsA(isA<AnnouncementRepositoryException>().having(
            (e) => e.code,
            'code',
            AnnouncementRepositoryExceptionCode.failedToLoadAnnouncementDetail,
          )),
        );
      });
    });
  });
}
