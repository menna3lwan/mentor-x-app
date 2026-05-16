part of 'package:mentorx_core/mentorx_core.dart';

enum PaymentOrderStatus {
  pending,
  completed,
  failed,
  cancelled,
  refunded,
  processing,
  awaitingApproval,
}

class PaymentOrderEntity extends Equatable {
  final String id;
  final String orderNumber;
  final String studentId;
  final String studentName;
  final double subtotal;
  final double discount;
  final double tax;
  final double total;
  final String? formattedTotal;
  final String currency;
  final PaymentOrderStatus status;
  final String? paymentMethod;
  final List<PaymentOrderItemEntity> items;
  final DateTime createdAt;
  final DateTime? paidAt;

  const PaymentOrderEntity({
    required this.id,
    required this.orderNumber,
    required this.studentId,
    required this.studentName,
    required this.subtotal,
    required this.total,
    this.discount = 0.0,
    this.tax = 0.0,
    this.formattedTotal,
    this.currency = 'EGP',
    required this.status,
    this.paymentMethod,
    this.items = const [],
    required this.createdAt,
    this.paidAt,
  });

  static final placeholder = PaymentOrderEntity(
    id: '',
    orderNumber: '',
    studentId: '',
    studentName: '',
    subtotal: 0.0,
    total: 0.0,
    status: PaymentOrderStatus.pending,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        studentId,
        studentName,
        subtotal,
        discount,
        tax,
        total,
        formattedTotal,
        currency,
        status,
        paymentMethod,
        items,
        createdAt,
        paidAt,
      ];

  PaymentOrderEntity copyWith({
    String? id,
    String? orderNumber,
    String? studentId,
    String? studentName,
    double? subtotal,
    double? discount,
    double? tax,
    double? total,
    MentorXNullableValue<String?>? formattedTotal,
    String? currency,
    PaymentOrderStatus? status,
    MentorXNullableValue<String?>? paymentMethod,
    List<PaymentOrderItemEntity>? items,
    DateTime? createdAt,
    MentorXNullableValue<DateTime?>? paidAt,
  }) {
    return PaymentOrderEntity(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      formattedTotal:
          formattedTotal != null ? formattedTotal.value : this.formattedTotal,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      paymentMethod:
          paymentMethod != null ? paymentMethod.value : this.paymentMethod,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt != null ? paidAt.value : this.paidAt,
    );
  }
}

class PaymentOrderItemEntity extends Equatable {
  final String productId;
  final String productType; // COURSE, CATEGORY
  final String productName;
  final double unitPrice;

  const PaymentOrderItemEntity({
    required this.productId,
    required this.productType,
    required this.productName,
    required this.unitPrice,
  });

  @override
  List<Object?> get props => [productId, productType, productName, unitPrice];
}
