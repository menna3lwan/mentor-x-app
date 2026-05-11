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
      walletId: ModelParser.asString(json['id']),
      studentId: ModelParser.asString(json['studentId'] ?? json['student_id']),
      studentName: ModelParser.asString(json['studentName'] ?? json['student_name']),
      walletBalance: ModelParser.asDouble(json['balance'] ?? json['walletBalance'] ?? json['wallet_balance']),
      totalDeposited: ModelParser.asDouble(json['totalDeposited'] ?? json['total_deposited']),
      totalSpent: ModelParser.asDouble(json['totalSpent'] ?? json['total_spent']),
      totalRefunded: ModelParser.asDouble(json['totalRefunded'] ?? json['total_refunded']),
      isActive: ModelParser.asBool(json['isActive'] ?? json['is_active'], fallback: true),
      isVerified: ModelParser.asBool(json['isVerified'] ?? json['is_verified']),
      formattedBalance: ModelParser.asString(json['formattedBalance'] ?? json['formatted_balance']),
      points: ModelParser.asInt(json['totalPoints'] ?? json['total_points'] ?? json['points']),
      spentThisMonth: ModelParser.asDouble(json['spentThisMonth'] ?? json['spent_this_month']),
      totalCreditsThisMonth: ModelParser.asDouble(json['totalCreditsThisMonth'] ?? json['total_credits_this_month']),
      totalTransactions: ModelParser.asInt(json['totalTransactions'] ?? json['total_transactions']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']),
      updatedAt: ModelParser.asDateTime(json['updatedAt'] ?? json['updated_at']),
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
      transactionNumber: ModelParser.asString(json['transactionNumber'] ?? json['transaction_number']),
      transactionType: _parseType(json['type'] ?? json['transactionType'] ?? json['transaction_type']),
      status: _parseStatus(json['status']),
      amount: ModelParser.asDouble(json['amount']),
      balanceAfter: ModelParser.asDouble(json['balanceAfter'] ?? json['balance_after']),
      formattedAmount: ModelParser.asString(json['formattedAmount'] ?? json['formatted_amount']),
      referenceId: ModelParser.asString(json['referenceId'] ?? json['reference_id']),
      description: ModelParser.asString(json['description'] ?? json['reason']),
      paymentMethod: ModelParser.asString(json['paymentMethod'] ?? json['payment_method']),
      formattedDate: ModelParser.asString(json['formattedDate'] ?? json['formatted_date']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']) ?? DateTime.now(),
      completedAt: ModelParser.asDateTime(json['completedAt'] ?? json['completed_at']),
      typeBadge: ModelParser.asString(json['typeBadge'] ?? json['type_badge'] ?? json['type']),
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
    return TransactionStatus.values.firstWhere(
      (e) => e.name.toLowerCase() == str,
      orElse: () => TransactionStatus.pending,
    );
  }

  static WalletTransactionType _parseType(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    return WalletTransactionType.values.firstWhere(
      (e) => e.name.toLowerCase() == str,
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
      id: ModelParser.asString(json['id']),
      amount: ModelParser.asDouble(json['amount']),
      currency: ModelParser.asString(json['currency'], fallback: 'EGP'),
      method: _parseMethod(json['method'] ?? json['payment_method']),
      paymentType: _parseType(json['type'] ?? json['paymentType'] ?? json['payment_type']),
      status: _parseStatus(json['status']),
      reference: ModelParser.asString(json['reference'] ?? json['payment_reference'] ?? json['external_id']),
      expiresAt: ModelParser.asDateTime(json['expiresAt'] ?? json['expires_at']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']) ?? DateTime.now(),
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

  static PaymentType _parseType(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    if (str == 'topup' || str == 'deposit') return PaymentType.walletTopup;
    return PaymentType.values.firstWhere(
      (e) => e.name.toLowerCase() == str,
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
      id: ModelParser.asString(json['id']),
      amount: ModelParser.asInt(json['amount']),
      balanceAfter: ModelParser.asInt(json['balanceAfter'] ?? json['balance_after']),
      description: ModelParser.asString(json['description'] ?? json['reason']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']) ?? DateTime.now(),
      typeBadge: ModelParser.asString(json['typeBadge'] ?? json['type_badge'] ?? json['type']),
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
