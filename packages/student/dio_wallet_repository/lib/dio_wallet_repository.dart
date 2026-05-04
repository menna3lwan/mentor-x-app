import 'package:mentorx_core/mentorx_core.dart';
import 'models/wallet_models.dart';
import 'models/payment_order_model.dart';
export 'models/wallet_models.dart';
export 'models/payment_order_model.dart';

final class DioWalletRepository
    extends HttpClientRepository<WalletRepositoryExceptionCode>
    implements WalletRepository {
  @override
  Never throwException(WalletRepositoryExceptionCode code, {String? message}) =>
      throw WalletRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioWalletRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

  @override
  Future<WalletSummaryEntity> getSummary() async {
    try {
      final response = await httpClient.get('/api/payment/wallet/balance');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return WalletSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.failedToLoadSummary,
      );
    }
  }

  @override
  Future<List<WalletTransactionEntity>> getTransactions({
    String? type,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/payment/wallet/transactions',
        queryParameters: {
          if (type != null) 'type': type,
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final list = asList(
        asMap(response.data)['content'] ??
            asMap(response.data)['data'] ??
            response.data,
      );

      return list
          .map((e) => WalletTransactionModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.failedToLoadTransactions,
      );
    }
  }

  @override
  Future<PaymentEntity> initiatePayment({
    required double amount,
    required PaymentMethod method,
    required PaymentType paymentType,
  }) async {
    try {
      final response = await httpClient.post(
        '/api/payment/process',
        data: {
          'amount': amount,
          'method': method.name,
          'type': paymentType.name,
        },
        headers: {
          'X-Idempotency-Key':
              'pay_${DateTime.now().millisecondsSinceEpoch}_$amount',
        },
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return PaymentModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.failedToInitiatePayment,
      );
    }
  }

  @override
  Future<PaymentEntity> getPaymentStatus(String paymentId) async {
    try {
      final response = await httpClient.get(
        '/api/student/payments/$paymentId/status',
      );
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return PaymentModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.failedToGetPaymentStatus,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> redeemCode(String code) async {
    try {
      final response = await httpClient.post(
        '/api/v1/access-codes/redeem',
        data: {'code': code},
      );
      return asMap(response.data)['data'] ?? asMap(response.data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.failedToRedeemCode,
      );
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getRedemptionHistory({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/v1/access-codes/my-codes',
        queryParameters: {
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );

      final list = asList(
        asMap(response.data)['content'] ??
            asMap(response.data)['data'] ??
            response.data,
      );

      return list.map((e) => asMap(e)).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            WalletRepositoryExceptionCode.failedToLoadRedemptionHistory,
      );
    }
  }

  @override
  Future<void> transferFunds(String recipientPhone, double amount) async {
    try {
      await httpClient.post(
        '/api/wallet/transfer',
        data: {'recipientPhone': recipientPhone, 'amount': amount},
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<void> creditWallet(
    String studentId,
    double amount,
    String reason,
  ) async {
    try {
      await httpClient.post(
        '/api/wallet/admin/credit',
        data: {'studentId': studentId, 'amount': amount, 'reason': reason},
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<void> debitWallet(
    String studentId,
    double amount,
    String reason,
  ) async {
    try {
      await httpClient.post(
        '/api/wallet/admin/debit',
        data: {'studentId': studentId, 'amount': amount, 'reason': reason},
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<WalletSummaryEntity> getStudentWalletSummary(String studentId) async {
    try {
      final response = await httpClient.get(
        '/api/wallet/admin/student/$studentId',
      );
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return WalletSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getPaymentMethods() async {
    try {
      final response = await httpClient.get('/api/payment/methods');
      final data = asList(asMap(response.data)['data'] ?? response.data);
      return data.map((e) => asMap(e)).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<List<PaymentOrderEntity>> getOrders({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/payment/orders/my-orders',
        queryParameters: {
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );
      final data = asList(asMap(response.data)['data'] ?? response.data);
      return data.map((e) => PaymentOrderModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<PaymentOrderEntity> getOrderDetail(String orderNumber) async {
    try {
      final response = await httpClient.get('/api/payment/orders/$orderNumber');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return PaymentOrderModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<PaymentOrderEntity> createOrder({
    required double amount,
    required String description,
  }) async {
    try {
      final response = await httpClient.post(
        '/api/payment/orders',
        data: {
          'amount': amount,
          'description': description,
        },
      );
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return PaymentOrderModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.unknown,
      );
    }
  }

  @override
  Future<PaymentEntity> depositFunds({
    required double amount,
    required PaymentMethod method,
  }) async {
    try {
      final response = await httpClient.post(
        '/api/payment/wallet/deposit',
        data: {
          'amount': amount,
          'method': method.name,
        },
      );
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return PaymentModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.failedToInitiatePayment,
      );
    }
  }
}
