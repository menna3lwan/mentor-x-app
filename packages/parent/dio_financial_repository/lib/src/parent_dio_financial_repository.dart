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
    const defaultException = ParentFinancialRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/wallet/transactions',
        queryParameters: paginationInfo != null
            ? {
                'limit': paginationInfo.limit,
                'cursor': paginationInfo.cursor,
              }
            : null,
      );

      final data = response.data['data'] as List? ?? [];
      return data.map((e) => WalletTransactionModel.fromJson(e)).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }

  @override
  Future<WalletSummaryEntity> getWalletSummary(String childId) async {
    const defaultException = ParentFinancialRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/wallet/summary',
      );

      return WalletSummaryModel.fromJson(response.data['data'] ?? response.data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }

  @override
  Future<ParentWalletAnalyticsEntity> getWalletAnalytics(
    String childId, {
    int months = 6,
  }) async {
    const defaultException = ParentFinancialRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/wallet/analytics',
        queryParameters: {'months': months},
      );

      return ParentWalletAnalyticsModel.fromJson(
        response.data['data'] ?? response.data,
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }

  @override
  Future<List<PaymentEntity>> getPayments(String childId) async {
    const defaultException = ParentFinancialRepositoryExceptionCode.fetchError;
    try {
      final response = await httpClient.get(
        '/api/v1/parent/children/$childId/payments',
      );

      final data = response.data['data'] as List? ?? [];
      return data.map((e) => PaymentModel.fromJson(e)).toList();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(defaultException, e);
    } catch (e) {
      throwException(defaultException, message: e.toString());
    }
  }
}
