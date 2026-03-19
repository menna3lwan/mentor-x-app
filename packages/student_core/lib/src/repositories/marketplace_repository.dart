part of '../../student_core.dart';

enum MarketplaceRepositoryExceptionCode {
  unknown,
  failedToLoadCategories,
  failedToLoadItems,
  failedToPlaceOrder,
  failedToLoadOrders,
}

final class MarketplaceRepositoryException
    extends MentorXException<MarketplaceRepositoryExceptionCode> {
  const MarketplaceRepositoryException({required super.code, super.message});
}

abstract interface class MarketplaceRepository {
  Future<void> initialize();
  /// Fetch marketplace product categories.
  Future<List<MarketplaceCategoryEntity>> getCategories();

  /// Fetch marketplace items with optional filters and pagination.
  Future<List<MarketplaceItemEntity>> getItems({
    String? categoryId,
    String? search,
    MentorXPaginationInfo? paginationInfo,
  });

  /// Place an order.
  Future<MarketplaceOrderEntity> placeOrder({
    required List<({String itemId, int quantity})> items,
    required String deliveryAddress,
    required String deliveryPhone,
    String? deliveryNotes,
  });

  /// Fetch order history.
  Future<List<MarketplaceOrderEntity>> getOrders({
    MentorXPaginationInfo? paginationInfo,
  });
}
