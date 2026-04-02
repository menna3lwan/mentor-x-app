import 'package:mentorx_core/mentorx_core.dart';

final class WalletSummaryModel extends WalletSummaryEntity {
  const WalletSummaryModel({
    required super.walletBalance,
    required super.points,
  });

  factory WalletSummaryModel.fromJson(Map<String, dynamic> json) {
    return WalletSummaryModel(
      walletBalance: _toDouble(json['walletBalance'] ?? json['wallet_balance']),
      points: _toInt(json['totalPoints'] ?? json['total_points']),
    );
  }
}

final class WalletTransactionModel extends WalletTransactionEntity {
  const WalletTransactionModel({
    required super.id,
    required super.transactionType,
    required super.amount,
    required super.balanceAfter,
    required super.description,
    required super.createdAt,
  });

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
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

final class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.id,
    required super.amount,
    required super.currency,
    required super.method,
    required super.paymentType,
    required super.status,
    super.reference,
    super.expiresAt,
    required super.createdAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
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

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

double _toDouble(dynamic value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}
