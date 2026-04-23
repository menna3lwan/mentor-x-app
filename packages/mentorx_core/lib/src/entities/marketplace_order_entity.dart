part of 'package:mentorx_core/mentorx_core.dart';

enum MarketplaceOrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
}

class MarketplaceOrderEntity extends Equatable {
  final String id;
  final String orderNumber;
  final double totalAmount;
  final MarketplaceOrderStatus status;
  final int itemCount;
  final String? deliveryAddress;
  final String? deliveryPhone;
  final String? deliveryNotes;
  final DateTime createdAt;

  const MarketplaceOrderEntity({
    required this.id,
    required this.orderNumber,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    this.itemCount = 0,
    this.deliveryAddress,
    this.deliveryPhone,
    this.deliveryNotes,
  });

  static final placeholder = MarketplaceOrderEntity(
    id: '',
    orderNumber: '',
    totalAmount: 0.0,
    status: MarketplaceOrderStatus.pending,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        totalAmount,
        status,
        itemCount,
        deliveryAddress,
        deliveryPhone,
        deliveryNotes,
        createdAt,
      ];

  MarketplaceOrderEntity copyWith({
    String? id,
    String? orderNumber,
    double? totalAmount,
    MarketplaceOrderStatus? status,
    int? itemCount,
    String? deliveryAddress,
    String? deliveryPhone,
    String? deliveryNotes,
    DateTime? createdAt,
  }) {
    return MarketplaceOrderEntity(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      itemCount: itemCount ?? this.itemCount,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryPhone: deliveryPhone ?? this.deliveryPhone,
      deliveryNotes: deliveryNotes ?? this.deliveryNotes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
