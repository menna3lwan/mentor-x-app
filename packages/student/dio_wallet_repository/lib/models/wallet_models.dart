import 'package:mentorx_core/mentorx_core.dart';

final class WalletSummaryModel extends WalletSummaryEntity {
  const WalletSummaryModel({
    required super.walletBalance,
    required super.points,
    super.spentThisMonth = 0,
    super.totalCreditsThisMonth = 0,
    super.totalTransactions = 0,
  });

  factory WalletSummaryModel.fromJson(Map<String, dynamic> json) {
    return WalletSummaryModel(
      walletBalance: _toDouble(json['walletBalance'] ?? json['wallet_balance']),
      points: _toInt(json['totalPoints'] ?? json['total_points'] ?? json['points']),
      spentThisMonth: _toDouble(json['spentThisMonth'] ?? json['spent_this_month']),
      totalCreditsThisMonth: _toDouble(
        json['totalCreditsThisMonth'] ?? json['total_credits_this_month'],
      ),
      totalTransactions: _toInt(
        json['totalTransactions'] ?? json['total_transactions'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'wallet_balance': walletBalance,
        'total_points': points,
        'spent_this_month': spentThisMonth,
        'total_credits_this_month': totalCreditsThisMonth,
        'total_transactions': totalTransactions,
      };

  factory WalletSummaryModel.fromEntity(WalletSummaryEntity entity) {
    return WalletSummaryModel(
      walletBalance: entity.walletBalance,
      points: entity.points,
      spentThisMonth: entity.spentThisMonth,
      totalCreditsThisMonth: entity.totalCreditsThisMonth,
      totalTransactions: entity.totalTransactions,
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
      createdAt: DateTime.tryParse(
            (json['createdAt'] ?? json['created_at'])?.toString() ?? '',
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': transactionType.name,
        'amount': amount,
        'balance_after': balanceAfter,
        'description': description,
        'created_at': createdAt.toIso8601String(),
      };

  factory WalletTransactionModel.fromEntity(WalletTransactionEntity entity) {
    return WalletTransactionModel(
      id: entity.id,
      transactionType: entity.transactionType,
      amount: entity.amount,
      balanceAfter: entity.balanceAfter,
      description: entity.description,
      createdAt: entity.createdAt,
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
      createdAt: DateTime.tryParse(
            (json['createdAt'] ?? json['created_at'])?.toString() ?? '',
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'currency': currency,
        'method': method.name,
        'type': paymentType.name,
        'status': status.name,
        'reference': reference,
        'expires_at': expiresAt?.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
      };

  factory PaymentModel.fromEntity(PaymentEntity entity) {
    return PaymentModel(
      id: entity.id,
      amount: entity.amount,
      currency: entity.currency,
      method: entity.method,
      paymentType: entity.paymentType,
      status: entity.status,
      reference: entity.reference,
      expiresAt: entity.expiresAt,
      createdAt: entity.createdAt,
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

final class PointsTransactionModel extends PointsTransactionEntity {
  const PointsTransactionModel({
    required super.id,
    required super.amount,
    required super.balanceAfter,
    required super.description,
    required super.createdAt,
    super.typeBadge,
  });

  factory PointsTransactionModel.fromJson(Map<String, dynamic> json) {
    return PointsTransactionModel(
      id: json['id']?.toString() ?? '',
      amount: _toInt(json['amount']),
      balanceAfter: _toInt(json['balanceAfter'] ?? json['balance_after']),
      description: (json['description'] ?? json['reason'] ?? '') as String,
      createdAt: DateTime.tryParse(
            (json['createdAt'] ?? json['created_at'])?.toString() ?? '',
          ) ??
          DateTime.now(),
      typeBadge:
          (json['typeBadge'] ?? json['type_badge'] ?? json['type'])?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'balance_after': balanceAfter,
        'description': description,
        'created_at': createdAt.toIso8601String(),
        'type_badge': typeBadge,
      };

  factory PointsTransactionModel.fromEntity(PointsTransactionEntity entity) {
    return PointsTransactionModel(
      id: entity.id,
      amount: entity.amount,
      balanceAfter: entity.balanceAfter,
      description: entity.description,
      createdAt: entity.createdAt,
      typeBadge: entity.typeBadge,
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
