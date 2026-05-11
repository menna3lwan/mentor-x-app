part of 'package:mentorx_core/mentorx_core.dart';

enum PaymentOrderStatus {
  pending,
  completed,
  failed,
  cancelled,
  refunded,
}

class PaymentOrderEntity extends Equatable {
  final String id;
  final String orderNumber;
  final double amount;
  final String currency;
  final PaymentOrderStatus status;
  final String? description;
  final String? paymentMethod;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const PaymentOrderEntity({
    required this.id,
    required this.orderNumber,
    required this.amount,
    this.currency = 'EGP',
    required this.status,
    this.description,
    this.paymentMethod,
    required this.createdAt,
    this.updatedAt,
  });

  static final placeholder = PaymentOrderEntity(
    id: '',
    orderNumber: '',
    amount: 0.0,
    status: PaymentOrderStatus.pending,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        amount,
        currency,
        status,
        description,
        paymentMethod,
        createdAt,
        updatedAt,
      ];

  PaymentOrderEntity copyWith({
    String? id,
    String? orderNumber,
    double? amount,
    String? currency,
    PaymentOrderStatus? status,
    String? description,
    String? paymentMethod,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PaymentOrderEntity(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      description: description ?? this.description,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
