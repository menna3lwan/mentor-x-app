import 'package:test/test.dart';
import 'package:dio_announcement_repository/dio_announcement_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'integration_config.dart';
import 'memory_cache_repository.dart';

void main() {
  late AnnouncementRepository repository;
  late DioHttpClient httpClient;
  late MemoryCacheRepository cacheRepository;

  setUp(() async {
    cacheRepository = MemoryCacheRepository();
    httpClient = DioHttpClient(
      baseUrl: IntegrationConfig.baseUrl,
      cacheRepository: cacheRepository,
    );
    repository = DioAnnouncementRepository(httpClient: httpClient);
  });

  group('Announcement Discovery Tests', () {
    test('Get Announcements', () async {
      try {
        final announcements = await repository.getAnnouncements();
        print('Announcements count: ${announcements.length}');
        for (var a in announcements.take(5)) {
          print('Announcement: ${a.id} - ${a.title}');
        }
      } on HttpClientResponse catch (e) {
        print('Error: ${e.statusCode} ${e.data}');
      } catch (e) {
        print('Failed to get announcements: $e');
      }
    });
  });
}
