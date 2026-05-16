import 'package:mentorx_core/mentorx_core.dart';

final class WalletSummaryModel extends WalletSummaryEntity {
  const WalletSummaryModel({
    super.walletId,
    super.studentId,
    super.studentName,
    required super.walletBalance,
    super.totalDeposited = 0,
    super.totalSpent = 0,
    super.totalRefunded = 0,
    super.isActive = true,
    super.isVerified = false,
    super.formattedBalance,
    super.points = 0,
    super.spentThisMonth = 0,
    super.totalCreditsThisMonth = 0,
    super.totalTransactions = 0,
    super.createdAt,
    super.updatedAt,
  });

  factory WalletSummaryModel.fromJson(Map<String, dynamic> json) {
    return WalletSummaryModel(
      walletId: ModelParser.asString(
        json['walletId'] ?? json['id'] ?? json['wallet_id'],
      ),
      studentId: ModelParser.asString(json['studentId'] ?? json['student_id']),
      studentName: ModelParser.asString(
        json['studentName'] ?? json['student_name'],
      ),
      walletBalance: ModelParser.asDouble(
        json['balance'] ?? json['walletBalance'] ?? json['wallet_balance'],
      ),
      totalDeposited: ModelParser.asDouble(
        json['totalDeposited'] ?? json['total_deposited'],
      ),
      totalSpent: ModelParser.asDouble(
        json['totalSpent'] ?? json['total_spent'],
      ),
      totalRefunded: ModelParser.asDouble(
        json['totalRefunded'] ?? json['total_refunded'],
      ),
      isActive: ModelParser.asBool(
        json['isActive'] ?? json['is_active'],
        fallback: true,
      ),
      isVerified: ModelParser.asBool(json['isVerified'] ?? json['is_verified']),
      formattedBalance: ModelParser.asString(
        json['formattedBalance'] ?? json['formatted_balance'],
      ),
      points: ModelParser.asInt(
        json['totalPoints'] ??
            json['total_points'] ??
            json['points'] ??
            json['score'] ??
            json['total_score'],
      ),
      spentThisMonth: ModelParser.asDouble(
        json['spentThisMonth'] ?? json['spent_this_month'],
      ),
      totalCreditsThisMonth: ModelParser.asDouble(
        json['totalCreditsThisMonth'] ?? json['total_credits_this_month'],
      ),
      totalTransactions: ModelParser.asInt(
        json['totalTransactions'] ?? json['total_transactions'],
      ),
      createdAt: ModelParser.asDateTime(
        json['createdAt'] ?? json['created_at'],
      ),
      updatedAt: ModelParser.asDateTime(
        json['updatedAt'] ?? json['updated_at'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': walletId,
    'studentId': studentId,
    'studentName': studentName,
    'balance': walletBalance,
    'totalDeposited': totalDeposited,
    'totalSpent': totalSpent,
    'totalRefunded': totalRefunded,
    'isActive': isActive,
    'isVerified': isVerified,
    'formattedBalance': formattedBalance,
    'total_points': points,
    'spent_this_month': spentThisMonth,
    'total_credits_this_month': totalCreditsThisMonth,
    'total_transactions': totalTransactions,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  factory WalletSummaryModel.fromEntity(WalletSummaryEntity entity) {
    return WalletSummaryModel(
      walletId: entity.walletId,
      studentId: entity.studentId,
      studentName: entity.studentName,
      walletBalance: entity.walletBalance,
      totalDeposited: entity.totalDeposited,
      totalSpent: entity.totalSpent,
      totalRefunded: entity.totalRefunded,
      isActive: entity.isActive,
      isVerified: entity.isVerified,
      formattedBalance: entity.formattedBalance,
      points: entity.points,
      spentThisMonth: entity.spentThisMonth,
      totalCreditsThisMonth: entity.totalCreditsThisMonth,
      totalTransactions: entity.totalTransactions,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}

final class WalletTransactionModel extends WalletTransactionEntity {
  const WalletTransactionModel({
    required super.id,
    super.walletId,
    super.transactionNumber,
    required super.transactionType,
    super.status,
    required super.amount,
    required super.balanceAfter,
    super.formattedAmount,
    super.referenceId,
    required super.description,
    super.paymentMethod,
    super.formattedDate,
    required super.createdAt,
    super.completedAt,
    super.typeBadge,
  });

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      id: ModelParser.asString(json['id']),
      walletId: ModelParser.asString(json['walletId'] ?? json['wallet_id']),
      transactionNumber: ModelParser.asString(
        json['transactionNumber'] ?? json['transaction_number'],
      ),
      transactionType: _parseType(
        json['type'] ?? json['transactionType'] ?? json['transaction_type'],
      ),
      status: _parseStatus(json['status']),
      amount: ModelParser.asDouble(json['amount']),
      balanceAfter: ModelParser.asDouble(
        json['balanceAfter'] ?? json['balance_after'],
      ),
      formattedAmount: ModelParser.asString(
        json['formattedAmount'] ?? json['formatted_amount'],
      ),
      referenceId: ModelParser.asString(
        json['referenceId'] ?? json['reference_id'],
      ),
      description: ModelParser.asString(json['description'] ?? json['reason']),
      paymentMethod: ModelParser.asString(
        json['paymentMethod'] ?? json['payment_method'],
      ),
      formattedDate: ModelParser.asString(
        json['formattedDate'] ?? json['formatted_date'],
      ),
      createdAt:
          ModelParser.asDateTime(json['createdAt'] ?? json['created_at']) ??
          DateTime.now(),
      completedAt: ModelParser.asDateTime(
        json['completedAt'] ?? json['completed_at'],
      ),
      typeBadge: ModelParser.asString(
        json['typeBadge'] ?? json['type_badge'] ?? json['type'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'wallet_id': walletId,
    'transaction_number': transactionNumber,
    'type': transactionType.name,
    'status': status?.name,
    'amount': amount,
    'balance_after': balanceAfter,
    'formatted_amount': formattedAmount,
    'reference_id': referenceId,
    'description': description,
    'payment_method': paymentMethod,
    'formatted_date': formattedDate,
    'created_at': createdAt.toIso8601String(),
    'completed_at': completedAt?.toIso8601String(),
    'type_badge': typeBadge,
  };

  factory WalletTransactionModel.fromEntity(WalletTransactionEntity entity) {
    return WalletTransactionModel(
      id: entity.id,
      walletId: entity.walletId,
      transactionNumber: entity.transactionNumber,
      transactionType: entity.transactionType,
      status: entity.status,
      amount: entity.amount,
      balanceAfter: entity.balanceAfter,
      formattedAmount: entity.formattedAmount,
      referenceId: entity.referenceId,
      description: entity.description,
      paymentMethod: entity.paymentMethod,
      formattedDate: entity.formattedDate,
      createdAt: entity.createdAt,
      completedAt: entity.completedAt,
      typeBadge: entity.typeBadge,
    );
  }

  static TransactionStatus? _parseStatus(dynamic value) {
    if (value == null) return null;
    final str = ModelParser.asString(value).toLowerCase();
    for (final status in TransactionStatus.values) {
      if (status.name.toLowerCase() == str) return status;
    }
    return TransactionStatus.pending;
  }

  static WalletTransactionType _parseType(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    if (str == 'payment' || str == 'purchase') {
      return WalletTransactionType.payment;
    }
    if (str == 'deposit' || str == 'credit') {
      return WalletTransactionType.deposit;
    }
    if (str == 'withdrawal' || str == 'debit') {
      return WalletTransactionType.withdrawal;
    }
    if (str == 'refund') return WalletTransactionType.refund;

    return WalletTransactionType.values.firstWhere(
      (e) => e.name.toLowerCase() == str,
      orElse: () => WalletTransactionType.deposit,
    );
  }
}

final class PaymentModel extends PaymentEntity {
  const PaymentModel({
    super.id,
    super.success = false,
    super.pending = false,
    super.message,
    super.orderNumber,
    super.transactionId,
    super.amount = 0.0,
    super.currency = 'EGP',
    super.method = PaymentMethod.wallet,
    super.reference,
    super.amountPaid,
    super.enrollmentsCreated = 0,
    super.redirectUrl,
    super.originalAmount,
    super.finalAmount,
    super.discountAmount,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);
    return PaymentModel(
      id: _nullableString(data['id'] ?? data['paymentId']),
      success: ModelParser.asBool(data['success']),
      pending: ModelParser.asBool(data['pending']),
      message: _nullableString(data['message']),
      orderNumber: _nullableString(data['orderNumber'] ?? data['order_number']),
      transactionId: _nullableString(
        data['transactionId'] ?? data['transaction_id'] ?? data['transactionNumber'] ?? data['transaction_number'],
      ),
      amount: ModelParser.asDouble(data['amount'] ?? data['total'] ?? 0.0),
      currency: ModelParser.asString(data['currency'], fallback: 'EGP'),
      method: _parseMethod(data['paymentMethod'] ?? data['method']),
      reference: _nullableString(data['reference'] ?? data['referenceNumber'] ?? data['referenceId'] ?? data['reference_id']),
      amountPaid: _nullableDouble(data['amountPaid'] ?? data['amount_paid']),
      enrollmentsCreated: ModelParser.asInt(
        data['enrollmentsCreated'] ?? data['enrollments_created'],
      ),
      redirectUrl: _nullableString(data['redirectUrl'] ?? data['redirect_url']),
      originalAmount: _nullableDouble(
        data['originalAmount'] ?? data['original_amount'],
      ),
      finalAmount: _nullableDouble(data['finalAmount'] ?? data['final_amount']),
      discountAmount: _nullableDouble(
        data['discountAmount'] ?? data['discount_amount'],
      ),
    );
  }

  static PaymentMethod _parseMethod(dynamic value) {
    if (value == null) return PaymentMethod.wallet;
    final str = ModelParser.asString(value).toLowerCase();
    if (str.contains('vodafone')) return PaymentMethod.vodafoneCash;
    if (str.contains('fawry')) return PaymentMethod.fawry;
    if (str.contains('insta')) return PaymentMethod.instaPay;
    if (str.contains('card')) return PaymentMethod.creditCard;
    return PaymentMethod.wallet;
  }

  static String? _nullableString(dynamic value) {
    final s = ModelParser.asString(value);
    return s.isEmpty ? null : s;
  }

  static double? _nullableDouble(dynamic value) {
    if (value == null) return null;
    return ModelParser.asDouble(value);
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
      id: ModelParser.asString(json['id']),
      amount: ModelParser.asInt(json['amount']),
      balanceAfter: ModelParser.asInt(
        json['balanceAfter'] ?? json['balance_after'],
      ),
      description: ModelParser.asString(json['description'] ?? json['reason']),
      createdAt:
          ModelParser.asDateTime(json['createdAt'] ?? json['created_at']) ??
          DateTime.now(),
      typeBadge: ModelParser.asString(
        json['typeBadge'] ?? json['type_badge'] ?? json['type'],
      ),
    );
  }
}
