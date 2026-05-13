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
      transactionType: _parseType(json['type'] ?? json['transaction_type']),
      amount: ModelParser.asDouble(json['amount']),
      balanceAfter: ModelParser.asDouble(json['balance_after'] ?? json['balanceAfter']),
      description: ModelParser.asString(json['description'] ?? json['reason']),
      createdAt: ModelParser.asDateTime(json['created_at'] ?? json['createdAt']) ?? DateTime.now(),
      typeBadge: ModelParser.asString(json['type_badge'] ?? json['typeBadge'] ?? json['type']),
      paymentMethod: ModelParser.asString(json['payment_method'] ?? json['paymentMethod']),
    );
  }

  static WalletTransactionType _parseType(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    if (str == 'payment' || str == 'purchase') return WalletTransactionType.payment;
    if (str == 'deposit' || str == 'credit') return WalletTransactionType.deposit;
    if (str == 'withdrawal' || str == 'debit') return WalletTransactionType.withdrawal;
    if (str == 'refund') return WalletTransactionType.refund;

    return WalletTransactionType.values.firstWhere(
      (e) => e.name.toLowerCase() == str,
      orElse: () => WalletTransactionType.deposit,
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
      walletBalance: ModelParser.asDouble(json['balance'] ?? json['wallet_balance'] ?? json['walletBalance']),
      points: ModelParser.asInt(json['totalPoints'] ?? json['points'] ?? json['total_points']),
      spentThisMonth: ModelParser.asDouble(json['spentThisMonth'] ?? json['spent_this_month']),
      totalCreditsThisMonth: ModelParser.asDouble(json['totalCreditsThisMonth'] ?? json['total_credits_this_month']),
      totalTransactions: ModelParser.asInt(json['totalTransactions'] ?? json['total_transactions']),
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
      status: _parseStatus(json['status']),
      method: _parseMethod(json['method'] ?? json['payment_method']),
      paymentType: _parsePaymentType(json['type'] ?? json['paymentType']),
      createdAt: ModelParser.asDateTime(json['created_at'] ?? json['createdAt']) ?? DateTime.now(),
      reference: ModelParser.asString(json['reference'] ?? json['transaction_id']),
      expiresAt: ModelParser.asDateTime(json['expires_at'] ?? json['expiresAt']),
    );
  }

  static PaymentStatus _parseStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    return PaymentStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == str,
      orElse: () => PaymentStatus.pending,
    );
  }

  static PaymentMethod _parseMethod(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    return PaymentMethod.values.firstWhere(
      (e) => e.name.toLowerCase() == str,
      orElse: () => PaymentMethod.vodafoneCash,
    );
  }

  static PaymentType _parsePaymentType(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    if (str == 'topup' || str == 'deposit') return PaymentType.walletTopup;
    return PaymentType.values.firstWhere(
      (e) => e.name.toLowerCase() == str,
      orElse: () => PaymentType.walletTopup,
    );
  }
}
