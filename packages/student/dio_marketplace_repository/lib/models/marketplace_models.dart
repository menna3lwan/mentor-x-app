import 'package:student_core/student_core.dart';

abstract final class MarketplaceCategoryModel {
  static MarketplaceCategoryEntity fromJson(Map<String, dynamic> json) {
    return MarketplaceCategoryEntity(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
    );
  }
}

abstract final class MarketplaceItemModel {
  static MarketplaceItemEntity fromJson(Map<String, dynamic> json) {
    return MarketplaceItemEntity(
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

abstract final class MarketplaceOrderModel {
  static MarketplaceOrderEntity fromJson(Map<String, dynamic> json) {
    return MarketplaceOrderEntity(
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
