part of '../mentorx_core.dart';

enum PaymentMethod { vodafoneCash, instapay, fawry }

enum PaymentType { walletTopup, coursePurchase, marketplace }

enum PaymentStatus { pending, completed, failed, refunded }

final class PaymentEntity extends Equatable {
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
}
