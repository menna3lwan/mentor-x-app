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
    String? couponCode,
    required PaymentMethod method,
    String? orderId,
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
      reference: 'REF-MOCK-12345',
      pending: false,
      success: true,
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
        studentId: 's1',
        studentName: 'Kamal Ayman',
        subtotal: 500.0,
        total: 500.0,
        status: PaymentOrderStatus.completed,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      PaymentOrderEntity(
        id: '2',
        orderNumber: 'ORD-124',
        studentId: 's1',
        studentName: 'Kamal Ayman',
        subtotal: 250.0,
        total: 250.0,
        status: PaymentOrderStatus.pending,
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
      studentId: 's1',
      studentName: 'Kamal Ayman',
      subtotal: 500.0,
      total: 500.0,
      status: PaymentOrderStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    );
  }

  @override
  Future<PaymentOrderEntity> createOrder({
    required List<({String id, String type})> items,
  }) async {
    await Future<void>.delayed(delay);
    return PaymentOrderEntity(
      id: 'new-id',
      orderNumber: 'ORD-NEW',
      studentId: 's1',
      studentName: 'Kamal Ayman',
      subtotal: 100.0,
      total: 100.0,
      status: PaymentOrderStatus.pending,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<WalletTransactionEntity> depositFunds({
    required double amount,
    required PaymentMethod method,
  }) async {
    await Future<void>.delayed(delay);
    return WalletTransactionEntity(
      id: 'txn-mock-001',
      transactionType: WalletTransactionType.deposit,
      amount: amount,
      balanceAfter: amount + 500.0,
      description: 'Wallet deposit via ${method.name}',
      createdAt: DateTime.now(),
      referenceId: 'REF-MOCK-DEPOSIT',
      paymentMethod: method.name.toUpperCase(),
      status: TransactionStatus.success,
    );
  }

  @override
  Future<Map<String, dynamic>> previewCoupon({
    required String code,
    required double amount,
    String? courseId,
  }) async {
    await Future<void>.delayed(delay);
    if (code.trim().toUpperCase() == 'INVALID') {
      throw WalletRepositoryException(
        code: WalletRepositoryExceptionCode.failedToRedeemCode,
        message: 'Invalid coupon code.',
      );
    }
    final discount = code.trim().toUpperCase() == 'SAVE50' ? 50.0 : 10.0;
    return {
      'couponCode': code.toUpperCase(),
      'couponDescription': 'Mock Discount Coupon',
      'originalPrice': amount,
      'discountAmount': discount,
      'finalPrice': (amount - discount).clamp(0.0, double.infinity),
      'discountSummary': 'خصم $discount جنيه',
    };
  }

  @override
  Future<List<CouponEntity>> getValidCoupons() async {
    await Future<void>.delayed(delay);
    return [
      CouponEntity(
        id: '1',
        code: 'DISCOUNT10',
        discountPercentage: 10.0,
        isActive: true,
        type: 'percentage',
        validUntil: DateTime.now().add(const Duration(days: 30)),
      ),
      CouponEntity(
        id: '2',
        code: 'SAVE50',
        discountAmount: 50.0,
        isActive: true,
        type: 'fixed',
        minOrderAmount: 200.0,
      ),
    ];
  }
}
