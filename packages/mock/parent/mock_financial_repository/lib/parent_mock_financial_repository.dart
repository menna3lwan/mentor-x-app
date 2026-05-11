import 'package:mentorx_core/mentorx_core.dart';

final class MockParentFinancialRepository implements ParentFinancialRepository {
  final Duration delay;

  MockParentFinancialRepository({
    this.delay = const Duration(milliseconds: 800),
  });

  @override
  Future<void> initialize() async {}

  @override
  Future<List<WalletTransactionEntity>> getTransactions(
    String childId, {
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future.delayed(delay);
    return [
      WalletTransactionEntity(
        id: 'tx_1',
        amount: 50.0,
        balanceAfter: 150.0,
        transactionType: WalletTransactionType.deposit,
        description: 'Monthly Allowance',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        typeBadge: 'Top Up',
        paymentMethod: 'Vodafone Cash',
      ),
      WalletTransactionEntity(
        id: 'tx_2',
        amount: -15.5,
        balanceAfter: 134.5,
        transactionType: WalletTransactionType.payment,
        description: 'Physics Course Material',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        typeBadge: 'Course',
      ),
    ];
  }

  @override
  Future<WalletSummaryEntity> getWalletSummary(String childId) async {
    await Future.delayed(delay);
    return const WalletSummaryEntity(
      walletBalance: 134.5,
      points: 1200,
      spentThisMonth: 15.5,
      totalCreditsThisMonth: 50.0,
      totalTransactions: 12,
    );
  }

  @override
  Future<ParentWalletAnalyticsEntity> getWalletAnalytics(
    String childId, {
    int months = 6,
  }) async {
    await Future.delayed(delay);
    return const ParentWalletAnalyticsEntity(
      monthlySpending: [
        MonthlySpendingEntry(month: '2025-06', amount: 120.0),
        MonthlySpendingEntry(month: '2025-07', amount: 150.0),
      ],
      categoryBreakdown: {
        'Courses': 200.0,
        'Materials': 50.0,
        'Exams': 20.0,
      },
    );
  }

  @override
  Future<List<PaymentEntity>> getPayments(String childId) async {
    await Future.delayed(delay);
    return [];
  }
}
