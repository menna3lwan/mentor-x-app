part of '../../mock_data.dart';

final class MockWalletGenerator {
  MockWalletGenerator._();

  static WalletSummaryEntity summary() {
    return const WalletSummaryEntity(walletBalance: 1240.50, points: 860);
  }

  static List<WalletTransactionEntity> transactions() {
    final now = DateTime.now();
    return [
      WalletTransactionEntity(
        id: 'wt1',
        transactionType: WalletTransactionType.deposit,
        status: TransactionStatus.success,
        amount: 500.0,
        balanceAfter: 1240.50,
        description: 'Wallet top-up via Vodafone Cash',
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      WalletTransactionEntity(
        id: 'wt2',
        transactionType: WalletTransactionType.payment,
        status: TransactionStatus.success,
        amount: -300.0,
        balanceAfter: 740.50,
        description: 'Course purchase: Advanced Algebra',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      WalletTransactionEntity(
        id: 'wt3',
        transactionType: WalletTransactionType.refund,
        status: TransactionStatus.success,
        amount: 150.0,
        balanceAfter: 1040.50,
        description: 'Refund for cancelled course',
        createdAt: now.subtract(const Duration(days: 3)),
      ),
      WalletTransactionEntity(
        id: 'wt4',
        transactionType: WalletTransactionType.deposit,
        status: TransactionStatus.success,
        amount: 200.0,
        balanceAfter: 890.50,
        description: 'Wallet top-up via InstaPay',
        createdAt: now.subtract(const Duration(days: 5)),
      ),
      WalletTransactionEntity(
        id: 'wt5',
        transactionType: WalletTransactionType.refund,
        status: TransactionStatus.success,
        amount: 100.0,
        balanceAfter: 690.50,
        description: 'Admin credit: Refund adjustment',
        createdAt: now.subtract(const Duration(days: 7)),
      ),
    ];
  }

  static PaymentEntity initiatePayment({
    required double amount,
    required PaymentMethod method,
    required PaymentType paymentType,
  }) {
    return PaymentEntity(
      id: 'pay_${DateTime.now().millisecondsSinceEpoch}',
      amount: amount,
      method: method,
      reference: 'REF${DateTime.now().millisecondsSinceEpoch}',
      pending: true,
    );
  }
}
