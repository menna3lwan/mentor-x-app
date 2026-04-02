import 'package:mentorx_core/mentorx_core.dart';

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
      price: _toDouble(json['price']),
      oldPrice: _toDoubleOrNull(json['oldPrice'] ?? json['old_price']),
      imageUrls:
          ((json['imageUrls'] ?? json['image_urls']) as List?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      isActive: _toBool(
        json['isActive'] ?? json['is_active'],
        defaultValue: true,
      ),
      isFeatured: _toBool(json['isFeatured'] ?? json['is_featured']),
      stockQuantity: _toInt(json['stockQuantity'] ?? json['stock_quantity']),
      categoryId: (json['categoryId'] ?? json['category_id'])?.toString(),
    );
  }
}

abstract final class MarketplaceOrderModel {
  static MarketplaceOrderEntity fromJson(Map<String, dynamic> json) {
    return MarketplaceOrderEntity(
      id: json['id']?.toString() ?? '',
      orderNumber:
          (json['orderNumber'] ?? json['order_number'])?.toString() ?? '',
      totalAmount: _toDouble(json['totalAmount'] ?? json['total_amount']),
      status: _parseStatus(json['status']),
      itemCount: _toInt(json['itemCount'] ?? json['item_count']),
      deliveryAddress: (json['deliveryAddress'] ?? json['delivery_address'])
          ?.toString(),
      deliveryPhone: (json['deliveryPhone'] ?? json['delivery_phone'])
          ?.toString(),
      deliveryNotes: (json['deliveryNotes'] ?? json['delivery_notes'])
          ?.toString(),
      createdAt:
          DateTime.tryParse(
            (json['createdAt'] ?? json['created_at'])?.toString() ?? '',
          ) ??
          DateTime.now(),
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

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

double _toDouble(dynamic value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

double? _toDoubleOrNull(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}

bool _toBool(dynamic value, {bool defaultValue = false}) {
  if (value is bool) return value;
  final normalized = value?.toString().toLowerCase();
  if (normalized == 'true' || normalized == '1') return true;
  if (normalized == 'false' || normalized == '0') return false;
  return defaultValue;
}
