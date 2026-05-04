import 'package:test/test.dart';
import 'package:dio_home_repository/dio_home_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'integration_config.dart';
import 'memory_cache_repository.dart';

final _log = MentorXLogger('BannersDiscoveryTest');

void main() {
  late StudentHomeRepository repository;
  late DioHttpClient httpClient;
  late MemoryCacheRepository cacheRepository;

  setUp(() async {
    MentorXLogger.enabled = true;
    cacheRepository = MemoryCacheRepository();
    httpClient = DioHttpClient(
      baseUrl: IntegrationConfig.baseUrl,
      cacheRepository: cacheRepository,
    );
    repository = DioStudentHomeRepository(httpClient: httpClient);
  });

  group('Banners Discovery Tests', () {
    test('Get Home Banners', () async {
      try {
        final banners = await repository.getHomeBanners();
        _log.info('Banners count: ${banners.length}');
        for (var b in banners) {
          _log.info('Banner: ${b.id} - ${b.title}');
        }
      } on HttpClientResponse catch (e) {
        _log.error('Error: ${e.statusCode} ${e.data}');
      } catch (e) {
        _log.error('Failed to get banners: $e');
      }
    });
  });
}
