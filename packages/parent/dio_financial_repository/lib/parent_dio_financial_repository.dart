import 'package:mentorx_core/mentorx_core.dart';
import 'models/financial_models.dart';
export 'models/financial_models.dart';

final class DioParentFinancialRepository
    extends HttpClientRepository<ParentFinancialRepositoryExceptionCode>
    implements ParentFinancialRepository {
  final HttpClient _httpClient;

  DioParentFinancialRepository({required HttpClient httpClient})
      : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentFinancialRepositoryExceptionCode code, {
    String? message,
  }) =>
      throw ParentFinancialRepositoryException(code: code, message: message);

  // ─────────────────────────────────────────────────────────────────────────
  // Wallet endpoints (EduCore Postman):
  //   GET  /api/wallet/student/{studentId}
  //   GET  /api/wallet/student/{studentId}/transactions
  // The previous /api/parent/children/{id}/wallet/* paths used by the app
  // are NOT declared on the backend; they are kept as last-resort fallbacks
  // for older builds only. /wallet/analytics and /payments are not declared
  // either — those methods return empty data on 404/405 so the UI keeps
  // rendering instead of failing the entire financial page.
  // ─────────────────────────────────────────────────────────────────────────
  @override
  Future<List<WalletTransactionEntity>> getTransactions(
    String childId, {
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      HttpClientResponse response;
      try {
        response = await _httpClient.get(
          '/api/wallet/student/$childId/transactions',
          queryParameters: paginationInfo?.toJson(),
        );
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404 && e.statusCode != 405) rethrow;
        response = await _httpClient.get(
          '/api/parent/children/$childId/wallet/transactions',
          queryParameters: paginationInfo?.toJson(),
        );
      }

      final root = asMap(response.data);
      final payload = root['data'] ?? response.data;
      final items = payload is Map
          ? asList(payload['content'])
          : asList(payload);
      return items
          .map((e) => WalletTransactionModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<WalletSummaryEntity> getWalletSummary(String childId) async {
    try {
      HttpClientResponse response;
      try {
        response = await _httpClient.get('/api/wallet/student/$childId');
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404 && e.statusCode != 405) rethrow;
        response = await _httpClient.get(
          '/api/parent/children/$childId/wallet/summary',
        );
      }

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return WalletSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<ParentWalletAnalyticsEntity> getWalletAnalytics(
    String childId, {
    int months = 6,
  }) async {
    // API-CONTRACT: no wallet analytics endpoint in Postman. Returns the
    // default-empty entity on 404/405 so the UI tile gracefully shows
    // "no data" instead of an error.
    try {
      final response = await _httpClient.get(
        '/api/parent/children/$childId/wallet/analytics',
        queryParameters: {'months': months},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ParentWalletAnalyticsModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return ParentWalletAnalyticsModel.fromJson(const <String, dynamic>{});
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<List<PaymentEntity>> getPayments(String childId) async {
    // API-CONTRACT: no per-child payments endpoint in Postman. The closest
    // existing endpoint is /api/payment/wallet/transactions but the shape
    // does not match PaymentEntity. Returns empty on 404/405.
    try {
      final response = await _httpClient.get(
        '/api/parent/children/$childId/payments',
      );

      final root = asMap(response.data);
      final payload = root['data'] ?? response.data;
      final items = payload is Map
          ? asList(payload['content'])
          : asList(payload);
      return items.map((e) => PaymentModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) {
        return const <PaymentEntity>[];
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.fetchError,
      );
    }
  }
}
