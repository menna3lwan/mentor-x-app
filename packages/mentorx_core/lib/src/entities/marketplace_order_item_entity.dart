part of 'package:mentorx_core/mentorx_core.dart';

class MarketplaceOrderItemEntity extends Equatable {
  final String id;
  final String? orderId;
  final String? productType;
  final String productId;
  final String? productName;
  final int quantity;
  final double unitPrice;
  final double subtotal;

  const MarketplaceOrderItemEntity({
    required this.id,
    this.orderId,
    this.productType,
    required this.productId,
    this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
  });

  static const placeholder = MarketplaceOrderItemEntity(
    id: '',
    productId: '',
    quantity: 0,
    unitPrice: 0.0,
    subtotal: 0.0,
  );

  @override
  List<Object?> get props => [
        id,
        orderId,
        productType,
        productId,
        productName,
        quantity,
        unitPrice,
        subtotal,
      ];

  MarketplaceOrderItemEntity copyWith({
    String? id,
    String? orderId,
    String? productType,
    String? productId,
    String? productName,
    int? quantity,
    double? unitPrice,
    double? subtotal,
  }) {
    return MarketplaceOrderItemEntity(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productType: productType ?? this.productType,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      subtotal: subtotal ?? this.subtotal,
    );
  }
}
