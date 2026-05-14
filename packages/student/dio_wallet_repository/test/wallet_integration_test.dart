import 'package:test/test.dart';
import 'package:dio_wallet_repository/dio_wallet_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'integration_config.dart';
import 'memory_cache_repository.dart';

final _log = MentorXLogger('WalletIntegrationTest');

void main() {
  late WalletRepository repository;
  late DioHttpClient httpClient;
  late MemoryCacheRepository cacheRepository;

  setUp(() async {
    MentorXLogger.enabled = true;
    cacheRepository = MemoryCacheRepository();
    httpClient = DioHttpClient(
      baseUrl: IntegrationConfig.baseUrl,
      cacheRepository: cacheRepository,
    );
    httpClient.setDefaultHeader(NetworkConstants.deviceIdHeader, 'student-app');
    repository = DioWalletRepository(httpClient: httpClient);
  });
}
