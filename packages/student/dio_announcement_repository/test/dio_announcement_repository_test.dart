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
      test('returns list of AnnouncementEntity on success', () async {
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
    });

    group('getAnnouncementDetail', () {
      test('returns AnnouncementEntity on success', () async {
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
    });
  });
}
