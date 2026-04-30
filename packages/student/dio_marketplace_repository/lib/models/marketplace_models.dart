import 'package:mentorx_core/mentorx_core.dart';

final class MarketplaceCategoryModel extends MarketplaceCategoryEntity {
  const MarketplaceCategoryModel({
    required super.id,
    required super.name,
  });

  factory MarketplaceCategoryModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceCategoryModel(
      id: ModelParser.asString(json['id']),
      name: ModelParser.asString(json['name']),
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
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title']),
      price: ModelParser.asDouble(json['price']),
      description: ModelParser.asString(json['description']),
      oldPrice: ModelParser.asDouble(json['oldPrice'] ?? json['old_price']),
      imageUrls: ModelParser.asList(json['imageUrls'] ?? json['image_urls'])
          .map((e) => e.toString())
          .toList(),
      isActive: ModelParser.asBool(json['isActive'] ?? json['is_active'], fallback: true),
      isFeatured: ModelParser.asBool(json['isFeatured'] ?? json['is_featured']),
      stockQuantity: ModelParser.asInt(json['stockQuantity'] ?? json['stock_quantity']),
      categoryId: ModelParser.asString(json['categoryId'] ?? json['category_id']),
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
    super.studentId,
    super.studentName,
    required super.totalAmount,
    super.subtotal,
    super.discount,
    super.tax,
    super.formattedTotal,
    super.paymentMethod,
    required super.status,
    required super.createdAt,
    super.itemCount = 0,
    super.deliveryAddress,
    super.deliveryPhone,
    super.deliveryNotes,
    super.paidAt,
    super.items,
  });

  factory MarketplaceOrderModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceOrderModel(
      id: ModelParser.asString(json['id']),
      orderNumber: ModelParser.asString(json['orderNumber'] ?? json['order_number']),
      studentId: ModelParser.asString(json['studentId'] ?? json['student_id']),
      studentName: ModelParser.asString(json['studentName'] ?? json['student_name']),
      totalAmount: ModelParser.asDouble(json['total'] ?? json['totalAmount'] ?? json['total_amount']),
      subtotal: ModelParser.asDouble(json['subtotal']),
      discount: ModelParser.asDouble(json['discount']),
      tax: ModelParser.asDouble(json['tax']),
      formattedTotal: ModelParser.asString(json['formattedTotal'] ?? json['formatted_total']),
      paymentMethod: ModelParser.asString(json['paymentMethod'] ?? json['payment_method']),
      status: _parseStatus(json['status']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']) ?? DateTime.now(),
      paidAt: ModelParser.asDateTime(json['paidAt'] ?? json['paid_at']),
      itemCount: ModelParser.asInt(json['itemCount'] ?? json['item_count']),
      deliveryAddress: ModelParser.asString(json['deliveryAddress'] ?? json['delivery_address']),
      deliveryPhone: ModelParser.asString(json['deliveryPhone'] ?? json['delivery_phone']),
      deliveryNotes: ModelParser.asString(json['deliveryNotes'] ?? json['delivery_notes']),
      items: ModelParser.asList(json['items'])
          .map((e) => MarketplaceOrderItemModel.fromJson(ModelParser.asMap(e)))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_number': orderNumber,
        'student_id': studentId,
        'total': totalAmount,
        'status': status.name,
        'created_at': createdAt.toIso8601String(),
        'paid_at': paidAt?.toIso8601String(),
        'items': items?.map((e) => MarketplaceOrderItemModel.fromEntity(e).toJson()).toList(),
      };

  factory MarketplaceOrderModel.fromEntity(MarketplaceOrderEntity entity) {
    return MarketplaceOrderModel(
      id: entity.id,
      orderNumber: entity.orderNumber,
      studentId: entity.studentId,
      studentName: entity.studentName,
      totalAmount: entity.totalAmount,
      subtotal: entity.subtotal,
      discount: entity.discount,
      tax: entity.tax,
      formattedTotal: entity.formattedTotal,
      paymentMethod: entity.paymentMethod,
      status: entity.status,
      createdAt: entity.createdAt,
      paidAt: entity.paidAt,
      itemCount: entity.itemCount,
      deliveryAddress: entity.deliveryAddress,
      deliveryPhone: entity.deliveryPhone,
      deliveryNotes: entity.deliveryNotes,
      items: entity.items,
    );
  }

  static MarketplaceOrderStatus _parseStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    return MarketplaceOrderStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => MarketplaceOrderStatus.pending,
    );
  }
}

final class MarketplaceOrderItemModel extends MarketplaceOrderItemEntity {
  const MarketplaceOrderItemModel({
    required super.id,
    super.orderId,
    super.productType,
    required super.productId,
    super.productName,
    required super.quantity,
    required super.unitPrice,
    required super.subtotal,
  });

  factory MarketplaceOrderItemModel.fromJson(Map<String, dynamic> json) {
    return MarketplaceOrderItemModel(
      id: ModelParser.asString(json['id']),
      orderId: ModelParser.asString(json['orderId'] ?? json['order_id']),
      productType: ModelParser.asString(json['productType'] ?? json['product_type']),
      productId: ModelParser.asString(json['productId'] ?? json['product_id'] ?? json['itemId']),
      productName: ModelParser.asString(json['productName'] ?? json['product_name'] ?? json['itemTitle']),
      quantity: ModelParser.asInt(json['quantity']),
      unitPrice: ModelParser.asDouble(json['unitPrice'] ?? json['unit_price']),
      subtotal: ModelParser.asDouble(json['subtotal'] ?? json['totalPrice'] ?? json['total_price']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_id': orderId,
        'product_type': productType,
        'product_id': productId,
        'product_name': productName,
        'quantity': quantity,
        'unit_price': unitPrice,
        'subtotal': subtotal,
      };

  factory MarketplaceOrderItemModel.fromEntity(MarketplaceOrderItemEntity entity) {
    return MarketplaceOrderItemModel(
      id: entity.id,
      orderId: entity.orderId,
      productType: entity.productType,
      productId: entity.productId,
      productName: entity.productName,
      quantity: entity.quantity,
      unitPrice: entity.unitPrice,
      subtotal: entity.subtotal,
    );
  }
}
