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
    super.id,
    super.success,
    super.pending,
    super.message,
    super.orderNumber,
    super.transactionId,
    super.amount,
    super.currency,
    super.method,
    super.reference,
    super.amountPaid,
    super.enrollmentsCreated,
    super.redirectUrl,
    super.originalAmount,
    super.finalAmount,
    super.discountAmount,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    final status = ModelParser.asString(json['status'], fallback: '');
    return PaymentModel(
      id: ModelParser.asString(json['id']),
      success: status == 'success' ||
          ModelParser.asBool(json['success'] ?? json['is_success']),
      pending: status == 'pending' ||
          ModelParser.asBool(json['pending'] ?? json['is_pending']),
      message: ModelParser.asString(json['message']),
      orderNumber: ModelParser.asString(json['order_number'] ?? json['orderNumber']),
      transactionId: ModelParser.asString(
          json['transaction_id'] ?? json['transactionId']),
      amount: ModelParser.asDouble(json['amount']),
      currency: ModelParser.asString(json['currency'], fallback: 'EGP'),
      method: PaymentMethod.values.firstWhere(
        (e) =>
            e.name ==
            ModelParser.asString(
                json['method'] ?? json['payment_method'],
                fallback: 'wallet'),
        orElse: () => PaymentMethod.wallet,
      ),
      reference: ModelParser.asString(
          json['reference'] ?? json['transaction_id']),
      amountPaid: json['amount_paid'] != null || json['amountPaid'] != null
          ? ModelParser.asDouble(json['amount_paid'] ?? json['amountPaid'])
          : null,
      enrollmentsCreated: ModelParser.asInt(
          json['enrollments_created'] ?? json['enrollmentsCreated']),
      redirectUrl: ModelParser.asString(
          json['redirect_url'] ?? json['redirectUrl']),
      originalAmount:
          json['original_amount'] != null || json['originalAmount'] != null
              ? ModelParser.asDouble(
                  json['original_amount'] ?? json['originalAmount'])
              : null,
      finalAmount: json['final_amount'] != null || json['finalAmount'] != null
          ? ModelParser.asDouble(json['final_amount'] ?? json['finalAmount'])
          : null,
      discountAmount:
          json['discount_amount'] != null || json['discountAmount'] != null
              ? ModelParser.asDouble(
                  json['discount_amount'] ?? json['discountAmount'])
              : null,
    );
  }
}
