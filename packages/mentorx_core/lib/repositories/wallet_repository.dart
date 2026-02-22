part of '../mentorx_core.dart';

enum WalletRepositoryExceptionCode {
  unknown,
  failedToLoadSummary,
  failedToLoadTransactions,
  failedToInitiatePayment,
  failedToGetPaymentStatus,
  failedToRedeemCode,
  failedToLoadRedemptionHistory,
}

final class WalletRepositoryException
    extends MentorXException<WalletRepositoryExceptionCode> {
  WalletRepositoryException({required super.code, super.message});
}

abstract interface class WalletRepository {
  /// Get wallet balance and points summary.
  Future<WalletSummaryEntity> getSummary();

  /// Get wallet transaction history with optional filter and pagination.
  Future<List<WalletTransactionEntity>> getTransactions({
    String? type,
    int page = 1,
    int limit = 20,
  });

  /// Initiate a payment (top-up, course purchase, etc.).
  Future<PaymentEntity> initiatePayment({
    required double amount,
    required PaymentMethod method,
    required PaymentType paymentType,
  });

  /// Poll payment status.
  Future<PaymentEntity> getPaymentStatus(String paymentId);

  /// Redeem a code (wallet, course access, discount).
  Future<Map<String, dynamic>> redeemCode(String code);

  /// Get code redemption history.
  Future<List<Map<String, dynamic>>> getRedemptionHistory({int limit = 5});
}
