import 'package:mentorx_core/mentorx_core.dart';

final class MarketplaceCategoryModel extends MarketplaceCategoryEntity {
  const MarketplaceCategoryModel({
    required super.id,
    required super.name,
  });

  factory MarketplaceCategoryModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceCategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  factory MarketplaceCategoryModel.fromEntity(MarketplaceCategoryEntity entity) {
    return MarketplaceCategoryModel(
      id: entity.id,
      name: entity.name,
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
    super.imageUrls = const [],
    super.isActive = true,
    super.isFeatured = false,
    super.stockQuantity = 0,
    super.categoryId,
  });

  factory MarketplaceItemModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceItemModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      description: json['description'],
      oldPrice: json['old_price'] != null ? (json['old_price'] as num).toDouble() : null,
      imageUrls: (json['image_urls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      isActive: json['is_active'] ?? true,
      isFeatured: json['is_featured'] ?? false,
      stockQuantity: (json['stock_quantity'] ?? 0).toInt(),
      categoryId: json['category_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'old_price': oldPrice,
        'image_urls': imageUrls,
        'is_active': isActive,
        'is_featured': isFeatured,
        'stock_quantity': stockQuantity,
        'category_id': categoryId,
      };

  factory MarketplaceItemModel.fromEntity(MarketplaceItemEntity entity) {
    return MarketplaceItemModel(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      description: entity.description,
      oldPrice: entity.oldPrice,
      imageUrls: entity.imageUrls,
      isActive: entity.isActive,
      isFeatured: entity.isFeatured,
      stockQuantity: entity.stockQuantity,
      categoryId: entity.categoryId,
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
    super.itemCount = 0,
    super.deliveryAddress,
    super.deliveryPhone,
    super.deliveryNotes,
  });

  factory MarketplaceOrderModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceOrderModel(
      id: json['id']?.toString() ?? '',
      orderNumber: json['order_number'] ?? '',
      totalAmount: (json['total_amount'] ?? 0.0).toDouble(),
      status: MarketplaceOrderStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'pending'),
        orElse: () => MarketplaceOrderStatus.pending,
      ),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      itemCount: (json['item_count'] ?? 0).toInt(),
      deliveryAddress: json['delivery_address'],
      deliveryPhone: json['delivery_phone'],
      deliveryNotes: json['delivery_notes'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_number': orderNumber,
        'total_amount': totalAmount,
        'status': status.name,
        'created_at': createdAt.toIso8601String(),
        'item_count': itemCount,
        'delivery_address': deliveryAddress,
        'delivery_phone': deliveryPhone,
        'delivery_notes': deliveryNotes,
      };

  factory MarketplaceOrderModel.fromEntity(MarketplaceOrderEntity entity) {
    return MarketplaceOrderModel(
      id: entity.id,
      orderNumber: entity.orderNumber,
      totalAmount: entity.totalAmount,
      status: entity.status,
      createdAt: entity.createdAt,
      itemCount: entity.itemCount,
      deliveryAddress: entity.deliveryAddress,
      deliveryPhone: entity.deliveryPhone,
      deliveryNotes: entity.deliveryNotes,
    );
  }
}
