import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio_wallet_repository/src/dio_wallet_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late DioWalletRepository repository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = DioWalletRepository(httpClient: mockHttpClient);
  });

  group('DioWalletRepository', () {
    test('getSummary returns wallet summary', () async {
      final mockResponse = {
        'data': {
          'walletBalance': 100.5,
          'totalPoints': 500,
        }
      };

      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getSummary();

      expect(result.walletBalance, 100.5);
      expect(result.points, 500);
    });

    test('getTransactions returns list of transactions', () async {
      final mockResponse = {
        'data': [
          {
            'id': 't1',
            'transactionType': 'deposit',
            'amount': 50.0,
            'balanceAfter': 100.0,
            'description': 'Top up',
            'createdAt': DateTime.now().toIso8601String(),
          }
        ]
      };

      when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getTransactions();

      expect(result.length, 1);
      expect(result.first.amount, 50.0);
    });

    test('initiatePayment returns payment entity', () async {
      final mockResponse = {
        'data': {
          'id': 'p1',
          'amount': 100.0,
          'method': 'vodafoneCash',
          'type': 'walletTopup',
          'status': 'pending',
          'createdAt': DateTime.now().toIso8601String(),
        }
      };

      when(() => mockHttpClient.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.initiatePayment(
        amount: 100.0,
        method: PaymentMethod.vodafoneCash,
        paymentType: PaymentType.walletTopup,
      );

      expect(result.id, 'p1');
      expect(result.status, PaymentStatus.pending);
    });
  });
}
