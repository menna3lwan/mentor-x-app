import 'package:mentorx_core/mentorx_core.dart';

final class PaymentOrderModel extends PaymentOrderEntity {
  const PaymentOrderModel({
    required super.id,
    required super.orderNumber,
    required super.amount,
    super.currency,
    required super.status,
    super.description,
    super.paymentMethod,
    required super.createdAt,
    super.updatedAt,
  });

  factory PaymentOrderModel.fromJson(Map<String, dynamic> json) {
    return PaymentOrderModel(
      id: ModelParser.asString(json['id']),
      orderNumber: ModelParser.asString(json['orderNumber'] ?? json['order_number']),
      amount: ModelParser.asDouble(json['amount']),
      currency: ModelParser.asString(json['currency'], fallback: 'EGP'),
      status: _parseStatus(ModelParser.asString(json['status'])),
      description: ModelParser.asString(json['description'], fallback: ''), // Entity allows null, but ModelParser.asString defaults to ''
      paymentMethod: ModelParser.asString(json['paymentMethod'] ?? json['payment_method'], fallback: ''),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']) ?? DateTime.now(),
      updatedAt: ModelParser.asDateTime(json['updatedAt'] ?? json['updated_at']),
    );
  }

  static PaymentOrderStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return PaymentOrderStatus.pending;
      case 'completed':
      case 'success':
        return PaymentOrderStatus.completed;
      case 'failed':
        return PaymentOrderStatus.failed;
      case 'cancelled':
        return PaymentOrderStatus.cancelled;
      case 'refunded':
        return PaymentOrderStatus.refunded;
      default:
        return PaymentOrderStatus.pending;
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderNumber': orderNumber,
        'amount': amount,
        'currency': currency,
        'status': status.name,
        'description': description,
        'paymentMethod': paymentMethod,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
