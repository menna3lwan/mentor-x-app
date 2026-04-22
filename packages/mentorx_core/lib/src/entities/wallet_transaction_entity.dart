part of 'package:mentorx_core/mentorx_core.dart';

enum WalletTransactionType { deposit, withdrawal, payment, refund, reward }

base class WalletTransactionEntity extends Equatable {
  final String id;
  final WalletTransactionType transactionType;
  final double amount;
  final double balanceAfter;
  final String description;
  final DateTime createdAt;
  final String?
      typeBadge; // "Top Up" / "Course" / "Code" / "Reward" / "Admin" / "Refund" / "Marketplace"
  final String? paymentMethod; // "Vodafone Cash" / "Fawry" / "InstaPay"

  const WalletTransactionEntity({
    required this.id,
    required this.transactionType,
    required this.amount,
    required this.balanceAfter,
    required this.description,
    required this.createdAt,
    this.typeBadge,
    this.paymentMethod,
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
        transactionType,
        amount,
        balanceAfter,
        description,
        createdAt,
        typeBadge,
        paymentMethod,
      ];

  WalletTransactionEntity copyWith({
    String? id,
    WalletTransactionType? transactionType,
    double? amount,
    double? balanceAfter,
    String? description,
    DateTime? createdAt,
    String? typeBadge,
    String? paymentMethod,
  }) {
    return WalletTransactionEntity(
      id: id ?? this.id,
      transactionType: transactionType ?? this.transactionType,
      amount: amount ?? this.amount,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      typeBadge: typeBadge ?? this.typeBadge,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
