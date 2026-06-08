import 'package:mentorx_core/mentorx_core.dart';

final class MockParentFinancialRepository implements ParentFinancialRepository {
  final Duration delay;

  // In-memory parent-wallet state so `topUpWallet` can mutate it.
  double _myBalance = 230.0;
  final int _myPoints = 350;
  final double _mySpentThisMonth = 40.0;
  double _myCreditsThisMonth = 100.0;
  int _myTotalTransactions = 6;
  final List<WalletTransactionEntity> _myTransactions = [
    WalletTransactionEntity(
      id: 'my_tx_1',
      amount: 100.0,
      balanceAfter: 230.0,
      transactionType: WalletTransactionType.deposit,
      description: 'Wallet Top-Up',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      typeBadge: 'Top Up',
      paymentMethod: 'Vodafone Cash',
    ),
    WalletTransactionEntity(
      id: 'my_tx_2',
      amount: -40.0,
      balanceAfter: 130.0,
      transactionType: WalletTransactionType.payment,
      description: 'Transfer to Khalid',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      typeBadge: 'Transfer',
    ),
  ];

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

  @override
  Future<WalletSummaryEntity> getMyWallet() async {
    await Future.delayed(delay);
    return WalletSummaryEntity(
      walletBalance: _myBalance,
      points: _myPoints,
      spentThisMonth: _mySpentThisMonth,
      totalCreditsThisMonth: _myCreditsThisMonth,
      totalTransactions: _myTotalTransactions,
    );
  }

  @override
  Future<List<WalletTransactionEntity>> getMyTransactions({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future.delayed(delay);
    return List<WalletTransactionEntity>.from(_myTransactions);
  }

  @override
  Future<WalletSummaryEntity> topUpWallet({
    required double amount,
    String? studentId,
  }) async {
    await Future.delayed(delay);
    if (amount <= 0) {
      throw const ParentFinancialRepositoryException(
        code: ParentFinancialRepositoryExceptionCode.invalidAmount,
        message: 'Top-up amount must be positive.',
      );
    }
    _myBalance += amount;
    _myCreditsThisMonth += amount;
    _myTotalTransactions += 1;
    _myTransactions.insert(
      0,
      WalletTransactionEntity(
        id: 'my_tx_${DateTime.now().millisecondsSinceEpoch}',
        amount: amount,
        balanceAfter: _myBalance,
        transactionType: WalletTransactionType.deposit,
        description: studentId == null || studentId.isEmpty
            ? 'Wallet Top-Up'
            : 'Top-Up to Child $studentId',
        createdAt: DateTime.now(),
        typeBadge: 'Top Up',
        paymentMethod: 'Mock',
      ),
    );
    return WalletSummaryEntity(
      walletBalance: _myBalance,
      points: _myPoints,
      spentThisMonth: _mySpentThisMonth,
      totalCreditsThisMonth: _myCreditsThisMonth,
      totalTransactions: _myTotalTransactions,
    );
  }
}
