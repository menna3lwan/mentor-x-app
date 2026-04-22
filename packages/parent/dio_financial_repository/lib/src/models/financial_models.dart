import 'package:mentorx_core/mentorx_core.dart';

final class WalletTransactionModel extends WalletTransactionEntity {
  const WalletTransactionModel({
    required super.id,
    required super.transactionType,
    required super.amount,
    required super.balanceAfter,
    required super.description,
    required super.createdAt,
    super.typeBadge,
    super.paymentMethod,
  });

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      id: json['id']?.toString() ?? '',
      transactionType: WalletTransactionType.values.firstWhere(
        (e) => e.name == (json['type'] ?? 'deposit'),
        orElse: () => WalletTransactionType.deposit,
      ),
      amount: (json['amount'] ?? 0.0).toDouble(),
      balanceAfter: (json['balance_after'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at']) ?? DateTime.now()
          : DateTime.now(),
      typeBadge: json['type_badge'],
      paymentMethod: json['payment_method'],
    );
  }
}

final class WalletSummaryModel extends WalletSummaryEntity {
  const WalletSummaryModel({
    required super.walletBalance,
    required super.points,
    super.spentThisMonth = 0.0,
    super.totalCreditsThisMonth = 0.0,
    super.totalTransactions = 0,
  });

  factory WalletSummaryModel.fromJson(Map<String, dynamic> json) {
    return WalletSummaryModel(
      walletBalance: (json['wallet_balance'] ?? json['balance'] ?? 0.0).toDouble(),
      points: (json['points'] ?? json['total_points'] ?? 0).toInt(),
      spentThisMonth: (json['spent_this_month'] ?? 0.0).toDouble(),
      totalCreditsThisMonth: (json['total_credits_this_month'] ?? 0.0).toDouble(),
      totalTransactions: (json['total_transactions'] ?? 0).toInt(),
    );
  }
}

final class ParentWalletAnalyticsModel extends ParentWalletAnalyticsEntity {
  const ParentWalletAnalyticsModel({
    required super.monthlySpending,
    required super.categoryBreakdown,
  });

  factory ParentWalletAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return ParentWalletAnalyticsModel(
      monthlySpending: (json['monthly_spending'] as List? ?? [])
          .map((e) => MonthlySpendingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      categoryBreakdown: (json['category_breakdown'] as Map? ?? {})
          .map((k, v) => MapEntry(k.toString(), (v ?? 0.0).toDouble())),
    );
  }
}

final class MonthlySpendingModel extends MonthlySpendingEntry {
  const MonthlySpendingModel({
    required super.month,
    required super.amount,
  });

  factory MonthlySpendingModel.fromJson(Map<String, dynamic> json) {
    return MonthlySpendingModel(
      month: json['month'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
    );
  }
}

final class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.id,
    required super.amount,
    required super.method,
    required super.paymentType,
    required super.status,
    required super.createdAt,
    super.currency,
    super.reference,
    super.expiresAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id']?.toString() ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      currency: json['currency'] ?? 'EGP',
      status: PaymentStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'pending'),
        orElse: () => PaymentStatus.pending,
      ),
      method: PaymentMethod.values.firstWhere(
        (e) => e.name == (json['method'] ?? 'vodafoneCash'),
        orElse: () => PaymentMethod.vodafoneCash,
      ),
      paymentType: PaymentType.values.firstWhere(
        (e) => e.name == (json['payment_type'] ?? 'walletTopup'),
        orElse: () => PaymentType.walletTopup,
      ),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at']) ?? DateTime.now()
          : DateTime.now(),
      reference: json['reference'] ?? json['transaction_id'],
      expiresAt: json['expires_at'] != null ? DateTime.tryParse(json['expires_at']) : null,
    );
  }
}
