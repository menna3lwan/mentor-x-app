import 'package:mentorx_core/mentorx_core.dart';
import 'models/financial_models.dart';

final class DioParentFinancialRepository
    extends HttpClientRepository<ParentFinancialRepositoryExceptionCode>
    implements ParentFinancialRepository {
  final HttpClient httpClient;

  DioParentFinancialRepository({required this.httpClient});

  @override
  Never throwException(
    ParentFinancialRepositoryExceptionCode code, {
    String? message,
  }) {
    throw ParentFinancialRepositoryException(code: code, message: message);
  }

  @override
  Future<List<WalletTransactionEntity>> getTransactions(
    String childId, {
    MentorXPaginationInfo? paginationInfo,
  }) async {
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/wallet/transactions',
        queryParameters: paginationInfo?.toJson(),
      );

      final data = asList(response.data);
      return data.map((e) => WalletTransactionModel.fromJson(asMap(e))).toList();
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
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/wallet/summary',
      );

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
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/wallet/analytics',
        queryParameters: {'months': months},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ParentWalletAnalyticsModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.fetchError,
      );
    }
  }

  @override
  Future<List<PaymentEntity>> getPayments(String childId) async {
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/payments',
      );

      final data = asList(response.data);
      return data.map((e) => PaymentModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.fetchError,
      );
    }
  }

}
