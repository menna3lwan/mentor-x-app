import 'package:mentorx_core/mentorx_core.dart';
import 'models/financial_models.dart';
export 'models/financial_models.dart';

final class DioParentFinancialRepository
    extends HttpClientRepository<ParentFinancialRepositoryExceptionCode>
    implements ParentFinancialRepository {
  final HttpClient httpClient;

  DioParentFinancialRepository({required this.httpClient});

  @override
  Future<void> initialize() async {}

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
      // Backend doesn't have child-specific wallet transactions for parents yet
      // Fallback to empty list or implement once backend adds it
      return const [];
    } catch (e) {
      return throwException(
        ParentFinancialRepositoryExceptionCode.fetchError,
        message: e.toString(),
      );
    }
  }

  @override
  Future<WalletSummaryEntity> getWalletSummary(String childId) async {
    try {
      // Parent's own wallet
      final response = await httpClient.get('/api/payment/wallet');
      return WalletSummaryModel.fromJson(response.asMap());
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
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
      // Placeholder until backend provides analytics
      return const ParentWalletAnalyticsModel(
        monthlySpending: [],
        categoryBreakdown: {},
      );
    } catch (e) {
      return throwException(
        ParentFinancialRepositoryExceptionCode.fetchError,
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<PaymentEntity>> getPayments(String childId) async {
    try {
      // Parent's own payments/orders
      final response = await httpClient.get('/api/payment/orders/my-orders');
      final list = response.asList();
      return list.map((e) => PaymentModel.fromJson(asMap(e))).toList();
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.fetchError,
      );
    }
  }
}
