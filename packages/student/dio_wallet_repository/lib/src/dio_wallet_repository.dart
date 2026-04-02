import 'package:mentorx_core/mentorx_core.dart';
import 'models/wallet_models.dart';

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
    final response = await httpClient.get('/api/student/wallet/summary');

    if (response.statusCode != 200) {
      throw WalletRepositoryException(
        code: WalletRepositoryExceptionCode.failedToLoadSummary,
        message: response.exception?.message,
      );
    }

    final data = _asMap(response.data)['data'] ?? _asMap(response.data);
    return WalletSummaryModel.fromJson(data);
  }

  @override
  Future<List<WalletTransactionEntity>> getTransactions({
    String? type,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    final response = await httpClient.get(
      '/api/student/wallet/transactions',
      queryParameters: {
        if (type != null) 'type': type,
        if (paginationInfo != null) ...paginationInfo.toJson(),
      },
    );

    if (response.statusCode != 200) {
      throw WalletRepositoryException(
        code: WalletRepositoryExceptionCode.failedToLoadTransactions,
        message: response.exception?.message,
      );
    }

    return _asList(response.data)
        .map(_asMap)
        .map(WalletTransactionModel.fromJson)
        .toList();
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

    final data = _asMap(response.data)['data'] ?? _asMap(response.data);
    return PaymentModel.fromJson(data);
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

    final data = _asMap(response.data)['data'] ?? _asMap(response.data);
    return PaymentModel.fromJson(data);
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

    return _asMap(response.data)['data'] ?? _asMap(response.data);
  }

  @override
  Future<List<Map<String, dynamic>>> getRedemptionHistory({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    final response = await httpClient.get(
      '/api/student/wallet/redemptions',
      queryParameters: {
        if (paginationInfo != null) ...paginationInfo.toJson(),
      },
    );

    if (response.statusCode != 200) {
      throw WalletRepositoryException(
        code: WalletRepositoryExceptionCode.failedToLoadRedemptionHistory,
        message: response.exception?.message,
      );
    }

    return _asList(response.data).map(_asMap).toList();
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    return <String, dynamic>{};
  }

  static List<dynamic> _asList(dynamic value) {
    if (value is List<dynamic>) return value;
    if (value is Map<String, dynamic>) {
      final data = value['data'] ?? value['items'];
      if (data is List<dynamic>) return data;
    }
    return <dynamic>[];
  }
}
