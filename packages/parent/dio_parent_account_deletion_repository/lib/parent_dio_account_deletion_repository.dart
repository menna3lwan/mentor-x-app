import 'package:mentorx_core/mentorx_core.dart';

/// Dio-backed implementation of [ParentAccountDeletionRepository].
///
/// Backend contract:
/// - `POST /api/auth/delete-account` with the request body produced by
///   [ParentAccountDeletionRequest.toJson]. EduCore may also accept
///   `DELETE /api/auth/me` on older builds; we try the POST first and
///   fall back to DELETE on 404/405.
/// - 401/403 → caller is logged out (token already invalid).
/// - 422       → backend rejected the payload (e.g. missing consent);
///                surfaced as a `validation` code so the bloc can show
///                a localized hint instead of a generic error.
final class DioParentAccountDeletionRepository
    extends HttpClientRepository<ParentAccountDeletionRepositoryExceptionCode>
    implements ParentAccountDeletionRepository {
  final HttpClient _httpClient;

  DioParentAccountDeletionRepository({required HttpClient httpClient})
    : _httpClient = httpClient;

  @override
  Future<void> initialize() async {}

  @override
  Never throwException(
    ParentAccountDeletionRepositoryExceptionCode code, {
    String? message,
  }) => throw ParentAccountDeletionRepositoryException(
    code: code,
    message: message,
  );

  @override
  Future<void> submitDeletion(ParentAccountDeletionRequest request) async {
    final body = request.toJson();
    try {
      await _httpClient.post('/api/auth/delete-account', data: body);
      return;
    } on HttpClientResponse catch (e) {
      // Older backend builds expose the same operation as `DELETE
      // /api/auth/me`. We attempt the fallback only if the POST endpoint
      // is missing (404/405), not when it returns a validation error.
      if (e.statusCode == 404 || e.statusCode == 405) {
        try {
          await _httpClient.delete('/api/auth/me');
          return;
        } on HttpClientResponse catch (deleteError) {
          handleHttpClientErrorResponse(
            deleteError,
            defaultCode:
                ParentAccountDeletionRepositoryExceptionCode.submitError,
            codeFromStatusCode: _classifyStatus,
          );
        }
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: ParentAccountDeletionRepositoryExceptionCode.submitError,
        codeFromStatusCode: _classifyStatus,
      );
    }
  }

  ParentAccountDeletionRepositoryExceptionCode _classifyStatus(int code) {
    return switch (code) {
      401 || 403 => ParentAccountDeletionRepositoryExceptionCode.unauthorized,
      422 => ParentAccountDeletionRepositoryExceptionCode.validation,
      _ => ParentAccountDeletionRepositoryExceptionCode.unknown,
    };
  }
}
