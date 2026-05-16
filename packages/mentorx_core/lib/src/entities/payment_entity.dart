part of 'package:mentorx_core/mentorx_core.dart';

enum PaymentMethod { vodafoneCash, fawry, instaPay, creditCard, wallet }

enum PaymentType { courseEnrollment, walletTopup }

enum PaymentStatus { pending, success, failed, expired, processing }

class PaymentEntity extends Equatable {
  final String? id;
  final bool success;
  final bool pending;
  final String? message;
  final String? orderNumber;
  final String? transactionId;
  final double amount;
  final String currency;
  final PaymentMethod method;
  final String? reference;
  final double? amountPaid;
  final int enrollmentsCreated;
  final String? redirectUrl;
  final double? originalAmount;
  final double? finalAmount;
  final double? discountAmount;

  const PaymentEntity({
    this.id,
    this.success = false,
    this.pending = false,
    this.message,
    this.orderNumber,
    this.transactionId,
    this.amount = 0.0,
    this.currency = 'EGP',
    this.method = PaymentMethod.wallet,
    this.reference,
    this.amountPaid,
    this.enrollmentsCreated = 0,
    this.redirectUrl,
    this.originalAmount,
    this.finalAmount,
    this.discountAmount,
  });

  static const placeholder = PaymentEntity();

  @override
  List<Object?> get props => [
        id,
        success,
        pending,
        message,
        orderNumber,
        transactionId,
        amount,
        currency,
        method,
        reference,
        amountPaid,
        enrollmentsCreated,
        redirectUrl,
        originalAmount,
        finalAmount,
        discountAmount,
      ];

  PaymentEntity copyWith({
    MentorXNullableValue<String?>? id,
    bool? success,
    bool? pending,
    MentorXNullableValue<String?>? message,
    MentorXNullableValue<String?>? orderNumber,
    MentorXNullableValue<String?>? transactionId,
    double? amount,
    String? currency,
    PaymentMethod? method,
    MentorXNullableValue<String?>? reference,
    MentorXNullableValue<double?>? amountPaid,
    int? enrollmentsCreated,
    MentorXNullableValue<String?>? redirectUrl,
    MentorXNullableValue<double?>? originalAmount,
    MentorXNullableValue<double?>? finalAmount,
    MentorXNullableValue<double?>? discountAmount,
  }) {
    return PaymentEntity(
      id: id != null ? id.value : this.id,
      success: success ?? this.success,
      pending: pending ?? this.pending,
      message: message != null ? message.value : this.message,
      orderNumber: orderNumber != null ? orderNumber.value : this.orderNumber,
      transactionId:
          transactionId != null ? transactionId.value : this.transactionId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      method: method ?? this.method,
      reference: reference != null ? reference.value : this.reference,
      amountPaid: amountPaid != null ? amountPaid.value : this.amountPaid,
      enrollmentsCreated: enrollmentsCreated ?? this.enrollmentsCreated,
      redirectUrl: redirectUrl != null ? redirectUrl.value : this.redirectUrl,
      originalAmount:
          originalAmount != null ? originalAmount.value : this.originalAmount,
      finalAmount: finalAmount != null ? finalAmount.value : this.finalAmount,
      discountAmount:
          discountAmount != null ? discountAmount.value : this.discountAmount,
    );
  }
}
