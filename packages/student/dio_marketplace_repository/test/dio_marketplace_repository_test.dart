import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_marketplace_repository/dio_marketplace_repository.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioMarketplaceRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioMarketplaceRepository(httpClient: httpClient);
  });

  group('DioMarketplaceRepository', () {
    test('getCategories returns list of categories', () async {
      final mockResponse = HttpClientResponse(
        data: {
          'data': [
            {'id': '1', 'name': 'Electronics'},
            {'id': '2', 'name': 'Books'},
          ]
        },
        statusCode: 200,
      );

      when(() => httpClient.get('/api/marketplace/categories'))
          .thenAnswer((_) async => mockResponse);

      final categories = await repository.getCategories();

      expect(categories.length, 2);
      expect(categories[0].name, 'Electronics');
      expect(categories[1].id, '2');
    });

    test('getItems returns list of items', () async {
      final mockResponse = HttpClientResponse(
        data: {
          'data': [
            {
              'id': 'p1',
              'title': 'Smartphone',
              'price': 500.0,
              'stock_quantity': 10,
              'track_inventory': true,
            },
          ]
        },
        statusCode: 200,
      );

      when(() => httpClient.get(
            '/api/marketplace/items',
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => mockResponse);

      final items = await repository.getItems();

      expect(items.length, 1);
      expect(items[0].title, 'Smartphone');
      expect(items[0].price, 500.0);
      expect(items[0].trackInventory, isTrue);
    });

    test('getItemById returns item', () async {
      final mockResponse = HttpClientResponse(
        data: {
          'data': {
            'id': 'p1',
            'title': 'Smartphone',
            'price': 500.0,
          }
        },
        statusCode: 200,
      );

      when(() => httpClient.get('/api/marketplace/items/p1'))
          .thenAnswer((_) async => mockResponse);

      final item = await repository.getItemById('p1');

      expect(item.id, 'p1');
      expect(item.title, 'Smartphone');
    });

    test('placeOrder returns order', () async {
      final mockResponse = HttpClientResponse(
        data: {
          'data': {
            'id': 'o1',
            'order_number': 'ORD-123',
            'total': 1000.0,
            'status': 'pending',
            'created_at': DateTime.now().toIso8601String(),
            'items': [],
          }
        },
        statusCode: 200,
      );

      when(() => httpClient.post(
            '/api/marketplace/orders',
            data: any(named: 'data'),
          )).thenAnswer((_) async => mockResponse);

      final order = await repository.placeOrder(
        items: [ (itemId: 'p1', quantity: 2) ],
        deliveryAddress: 'Main St',
        deliveryPhone: '123456',
      );

      expect(order.id, 'o1');
      expect(order.orderNumber, 'ORD-123');
    });

    test('getOrders returns list of orders', () async {
      final mockResponse = HttpClientResponse(
        data: {
          'data': [
            {
              'id': 'o1',
              'order_number': 'ORD-123',
              'total': 1000.0,
              'status': 'pending',
              'created_at': DateTime.now().toIso8601String(),
              'items': [],
            },
          ]
        },
        statusCode: 200,
      );

      when(() => httpClient.get(
            '/api/marketplace/orders',
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => mockResponse);

      final orders = await repository.getOrders();

      expect(orders.length, 1);
      expect(orders[0].id, 'o1');
    });
  });
}
