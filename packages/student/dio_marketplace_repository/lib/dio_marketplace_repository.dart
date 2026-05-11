import 'package:mentorx_core/mentorx_core.dart';
import 'models/marketplace_models.dart';
export 'models/marketplace_models.dart';

final class DioMarketplaceRepository
    extends HttpClientRepository<MarketplaceRepositoryExceptionCode>
    implements MarketplaceRepository {
  @override
  Never throwException(
    MarketplaceRepositoryExceptionCode code, {
    String? message,
  }) => throw MarketplaceRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioMarketplaceRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<MarketplaceCategoryEntity>> getCategories() async {
    try {
      final response = await httpClient.get('/api/marketplace/categories');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list
          .map((e) => MarketplaceCategoryModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: MarketplaceRepositoryExceptionCode.failedToLoadCategories,
      );
    }
  }

  @override
  Future<List<MarketplaceItemEntity>> getItems({
    String? categoryId,
    String? search,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final queryParams = {
        if (categoryId != null) 'category_id': categoryId,
        if (search != null) 'search': search,
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/marketplace/items',
        queryParameters: queryParams,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list.map((e) => MarketplaceItemModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: MarketplaceRepositoryExceptionCode.failedToLoadItems,
      );
    }
  }

  @override
  Future<MarketplaceItemEntity> getItemById(String itemId) async {
    try {
      final response = await httpClient.get('/api/marketplace/items/$itemId');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return MarketplaceItemModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: MarketplaceRepositoryExceptionCode.failedToLoadItems,
      );
    }
  }

  @override
  Future<MarketplaceOrderEntity> placeOrder({
    required List<({String itemId, int quantity})> items,
    required String deliveryAddress,
    required String deliveryPhone,
    String? deliveryNotes,
  }) async {
    try {
      final payload = {
        'items': items
            .map((e) => {'item_id': e.itemId, 'quantity': e.quantity})
            .toList(),
        'delivery_address': deliveryAddress,
        'delivery_phone': deliveryPhone,
        if (deliveryNotes != null) 'delivery_notes': deliveryNotes,
      };

      final response = await httpClient.post(
        '/api/marketplace/orders',
        data: payload,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return MarketplaceOrderModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: MarketplaceRepositoryExceptionCode.failedToPlaceOrder,
      );
    }
  }

  @override
  Future<List<MarketplaceOrderEntity>> getOrders({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final queryParams = {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      };

      final response = await httpClient.get(
        '/api/marketplace/orders',
        queryParameters: queryParams,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final list = asList(data is Map ? data['content'] : data);
      return list.map((e) => MarketplaceOrderModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: MarketplaceRepositoryExceptionCode.failedToLoadOrders,
      );
    }
  }
}
