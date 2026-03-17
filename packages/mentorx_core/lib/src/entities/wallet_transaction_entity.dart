part of '../../mentorx_core.dart';

enum WalletTransactionType { deposit, purchase, refund, admin }

base class WalletTransactionEntity extends Equatable {
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
      ];
}
