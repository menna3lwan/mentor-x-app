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
    httpClient.setDefaultHeader('X-Device-Id', 'student-app');
    repository = DioWalletRepository(httpClient: httpClient);
  });

  group('Wallet Discovery & Integration', () {
    test('Get Wallet Summary (Discovery)', () async {
      try {
        final summary = await repository.getSummary();
        _log.info('Wallet Balance: ${summary.walletBalance}');
      } on WalletRepositoryException catch (e) {
        _log.error('Failed to load wallet: ${e.code} - ${e.message}');
      } catch (e) {
        _log.error('Unexpected error: $e');
      }
    });

    test('Get Transactions (Discovery)', () async {
      try {
        final transactions = await repository.getTransactions();
        _log.info('Transactions loaded: ${transactions.length}');
      } on WalletRepositoryException catch (e) {
        _log.error('Failed to load transactions: ${e.code} - ${e.message}');
      } catch (e) {
        _log.error('Unexpected error: $e');
      }
    });
  });
}
