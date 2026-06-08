import 'package:mentorx_core/mentorx_core.dart';
import 'package:parent_dio_authentication_repository/parent_dio_authentication_repository.dart';

/// Dio-backed implementation of [ParentAccountStatusRepository].
///
/// Backend contract (EduCore Postman):
/// - `GET /api/auth/pending-status` — single-row payload describing the
///   review state; may not exist on older builds.
/// - `GET /api/auth/me`              — full authenticated user payload,
///   used as a fallback when pending-status is unavailable.
final class DioParentAccountStatusRepository
    extends
        HttpClientRepository<ParentAccountStatusRepositoryExceptionCode>
    implements ParentAccountStatusRepository {
  final HttpClient _httpClient;

  DioParentAccountStatusRepository({required HttpClient httpClient})
    : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentAccountStatusRepositoryExceptionCode code, {
    String? message,
  }) =>
      throw ParentAccountStatusRepositoryException(
        code: code,
        message: message,
      );

  @override
  Future<ParentAccountStatusEntity> getStatus() async {
    try {
      final response = await _httpClient.get('/api/auth/pending-status');
      return _parseStatus(response.data);
    } on HttpClientResponse catch (e) {
      // Fall through to /api/auth/me if the dedicated endpoint is missing.
      if (e.statusCode == 404 || e.statusCode == 405) {
        final user = await refreshAuthenticatedUser();
        if (user != null) {
          return ParentAccountStatusEntity(status: user.status);
        }
        return ParentAccountStatusEntity.placeholder;
      }
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAccountStatusRepositoryExceptionCode.fetchError,
        codeFromStatusCode: _classifyStatus,
      );
    }
  }

  @override
  Future<ParentEntity?> refreshAuthenticatedUser() async {
    try {
      final response = await _httpClient.get('/api/auth/me');
      final root = asMap(response.data);
      final payload = root['data'] is Map ? asMap(root['data']) : root;
      return ParentModel.fromJson(payload);
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404 || e.statusCode == 405) return null;
      return handleHttpClientErrorResponse(
        e,
        defaultCode:
            ParentAccountStatusRepositoryExceptionCode.fetchError,
        codeFromStatusCode: _classifyStatus,
      );
    }
  }

  // ──────────────────────── Helpers ────────────────────────────────────

  ParentAccountStatusEntity _parseStatus(dynamic raw) {
    final root = asMap(raw);
    final payload = root['data'] is Map ? asMap(root['data']) : root;

    return ParentAccountStatusEntity(
      status: _parseParentStatus(
        payload['status'] ??
            payload['accountStatus'] ??
            payload['account_status'] ??
            payload['pendingStatus'] ??
            payload['pending_status'],
      ),
      rejectionReason: _stringOrNull(
        payload['rejectionReason'] ?? payload['rejection_reason'],
      ),
      message: _stringOrNull(
        payload['message'] ?? payload['statusMessage'],
      ),
      submittedAt: _parseDateTime(
        payload['submittedAt'] ?? payload['submitted_at'] ?? payload['createdAt'],
      ),
      estimatedReviewBy: _parseDateTime(
        payload['estimatedReviewBy'] ??
            payload['estimated_review_by'] ??
            payload['reviewBy'],
      ),
      supportContact: _stringOrNull(
        payload['supportContact'] ??
            payload['support_contact'] ??
            payload['contact'],
      ),
    );
  }

  static ParentStatus _parseParentStatus(dynamic value) {
    if (value == null) return ParentStatus.pending;
    final str = value.toString().toLowerCase().trim();
    return ParentStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => ParentStatus.pending,
    );
  }

  static String? _stringOrNull(dynamic value) {
    if (value == null) return null;
    final str = value.toString().trim();
    return str.isEmpty ? null : str;
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }

  ParentAccountStatusRepositoryExceptionCode _classifyStatus(int statusCode) {
    return switch (statusCode) {
      401 || 403 =>
        ParentAccountStatusRepositoryExceptionCode.unauthorized,
      _ => ParentAccountStatusRepositoryExceptionCode.unknown,
    };
  }
}
