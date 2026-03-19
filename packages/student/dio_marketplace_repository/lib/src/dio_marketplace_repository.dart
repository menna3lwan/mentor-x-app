import 'package:student_core/student_core.dart';
import '../models/marketplace_models.dart';

final class DioMarketplaceRepository
    extends HttpClientRepository<MarketplaceRepositoryExceptionCode>
    implements MarketplaceRepository {
  @override
  Never throwException(MarketplaceRepositoryExceptionCode code,
          {String? message}) =>
      throw MarketplaceRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioMarketplaceRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<MarketplaceCategoryEntity>> getCategories() async {
    final response = await httpClient.get('/api/marketplace/categories');

    if (response.statusCode != 200) {
      throw MarketplaceRepositoryException(
        code: MarketplaceRepositoryExceptionCode.failedToLoadCategories,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => MarketplaceCategoryModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<List<MarketplaceItemEntity>> getItems({
    String? categoryId,
    String? search,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    final response = await httpClient.get(
      '/api/marketplace/items',
      queryParameters: {
        if (categoryId != null) 'category_id': categoryId,
        if (search != null) 'search': search,
        if (paginationInfo?.page != null) 'page': paginationInfo!.page,
        if (paginationInfo?.limit != null) 'limit': paginationInfo!.limit,
        if (paginationInfo?.cursor != null) 'cursor': paginationInfo!.cursor,
      },
    );

    if (response.statusCode != 200) {
      throw MarketplaceRepositoryException(
        code: MarketplaceRepositoryExceptionCode.failedToLoadItems,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => MarketplaceItemModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<MarketplaceOrderEntity> placeOrder({
    required List<({String itemId, int quantity})> items,
    required String deliveryAddress,
    required String deliveryPhone,
    String? deliveryNotes,
  }) async {
    final response = await httpClient.post(
      '/api/marketplace/orders',
      data: {
        'items': items.map((e) => {'item_id': e.itemId, 'quantity': e.quantity}).toList(),
        'delivery_address': deliveryAddress,
        'delivery_phone': deliveryPhone,
        if (deliveryNotes != null) 'delivery_notes': deliveryNotes,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw MarketplaceRepositoryException(
        code: MarketplaceRepositoryExceptionCode.failedToPlaceOrder,
        message: response.exception?.message,
      );
    }

    return MarketplaceOrderModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<List<MarketplaceOrderEntity>> getOrders({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    final response = await httpClient.get(
      '/api/marketplace/orders',
      queryParameters: {
        if (paginationInfo?.page != null) 'page': paginationInfo!.page,
        if (paginationInfo?.limit != null) 'limit': paginationInfo!.limit,
        if (paginationInfo?.cursor != null) 'cursor': paginationInfo!.cursor,
      },
    );

    if (response.statusCode != 200) {
      throw MarketplaceRepositoryException(
        code: MarketplaceRepositoryExceptionCode.failedToLoadOrders,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => MarketplaceOrderModel.fromJson(e)).toList();
    }
    return [];
  }
}
