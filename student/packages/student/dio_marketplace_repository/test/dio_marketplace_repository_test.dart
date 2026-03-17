import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio_marketplace_repository/src/dio_marketplace_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late DioMarketplaceRepository repository;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = DioMarketplaceRepository(httpClient: mockHttpClient);
  });

  group('DioMarketplaceRepository', () {
    test('getCategories returns list of categories', () async {
      final mockResponse = {
        'data': [
          {'id': '1', 'name': 'Electronics'}
        ]
      };

      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getCategories();

      expect(result.length, 1);
      expect(result.first.name, 'Electronics');
    });

    test('getItems returns list of items', () async {
      final mockResponse = {
        'data': [
          {
            'id': 'i1',
            'title': 'MacBook Pro',
            'price': 2000.0,
            'imageUrls': ['https://example.com/mac.jpg'],
          }
        ]
      };

      when(() => mockHttpClient.get(any(), queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.getItems();

      expect(result.length, 1);
      expect(result.first.title, 'MacBook Pro');
    });

    test('placeOrder returns order entity on success', () async {
      final mockResponse = {
        'data': {
          'id': 'o1',
          'orderNumber': 'ORD-123',
          'totalAmount': 2000.0,
          'status': 'pending',
          'createdAt': DateTime.now().toIso8601String(),
        }
      };

      when(() => mockHttpClient.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => HttpClientResponse(
                data: mockResponse,
                statusCode: 200,
              ));

      final result = await repository.placeOrder(
        items: [(itemId: 'i1', quantity: 1)],
        deliveryAddress: 'Test Address',
        deliveryPhone: '123456789',
      );

      expect(result.id, 'o1');
      expect(result.orderNumber, 'ORD-123');
    });
  });
}
