import 'package:mentorx_core/mentorx_core.dart';
import 'models/wallet_models.dart';
export 'models/wallet_models.dart';

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
      final response = await httpClient.get('/api/student/wallet/summary');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return WalletSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
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
        '/api/student/wallet/transactions',
        queryParameters: {
          if (type != null) 'type': type,
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );
      final data = asList(response.data);
      return data
          .map((e) => WalletTransactionModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
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
        '/api/student/payments/initiate',
        data: {
          'amount': amount,
          'method': method.name,
          'type': paymentType.name,
        },
        headers: {
          'X-Idempotency-Key': 'pay_${DateTime.now().millisecondsSinceEpoch}_$amount',
        },
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return PaymentModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.failedToInitiatePayment,
      );
    }
  }

  @override
  Future<PaymentEntity> getPaymentStatus(String paymentId) async {
    try {
      final response = await httpClient.get('/api/student/payments/$paymentId/status');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return PaymentModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.failedToGetPaymentStatus,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> redeemCode(String code) async {
    try {
      final response = await httpClient.post(
        '/api/student/wallet/redeem',
        data: {'code': code},
      );
      return asMap(response.data)['data'] ?? asMap(response.data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
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
        '/api/student/wallet/redemptions',
        queryParameters: {
          if (paginationInfo != null) ...paginationInfo.toJson(),
        },
      );
      return asList(response.data).map((e) => asMap(e)).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: WalletRepositoryExceptionCode.failedToLoadRedemptionHistory,
      );
    }
  }

}
