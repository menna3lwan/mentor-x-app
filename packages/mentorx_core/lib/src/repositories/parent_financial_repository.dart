part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentFinancialRepositoryExceptionCode {
  unknown,
  fetchError,
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
}
