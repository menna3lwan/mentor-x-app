part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentFinancialRepositoryExceptionCode {
  unknown,
  fetchError,
  topUpFailed,
  invalidAmount,
  insufficientFunds,
  unauthorized,
}

final class ParentFinancialRepositoryException
    extends MentorXException<ParentFinancialRepositoryExceptionCode> {
  const ParentFinancialRepositoryException({required super.code, super.message});
}

// ——— Repository ———

abstract interface class ParentFinancialRepository {
  Future<void> initialize();
  Future<List<WalletTransactionEntity>> getTransactions(
    String childId, {
    MentorXPaginationInfo? paginationInfo,
  });

  Future<WalletSummaryEntity> getWalletSummary(String childId);

  Future<ParentWalletAnalyticsEntity> getWalletAnalytics(
    String childId, {
    int months = 6,
  });

  Future<List<PaymentEntity>> getPayments(String childId);

  // ─────────────────── Parent's own wallet (no childId) ──────────────────
  //
  // Backend endpoints (Postman):
  //   GET  /api/wallet/my
  //   GET  /api/wallet/my/transactions
  //   POST /api/wallet/top-up        body: { amount, studentId? }
  //   POST /api/payment/wallet/deposit  body: { amount }   (fallback)

  /// Fetches the parent's own wallet summary.
  Future<WalletSummaryEntity> getMyWallet();

  /// Fetches the parent's own transaction history.
  Future<List<WalletTransactionEntity>> getMyTransactions({
    MentorXPaginationInfo? paginationInfo,
  });

  /// Tops up either the parent's own wallet (when [studentId] is null) or
  /// a specific child's wallet. Returns the updated wallet summary.
  Future<WalletSummaryEntity> topUpWallet({
    required double amount,
    String? studentId,
  });
}
