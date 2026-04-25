import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_wallet_repository/dio_wallet_repository.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioWalletRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioWalletRepository(httpClient: httpClient);
    registerFallbackValue(<String, dynamic>{});
  });

  group('DioWalletRepository', () {
    group('getSummary', () {
      test('returns WalletSummaryEntity on success', () async {
        final mockData = {
          'wallet_balance': 1500.0,
          'total_points': 300,
        };

        when(() => httpClient.get('/api/payment/wallet/balance')).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getSummary();
        expect(result.walletBalance, 1500.0);
      });
    });

    group('getTransactions', () {
      test('returns list of WalletTransactionEntity on success', () async {
        final mockData = {
          'content': [
            {
              'id': 't1',
              'amount': 100.0,
              'type': 'deposit',
              'status': 'completed',
              'created_at': '2024-01-01T00:00:00Z',
            }
          ]
        };

        when(() => httpClient.get(
          '/api/payment/wallet/transactions',
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.getTransactions();
        expect(result.length, 1);
        expect(result[0].id, 't1');
      });
    });

    group('redeemCode', () {
      test('returns response map on success', () async {
        final mockData = {
          'amount': 50.0,
          'message': 'Success',
        };

        when(() => httpClient.post(
          '/api/v1/access-codes/redeem',
          data: any(named: 'data'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockData,
          statusCode: 200,
        ));

        final result = await repository.redeemCode('FAKE-CODE');
        expect(result['amount'], 50.0);
      });
    });
  });
}
