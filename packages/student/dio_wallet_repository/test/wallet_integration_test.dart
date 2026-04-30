import 'package:test/test.dart';
import 'package:dio_wallet_repository/dio_wallet_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'integration_config.dart';
import 'memory_cache_repository.dart';

void main() {
  late WalletRepository repository;
  late DioHttpClient httpClient;
  late MemoryCacheRepository cacheRepository;

  setUp(() async {
    cacheRepository = MemoryCacheRepository();
    httpClient = DioHttpClient(
      baseUrl: IntegrationConfig.baseUrl,
      cacheRepository: cacheRepository,
    );
    repository = DioWalletRepository(httpClient: httpClient);
  });

  group('Wallet Discovery & Integration', () {
    test('Get Wallet Summary (Discovery)', () async {
      try {
        final summary = await repository.getSummary();
        print('Wallet Balance: ${summary.walletBalance}');
      } on WalletRepositoryException catch (e) {
        print('Failed to load wallet: ${e.code} - ${e.message}');
      } catch (e) {
        print('Unexpected error: $e');
      }
    });

    test('Get Transactions (Discovery)', () async {
      try {
        final transactions = await repository.getTransactions();
        print('Transactions loaded: ${transactions.length}');
      } on WalletRepositoryException catch (e) {
        print('Failed to load transactions: ${e.code} - ${e.message}');
      } catch (e) {
        print('Unexpected error: $e');
      }
    });
  });
}
