import 'package:mentorx_core/mentorx_core.dart';
import '../models/wallet_models.dart';

final class DioWalletRepository
    extends HttpClientRepository<WalletRepositoryExceptionCode>
    implements WalletRepository {
  @override
  Never throwException(WalletRepositoryExceptionCode code, {String? message}) =>
      throw WalletRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioWalletRepository({required this.httpClient});

  @override
  Future<WalletSummaryEntity> getSummary() async {
    final response = await httpClient.get('/api/student/wallet/summary');

    if (response.statusCode != 200) {
      throw WalletRepositoryException(
        code: WalletRepositoryExceptionCode.failedToLoadSummary,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    return WalletSummaryEntity(
      walletBalance: (data['walletBalance'] ?? data['wallet_balance'] as num?)?.toDouble() ?? 0.0,
      points: (data['totalPoints'] ?? data['total_points'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  Future<List<WalletTransactionEntity>> getTransactions({
    String? type,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await httpClient.get(
      '/api/student/wallet/transactions',
      queryParameters: {
        if (type != null) 'type': type,
        'page': page,
        'limit': limit,
      },
    );

    if (response.statusCode != 200) {
      throw WalletRepositoryException(
        code: WalletRepositoryExceptionCode.failedToLoadTransactions,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => WalletTransactionModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<PaymentEntity> initiatePayment({
    required double amount,
    required PaymentMethod method,
    required PaymentType paymentType,
  }) async {
    final response = await httpClient.post(
      '/api/student/payments/initiate',
      data: {
        'amount': amount,
        'method': method.name,
        'type': paymentType.name,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw WalletRepositoryException(
        code: WalletRepositoryExceptionCode.failedToInitiatePayment,
        message: response.exception?.message,
      );
    }

    return PaymentModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<PaymentEntity> getPaymentStatus(String paymentId) async {
    final response = await httpClient.get('/api/student/payments/$paymentId/status');

    if (response.statusCode != 200) {
      throw WalletRepositoryException(
        code: WalletRepositoryExceptionCode.failedToGetPaymentStatus,
        message: response.exception?.message,
      );
    }

    return PaymentModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<Map<String, dynamic>> redeemCode(String code) async {
    final response = await httpClient.post(
      '/api/student/wallet/redeem',
      data: {'code': code},
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw WalletRepositoryException(
        code: WalletRepositoryExceptionCode.failedToRedeemCode,
        message: response.exception?.message,
      );
    }

    return response.data['data'] as Map<String, dynamic>? ?? response.data as Map<String, dynamic>;
  }

  @override
  Future<List<Map<String, dynamic>>> getRedemptionHistory({int limit = 5}) async {
    final response = await httpClient.get(
      '/api/student/wallet/redemptions',
      queryParameters: {'limit': limit},
    );

    if (response.statusCode != 200) {
      throw WalletRepositoryException(
        code: WalletRepositoryExceptionCode.failedToLoadRedemptionHistory,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.cast<Map<String, dynamic>>();
    }
    return [];
  }
}
