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
      final list = response.asList();
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

      final list = response.asList();
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
      return MarketplaceItemModel.fromJson(response.asMap());
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

      return MarketplaceOrderModel.fromJson(response.asMap());
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

      final list = response.asList();
      return list.map((e) => MarketplaceOrderModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: MarketplaceRepositoryExceptionCode.failedToLoadOrders,
      );
    }
  }
}
