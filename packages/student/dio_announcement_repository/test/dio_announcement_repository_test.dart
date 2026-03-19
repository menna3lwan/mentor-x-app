import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio_announcement_repository/src/dio_announcement_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late DioAnnouncementRepository repository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = DioAnnouncementRepository(httpClient: mockHttpClient);
  });

  group('DioAnnouncementRepository', () {
    test('getAnnouncements returns list of announcements', () async {
      final mockResponse = {
        'data': [
          {
            'id': 'a1',
            'title': 'System Update',
            'preview': 'The system will be down...',
            'createdAt': DateTime.now().toIso8601String(),
          }
        ]
      };

      when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getAnnouncements();

      expect(result.length, 1);
      expect(result.first.title, 'System Update');
    });

    test('getAnnouncementDetail returns announcement entity', () async {
      final mockResponse = {
        'data': {
          'id': 'a1',
          'title': 'System Update',
          'preview': 'The system will be down...',
          'createdAt': DateTime.now().toIso8601String(),
        }
      };

      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getAnnouncementDetail('a1');

      expect(result.id, 'a1');
      expect(result.title, 'System Update');
    });
  });
}
