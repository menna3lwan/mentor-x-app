import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockWalletRepository implements WalletRepository {
  final Duration delay;

  const MockWalletRepository({required this.delay});

  @override
  Future<void> initialize() async {}

  @override
  Future<WalletSummaryEntity> getSummary() async {
    await Future<void>.delayed(delay);
    return MockWalletGenerator.summary();
  }

  @override
  Future<List<WalletTransactionEntity>> getTransactions({
    String? type,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future<void>.delayed(delay);
    return MockWalletGenerator.transactions();
  }

  @override
  Future<PaymentEntity> initiatePayment({
    required double amount,
    required PaymentMethod method,
    required PaymentType paymentType,
  }) async {
    await Future<void>.delayed(delay);
    return MockWalletGenerator.initiatePayment(
      amount: amount,
      method: method,
      paymentType: paymentType,
    );
  }

  @override
  Future<PaymentEntity> getPaymentStatus(String paymentId) async {
    await Future<void>.delayed(delay ~/ 2);
    return PaymentEntity(
      id: paymentId,
      amount: 500.0,
      method: PaymentMethod.vodafoneCash,
      paymentType: PaymentType.walletTopup,
      status: PaymentStatus.success,
      reference: 'REF-MOCK-12345',
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    );
  }

  @override
  Future<Map<String, dynamic>> redeemCode(String code) async {
    await Future<void>.delayed(delay);
    return {
      'type': 'wallet',
      'amount': 100.0,
      'message': 'Successfully redeemed! EGP 100 added to your wallet.',
    };
  }

  @override
  Future<List<Map<String, dynamic>>> getRedemptionHistory({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future<void>.delayed(delay);
    final now = DateTime.now();
    return [
      {
        'code': 'WELCOME100',
        'type': 'wallet',
        'amount': 100.0,
        'redeemedAt': now.subtract(const Duration(days: 2)).toIso8601String(),
      },
      {
        'code': 'BONUS50',
        'type': 'wallet',
        'amount': 50.0,
        'redeemedAt': now.subtract(const Duration(days: 10)).toIso8601String(),
      },
    ];
  }

  @override
  Future<void> transferFunds(String recipientPhone, double amount) async {
    await Future<void>.delayed(delay);
  }

  @override
  Future<void> creditWallet(String studentId, double amount, String reason) async {
    await Future<void>.delayed(delay);
  }

  @override
  Future<void> debitWallet(String studentId, double amount, String reason) async {
    await Future<void>.delayed(delay);
  }

  @override
  Future<WalletSummaryEntity> getStudentWalletSummary(String studentId) async {
    await Future<void>.delayed(delay);
    return MockWalletGenerator.summary();
  }
}
