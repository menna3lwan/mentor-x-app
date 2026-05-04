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

  @override
  Future<List<Map<String, dynamic>>> getPaymentMethods() async {
    await Future<void>.delayed(delay);
    return [
      {'id': 'vodafone_cash', 'name': 'Vodafone Cash', 'type': 'wallet'},
      {'id': 'fawry', 'name': 'Fawry', 'type': 'kiosk'},
      {'id': 'insta_pay', 'name': 'InstaPay', 'type': 'bank'},
    ];
  }

  @override
  Future<List<PaymentOrderEntity>> getOrders({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future<void>.delayed(delay);
    return [
      PaymentOrderEntity(
        id: '1',
        orderNumber: 'ORD-123',
        amount: 500.0,
        status: PaymentOrderStatus.completed,
        description: 'Wallet Topup',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      PaymentOrderEntity(
        id: '2',
        orderNumber: 'ORD-124',
        amount: 250.0,
        status: PaymentOrderStatus.pending,
        description: 'Course Purchase',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];
  }

  @override
  Future<PaymentOrderEntity> getOrderDetail(String orderNumber) async {
    await Future<void>.delayed(delay);
    return PaymentOrderEntity(
      id: '1',
      orderNumber: orderNumber,
      amount: 500.0,
      status: PaymentOrderStatus.completed,
      description: 'Wallet Topup',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    );
  }

  @override
  Future<PaymentOrderEntity> createOrder({
    required double amount,
    required String description,
  }) async {
    await Future<void>.delayed(delay);
    return PaymentOrderEntity(
      id: 'new-id',
      orderNumber: 'ORD-NEW',
      amount: amount,
      status: PaymentOrderStatus.pending,
      description: description,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<PaymentEntity> depositFunds({
    required double amount,
    required PaymentMethod method,
  }) async {
    await Future<void>.delayed(delay);
    return PaymentEntity(
      id: 'pay-id',
      amount: amount,
      method: method,
      paymentType: PaymentType.walletTopup,
      status: PaymentStatus.pending,
      reference: 'REF-NEW',
      createdAt: DateTime.now(),
    );
  }
}
