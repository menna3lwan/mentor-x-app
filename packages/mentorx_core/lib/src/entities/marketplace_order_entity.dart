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
  final String? studentId;
  final String? studentName;
  final double totalAmount;
  final double? subtotal;
  final double? discount;
  final double? tax;
  final String? formattedTotal;
  final String? paymentMethod;
  final MarketplaceOrderStatus status;
  final int itemCount;
  final String? deliveryAddress;
  final String? deliveryPhone;
  final String? deliveryNotes;
  final DateTime createdAt;
  final DateTime? paidAt;
  final List<MarketplaceOrderItemEntity>? items;

  const MarketplaceOrderEntity({
    required this.id,
    required this.orderNumber,
    this.studentId,
    this.studentName,
    required this.totalAmount,
    this.subtotal,
    this.discount,
    this.tax,
    this.formattedTotal,
    this.paymentMethod,
    required this.status,
    required this.createdAt,
    this.itemCount = 0,
    this.deliveryAddress,
    this.deliveryPhone,
    this.deliveryNotes,
    this.paidAt,
    this.items,
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
        studentId,
        studentName,
        totalAmount,
        subtotal,
        discount,
        tax,
        formattedTotal,
        paymentMethod,
        status,
        itemCount,
        deliveryAddress,
        deliveryPhone,
        deliveryNotes,
        createdAt,
        paidAt,
        items,
      ];

  MarketplaceOrderEntity copyWith({
    String? id,
    String? orderNumber,
    String? studentId,
    String? studentName,
    double? totalAmount,
    double? subtotal,
    double? discount,
    double? tax,
    String? formattedTotal,
    String? paymentMethod,
    MarketplaceOrderStatus? status,
    int? itemCount,
    String? deliveryAddress,
    String? deliveryPhone,
    String? deliveryNotes,
    DateTime? createdAt,
    DateTime? paidAt,
    List<MarketplaceOrderItemEntity>? items,
  }) {
    return MarketplaceOrderEntity(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      totalAmount: totalAmount ?? this.totalAmount,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      formattedTotal: formattedTotal ?? this.formattedTotal,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      itemCount: itemCount ?? this.itemCount,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryPhone: deliveryPhone ?? this.deliveryPhone,
      deliveryNotes: deliveryNotes ?? this.deliveryNotes,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt ?? this.paidAt,
      items: items ?? this.items,
    );
  }
}
