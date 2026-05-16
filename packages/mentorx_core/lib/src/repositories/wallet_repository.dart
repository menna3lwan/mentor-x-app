part of 'package:mentorx_core/mentorx_core.dart';

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
  Future<void> initialize();

  /// Get wallet balance and points summary.
  Future<WalletSummaryEntity> getSummary();

  /// Get wallet transaction history with optional filter and pagination.
  Future<List<WalletTransactionEntity>> getTransactions({
    String? type,
    MentorXPaginationInfo? paginationInfo,
  });

  /// Initiate a payment (top-up, course purchase, etc.).
  Future<PaymentEntity> initiatePayment({
    required double amount,
    required PaymentMethod method,
    required PaymentType paymentType,
    String? orderId,
    String? couponCode,
  });

  /// Poll payment status.
  Future<PaymentEntity> getPaymentStatus(String paymentId);

  /// Redeem a code (wallet, course access, discount).
  Future<Map<String, dynamic>> redeemCode(String code);

  /// Get code redemption history.
  Future<List<Map<String, dynamic>>> getRedemptionHistory({
    MentorXPaginationInfo? paginationInfo,
  });

  /// Get list of available payment methods.
  Future<List<Map<String, dynamic>>> getPaymentMethods();

  /// Get list of payments orders.
  Future<List<PaymentOrderEntity>> getOrders({
    MentorXPaginationInfo? paginationInfo,
  });

  /// Get specific order detail.
  Future<PaymentOrderEntity> getOrderDetail(String orderNumber);

  /// Create a new payment order.
  Future<PaymentOrderEntity> createOrder({
    required List<({String type, String id})> items,
  });

  /// Deposit funds into wallet.
  Future<PaymentEntity> depositFunds({
    required double amount,
    required PaymentMethod method,
  });

  /// Get valid coupons for the student.
  Future<List<CouponEntity>> getValidCoupons();

  /// Preview coupon discount before applying.
  Future<Map<String, dynamic>> previewCoupon({
    required String code,
    required double amount,
    String? courseId,
  });

  // Pro Features
  Future<void> transferFunds(String recipientPhone, double amount);
  Future<void> creditWallet(String studentId, double amount, String reason);
  Future<void> debitWallet(String studentId, double amount, String reason);
  Future<WalletSummaryEntity> getStudentWalletSummary(String studentId);
}
