part of 'package:mentorx_core/mentorx_core.dart';

enum PaymentMethod { vodafoneCash, fawry, instaPay, creditCard, wallet }

enum PaymentType { courseEnrollment, walletTopup }

enum PaymentStatus { pending, success, failed, expired, processing }

base class PaymentEntity extends Equatable {
  final String id;
  final double amount;
  final String currency;
  final PaymentMethod method;
  final PaymentType paymentType;
  final PaymentStatus status;
  final String? reference;
  final DateTime? expiresAt;
  final DateTime createdAt;

  const PaymentEntity({
    required this.id,
    required this.amount,
    required this.method,
    required this.paymentType,
    required this.status,
    required this.createdAt,
    this.currency = 'EGP',
    this.reference,
    this.expiresAt,
  });

  static final placeholder = PaymentEntity(
    id: '',
    amount: 0.0,
    method: PaymentMethod.vodafoneCash,
    paymentType: PaymentType.walletTopup,
    status: PaymentStatus.pending,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        amount,
        currency,
        method,
        paymentType,
        status,
        reference,
        expiresAt,
        createdAt,
      ];

  PaymentEntity copyWith({
    String? id,
    double? amount,
    String? currency,
    PaymentMethod? method,
    PaymentType? paymentType,
    PaymentStatus? status,
    String? reference,
    DateTime? expiresAt,
    DateTime? createdAt,
  }) {
    return PaymentEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      method: method ?? this.method,
      paymentType: paymentType ?? this.paymentType,
      status: status ?? this.status,
      reference: reference ?? this.reference,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
