import 'package:test/test.dart';
import 'package:dio_announcement_repository/dio_announcement_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'integration_config.dart';
import 'memory_cache_repository.dart';

final _log = MentorXLogger('AnnouncementDiscoveryTest');

void main() {
  late AnnouncementRepository repository;
  late DioHttpClient httpClient;
  late MemoryCacheRepository cacheRepository;

  setUp(() async {
    MentorXLogger.enabled = true;
    cacheRepository = MemoryCacheRepository();
    httpClient = DioHttpClient(
      baseUrl: IntegrationConfig.baseUrl,
      cacheRepository: cacheRepository,
    );
    repository = DioAnnouncementRepository(httpClient: httpClient);
  });
}
