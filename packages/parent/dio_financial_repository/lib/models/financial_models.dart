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
      id: ModelParser.asString(json['id']),
      transactionType: WalletTransactionType.values.firstWhere(
        (e) => e.name == ModelParser.asString(json['type'] ?? json['transaction_type'], fallback: 'deposit'),
        orElse: () => WalletTransactionType.deposit,
      ),
      amount: ModelParser.asDouble(json['amount']),
      balanceAfter: ModelParser.asDouble(json['balance_after'] ?? json['balanceAfter']),
      description: ModelParser.asString(json['description']),
      createdAt: ModelParser.asDateTime(json['created_at'] ?? json['createdAt']) ?? DateTime.now(),
      typeBadge: ModelParser.asString(json['type_badge'] ?? json['typeBadge']),
      paymentMethod: ModelParser.asString(json['payment_method'] ?? json['paymentMethod']),
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
      walletBalance: ModelParser.asDouble(json['wallet_balance'] ?? json['balance'] ?? json['walletBalance']),
      points: ModelParser.asInt(json['points'] ?? json['total_points'] ?? json['totalPoints']),
      spentThisMonth: ModelParser.asDouble(json['spent_this_month'] ?? json['spentThisMonth']),
      totalCreditsThisMonth: ModelParser.asDouble(json['total_credits_this_month'] ?? json['totalCreditsThisMonth']),
      totalTransactions: ModelParser.asInt(json['total_transactions'] ?? json['totalTransactions']),
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
      monthlySpending: ModelParser.asList(json['monthly_spending'] ?? json['monthlySpending'])
          .map((e) => MonthlySpendingModel.fromJson(ModelParser.asMap(e)))
          .toList(),
      categoryBreakdown: ModelParser.asMap(json['category_breakdown'] ?? json['categoryBreakdown'])
          .map((k, v) => MapEntry(k.toString(), ModelParser.asDouble(v))),
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
      month: ModelParser.asString(json['month']),
      amount: ModelParser.asDouble(json['amount']),
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
      id: ModelParser.asString(json['id']),
      amount: ModelParser.asDouble(json['amount']),
      currency: ModelParser.asString(json['currency'], fallback: 'EGP'),
      status: PaymentStatus.values.firstWhere(
        (e) => e.name == ModelParser.asString(json['status'], fallback: 'pending'),
        orElse: () => PaymentStatus.pending,
      ),
      method: PaymentMethod.values.firstWhere(
        (e) => e.name == ModelParser.asString(json['method'] ?? json['payment_method'], fallback: 'vodafoneCash'),
        orElse: () => PaymentMethod.vodafoneCash,
      ),
      paymentType: PaymentType.values.firstWhere(
        (e) => e.name == ModelParser.asString(json['payment_type'] ?? json['paymentType'], fallback: 'walletTopup'),
        orElse: () => PaymentType.walletTopup,
      ),
      createdAt: ModelParser.asDateTime(json['created_at'] ?? json['createdAt']) ?? DateTime.now(),
      reference: ModelParser.asString(json['reference'] ?? json['transaction_id']),
      expiresAt: ModelParser.asDateTime(json['expires_at'] ?? json['expiresAt']),
    );
  }
}
