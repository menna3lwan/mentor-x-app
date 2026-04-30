part of 'package:mentorx_core/mentorx_core.dart';

enum WalletTransactionType { deposit, withdrawal, payment, refund, reward }

enum TransactionStatus { pending, success, failed }

class WalletTransactionEntity extends Equatable {
  final String id;
  final String? walletId;
  final String? transactionNumber;
  final WalletTransactionType transactionType;
  final TransactionStatus? status;
  final double amount;
  final double balanceAfter;
  final String? formattedAmount;
  final String? referenceId;
  final String description;
  final String? paymentMethod; // "Vodafone Cash" / "Fawry" / "InstaPay"
  final String? formattedDate;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? typeBadge; // "Top Up" / "Course" / "Code" / "Reward" / "Admin" / "Refund" / "Marketplace"

  const WalletTransactionEntity({
    required this.id,
    this.walletId,
    this.transactionNumber,
    required this.transactionType,
    this.status,
    required this.amount,
    required this.balanceAfter,
    this.formattedAmount,
    this.referenceId,
    required this.description,
    this.paymentMethod,
    this.formattedDate,
    required this.createdAt,
    this.completedAt,
    this.typeBadge,
  });

  bool get isCredit => amount > 0;

  static final placeholder = WalletTransactionEntity(
    id: '',
    transactionType: WalletTransactionType.deposit,
    amount: 0.0,
    balanceAfter: 0.0,
    description: '',
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        walletId,
        transactionNumber,
        transactionType,
        status,
        amount,
        balanceAfter,
        formattedAmount,
        referenceId,
        description,
        paymentMethod,
        formattedDate,
        createdAt,
        completedAt,
        typeBadge,
      ];

  WalletTransactionEntity copyWith({
    String? id,
    String? walletId,
    String? transactionNumber,
    WalletTransactionType? transactionType,
    TransactionStatus? status,
    double? amount,
    double? balanceAfter,
    String? formattedAmount,
    String? referenceId,
    String? description,
    String? paymentMethod,
    String? formattedDate,
    DateTime? createdAt,
    DateTime? completedAt,
    String? typeBadge,
  }) {
    return WalletTransactionEntity(
      id: id ?? this.id,
      walletId: walletId ?? this.walletId,
      transactionNumber: transactionNumber ?? this.transactionNumber,
      transactionType: transactionType ?? this.transactionType,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      formattedAmount: formattedAmount ?? this.formattedAmount,
      referenceId: referenceId ?? this.referenceId,
      description: description ?? this.description,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      formattedDate: formattedDate ?? this.formattedDate,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      typeBadge: typeBadge ?? this.typeBadge,
    );
  }
}
