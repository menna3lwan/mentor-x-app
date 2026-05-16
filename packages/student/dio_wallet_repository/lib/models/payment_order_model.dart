import 'package:mentorx_core/mentorx_core.dart';

final class PaymentOrderModel extends PaymentOrderEntity {
  const PaymentOrderModel({
    required super.id,
    required super.orderNumber,
    required super.studentId,
    required super.studentName,
    required super.subtotal,
    required super.total,
    super.discount = 0.0,
    super.tax = 0.0,
    super.formattedTotal,
    super.currency = 'EGP',
    required super.status,
    super.paymentMethod,
    super.items = const [],
    required super.createdAt,
    super.paidAt,
  });

  factory PaymentOrderModel.fromJson(Map<String, dynamic> json) {
    return PaymentOrderModel(
      id: ModelParser.asString(json['id']),
      orderNumber: ModelParser.asString(
        json['orderNumber'] ?? json['order_number'],
      ),
      studentId: ModelParser.asString(json['studentId'] ?? json['student_id']),
      studentName: ModelParser.asString(
        json['studentName'] ?? json['student_name'],
      ),
      subtotal: ModelParser.asDouble(json['subtotal']),
      discount: ModelParser.asDouble(json['discount']),
      tax: ModelParser.asDouble(json['tax']),
      total: ModelParser.asDouble(json['total']),
      formattedTotal: ModelParser.asString(json['formattedTotal']),
      currency: ModelParser.asString(json['currency'], fallback: 'EGP'),
      status: _parseStatus(ModelParser.asString(json['status'])),
      paymentMethod: ModelParser.asString(
        json['paymentMethod'] ?? json['payment_method'],
        fallback: '',
      ),
      items: ModelParser.asList(json['items'])
          .map((e) => PaymentOrderItemModel.fromJson(ModelParser.asMap(e)))
          .toList(),
      createdAt:
          ModelParser.asDateTime(json['createdAt'] ?? json['created_at']) ??
          DateTime.now(),
      paidAt: ModelParser.asDateTime(json['paidAt'] ?? json['paid_at']),
    );
  }

  static PaymentOrderStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return PaymentOrderStatus.pending;
      case 'completed':
      case 'success':
      case 'paid':
        return PaymentOrderStatus.completed;
      case 'failed':
        return PaymentOrderStatus.failed;
      case 'cancelled':
        return PaymentOrderStatus.cancelled;
      case 'refunded':
        return PaymentOrderStatus.refunded;
      case 'processing':
        return PaymentOrderStatus.processing;
      case 'awaiting_approval':
        return PaymentOrderStatus.awaitingApproval;
      default:
        return PaymentOrderStatus.pending;
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'orderNumber': orderNumber,
    'studentId': studentId,
    'studentName': studentName,
    'subtotal': subtotal,
    'discount': discount,
    'tax': tax,
    'total': total,
    'formattedTotal': formattedTotal,
    'currency': currency,
    'status': status.name,
    'paymentMethod': paymentMethod,
    'createdAt': createdAt.toIso8601String(),
    'paidAt': paidAt?.toIso8601String(),
  };
}

final class PaymentOrderItemModel extends PaymentOrderItemEntity {
  const PaymentOrderItemModel({
    required super.productId,
    required super.productType,
    required super.productName,
    required super.unitPrice,
  });

  factory PaymentOrderItemModel.fromJson(Map<String, dynamic> json) {
    return PaymentOrderItemModel(
      productId: ModelParser.asString(json['productId'] ?? json['product_id']),
      productType: ModelParser.asString(
        json['productType'] ?? json['product_type'],
      ),
      productName: ModelParser.asString(
        json['productName'] ?? json['product_name'],
      ),
      unitPrice: ModelParser.asDouble(json['unitPrice'] ?? json['unit_price']),
    );
  }
}
