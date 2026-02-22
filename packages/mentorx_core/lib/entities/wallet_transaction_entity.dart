part of '../mentorx_core.dart';

enum WalletTransactionType { deposit, purchase, refund, admin }

final class WalletTransactionEntity extends Equatable {
  final String id;
  final WalletTransactionType transactionType;
  final double amount;
  final double balanceAfter;
  final String description;
  final DateTime createdAt;

  const WalletTransactionEntity({
    required this.id,
    required this.transactionType,
    required this.amount,
    required this.balanceAfter,
    required this.description,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        transactionType,
        amount,
        balanceAfter,
        description,
        createdAt,
      ];
}
