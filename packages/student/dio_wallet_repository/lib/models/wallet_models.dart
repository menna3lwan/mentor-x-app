import 'package:mentorx_core/mentorx_core.dart';

abstract final class WalletTransactionModel {
  static WalletTransactionEntity fromJson(Map<String, dynamic> json) {
    return WalletTransactionEntity(
      id: json['id']?.toString() ?? '',
      transactionType: _parseType(
        json['transactionType'] ?? json['type'] ?? json['transaction_type'],
      ),
      amount: _toDouble(json['amount']),
      balanceAfter: _toDouble(json['balanceAfter'] ?? json['balance_after']),
      description: (json['description'] ?? json['reason'] ?? '') as String,
      createdAt:
          DateTime.tryParse(
            (json['createdAt'] ?? json['created_at'])?.toString() ?? '',
          ) ??
          DateTime.now(),
    );
  }

  static WalletTransactionType _parseType(dynamic value) {
    final str = value?.toString().toLowerCase();
    return WalletTransactionType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => WalletTransactionType.deposit,
    );
  }
}

abstract final class PaymentModel {
  static PaymentEntity fromJson(Map<String, dynamic> json) {
    return PaymentEntity(
      id: json['id']?.toString() ?? '',
      amount: _toDouble(json['amount']),
      currency: json['currency'] as String? ?? 'EGP',
      method: _parseMethod(json['method'] ?? json['payment_method']),
      paymentType: _parseType(
        json['type'] ?? json['paymentType'] ?? json['payment_type'],
      ),
      status: _parseStatus(json['status']),
      reference:
          (json['reference'] ??
                  json['payment_reference'] ??
                  json['external_id'])
              ?.toString(),
      expiresAt: DateTime.tryParse(
        (json['expiresAt'] ?? json['expires_at'])?.toString() ?? '',
      ),
      createdAt:
          DateTime.tryParse(
            (json['createdAt'] ?? json['created_at'])?.toString() ?? '',
          ) ??
          DateTime.now(),
    );
  }

  static PaymentStatus _parseStatus(dynamic value) {
    final str = value?.toString().toLowerCase();
    return PaymentStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => PaymentStatus.pending,
    );
  }

  static PaymentMethod _parseMethod(dynamic value) {
    final str = value?.toString().toLowerCase();
    return PaymentMethod.values.firstWhere(
      (e) => e.name == str,
      orElse: () => PaymentMethod.vodafoneCash,
    );
  }

  static PaymentType _parseType(dynamic value) {
    final str = value?.toString().toLowerCase();
    if (str == 'topup' || str == 'deposit') return PaymentType.walletTopup;
    return PaymentType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => PaymentType.walletTopup,
    );
  }
}

double _toDouble(dynamic value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}
