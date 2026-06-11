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
  }) => throw ParentFinancialRepositoryException(code: code, message: message);

  // ─────────────────────────────────────────────────────────────────────────
  // Wallet endpoints (EduCore OpenAPI):
  //   GET  /api/wallet/student/{studentId}
  //   GET  /api/wallet/student/{studentId}/transactions
  //   POST /api/wallet/top-up    { studentId, amount }  — TEACHER/ADMIN only
  //   POST /api/payment/wallet/deposit  { amount, paymentMethod }
  //
  // KNOWN BACKEND GAP: the wallet controller uses hasRole('TEACHER','ADMIN')
  // for student-scoped endpoints and hasRole('STUDENT') for /my endpoints.
  // Neither grants access to the PARENT role.
  //
  // To prevent a 403 from the backend from triggering the global "unauthorized
  // → logout" flow (which would immediately kick parents out of the wallet
  // screen), 403 is treated as "feature not available" for all read-only
  // endpoints and returns graceful empty data.  Only 401 (session expired) is
  // mapped to the 'unauthorized' code that the blocs use to force re-login.
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
      // 403 = backend role restriction (PARENT not allowed) — not a session
      // error. Return empty so the UI renders an empty-state tile instead of
      // logging the user out.
      if (e.statusCode == 403) return const <WalletTransactionEntity>[];
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.fetchError,
        codeFromStatusCode: _classifyStatusCode,
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
      // 403 = PARENT role not authorised by the backend wallet controller.
      // Return an empty summary so the UI shows a zero-balance tile.
      if (e.statusCode == 403) {
        return WalletSummaryModel.fromJson(const <String, dynamic>{});
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.fetchError,
        codeFromStatusCode: _classifyStatusCode,
      );
    }
  }

  @override
  Future<ParentWalletAnalyticsEntity> getWalletAnalytics(
    String childId, {
    int months = 6,
  }) async {
    // API-CONTRACT: no wallet analytics endpoint in Postman or backend.
    // Returns empty on 404/405/403.
    try {
      final response = await _httpClient.get(
        '/api/parent/children/$childId/wallet/analytics',
        queryParameters: {'months': months},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return ParentWalletAnalyticsModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405 || e.statusCode == 403) {
        return ParentWalletAnalyticsModel.fromJson(const <String, dynamic>{});
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.fetchError,
      );
    }
  }

  // ─────────────────────── Parent's own wallet ────────────────────────────

  @override
  Future<WalletSummaryEntity> getMyWallet() async {
    // Backend /api/wallet/my is @PreAuthorize("hasRole('STUDENT')").
    // Parents get 403 — treat as "no wallet" rather than a session error.
    try {
      final response = await _httpClient.get('/api/wallet/my');
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return WalletSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 403) {
        return WalletSummaryModel.fromJson(const <String, dynamic>{});
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.fetchError,
        codeFromStatusCode: _classifyStatusCode,
      );
    }
  }

  @override
  Future<List<WalletTransactionEntity>> getMyTransactions({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    // Backend /api/wallet/my/transactions is @PreAuthorize("hasRole('STUDENT')").
    // Parents get 403 — return empty list.
    try {
      final response = await _httpClient.get(
        '/api/wallet/my/transactions',
        queryParameters: paginationInfo?.toJson(),
      );
      final root = asMap(response.data);
      final payload = root['data'] ?? response.data;
      final items = payload is Map
          ? asList(payload['content'])
          : asList(payload);
      return items
          .map((e) => WalletTransactionModel.fromJson(asMap(e)))
          .toList();
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 403) return const <WalletTransactionEntity>[];
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.fetchError,
        codeFromStatusCode: _classifyStatusCode,
      );
    }
  }

  @override
  Future<WalletSummaryEntity> topUpWallet({
    required double amount,
    String? studentId,
  }) async {
    if (amount <= 0) {
      throw const ParentFinancialRepositoryException(
        code: ParentFinancialRepositoryExceptionCode.invalidAmount,
        message: 'Top-up amount must be positive.',
      );
    }
    try {
      HttpClientResponse response;
      if (studentId != null && studentId.isNotEmpty) {
        final parsedStudentId = int.tryParse(studentId);
        response = await _httpClient.post(
          '/api/wallet/top-up',
          data: {
            'amount': amount,
            'studentId': parsedStudentId ?? studentId,
          },
        );
      } else {
        response = await _httpClient.post(
          '/api/payment/wallet/deposit',
          data: {
            'amount': amount,
            'paymentMethod': 'CASH',
          },
        );
      }
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      return WalletSummaryModel.fromJson(data);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 400 || e.statusCode == 422) {
        throw const ParentFinancialRepositoryException(
          code: ParentFinancialRepositoryExceptionCode.invalidAmount,
        );
      }
      if (e.statusCode == 402) {
        throw const ParentFinancialRepositoryException(
          code: ParentFinancialRepositoryExceptionCode.insufficientFunds,
        );
      }
      // 403 for top-up means the backend doesn't allow parents to top up.
      // Surface as topUpFailed (not unauthorized) — don't log the user out.
      if (e.statusCode == 403) {
        throw const ParentFinancialRepositoryException(
          code: ParentFinancialRepositoryExceptionCode.topUpFailed,
          message: 'Top-up is not available for your account type.',
        );
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.topUpFailed,
        codeFromStatusCode: _classifyStatusCode,
      );
    }
  }

  // 401 = session expired → unauthorized → blocs trigger re-login.
  // 403 = wrong role  → handled inline above as graceful empty / topUpFailed.
  ParentFinancialRepositoryExceptionCode _classifyStatusCode(int statusCode) {
    return switch (statusCode) {
      401 => ParentFinancialRepositoryExceptionCode.unauthorized,
      404 => ParentFinancialRepositoryExceptionCode.fetchError,
      _ => ParentFinancialRepositoryExceptionCode.unknown,
    };
  }

  @override
  Future<List<PaymentEntity>> getPayments(String childId) async {
    // API-CONTRACT: no per-child payments endpoint in Postman. Returns empty
    // on 404/405/403.
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
      if (e.statusCode == 404 || e.statusCode == 405 || e.statusCode == 403) {
        return const <PaymentEntity>[];
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentFinancialRepositoryExceptionCode.fetchError,
      );
    }
  }
}
