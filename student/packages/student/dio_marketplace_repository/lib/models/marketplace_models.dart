import 'package:student_core/student_core.dart';

final class MarketplaceCategoryModel extends MarketplaceCategoryEntity {
  const MarketplaceCategoryModel({
    required super.id,
    required super.name,
  });

  factory MarketplaceCategoryModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceCategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
    );
  }
}

final class MarketplaceItemModel extends MarketplaceItemEntity {
  const MarketplaceItemModel({
    required super.id,
    required super.title,
    required super.price,
    super.description,
    super.oldPrice,
    super.imageUrls,
    super.isActive,
    super.isFeatured,
    super.stockQuantity,
    super.categoryId,
  });

  factory MarketplaceItemModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceItemModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      oldPrice: (json['oldPrice'] ?? json['old_price'] as num?)?.toDouble(),
      imageUrls: ((json['imageUrls'] ?? json['image_urls']) as List?)?.map((e) => e.toString()).toList() ?? const [],
      isActive: json['isActive'] as bool? ?? json['is_active'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? json['is_featured'] as bool? ?? false,
      stockQuantity: (json['stockQuantity'] ?? json['stock_quantity'] as num?)?.toInt() ?? 0,
      categoryId: (json['categoryId'] ?? json['category_id'])?.toString(),
    );
  }
}

final class MarketplaceOrderModel extends MarketplaceOrderEntity {
  const MarketplaceOrderModel({
    required super.id,
    required super.orderNumber,
    required super.totalAmount,
    required super.status,
    required super.createdAt,
    super.itemCount,
    super.deliveryAddress,
    super.deliveryPhone,
    super.deliveryNotes,
  });

  factory MarketplaceOrderModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceOrderModel(
      id: json['id']?.toString() ?? '',
      orderNumber: (json['orderNumber'] ?? json['order_number']) as String? ?? '',
      totalAmount: (json['totalAmount'] ?? json['total_amount'] as num?)?.toDouble() ?? 0.0,
      status: _parseStatus(json['status']),
      itemCount: (json['itemCount'] ?? json['item_count'] as num?)?.toInt() ?? 0,
      deliveryAddress: (json['deliveryAddress'] ?? json['delivery_address']) as String?,
      deliveryPhone: (json['deliveryPhone'] ?? json['delivery_phone']) as String?,
      deliveryNotes: (json['deliveryNotes'] ?? json['delivery_notes']) as String?,
      createdAt: DateTime.parse((json['createdAt'] ?? json['created_at']) as String),
    );
  }

  static MarketplaceOrderStatus _parseStatus(dynamic value) {
    final str = value?.toString().toLowerCase();
    return MarketplaceOrderStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => MarketplaceOrderStatus.pending,
    );
  }
}
