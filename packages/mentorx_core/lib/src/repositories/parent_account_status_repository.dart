part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentAccountStatusRepositoryExceptionCode {
  unknown,
  fetchError,
  unauthorized,
  networkError,
}

final class ParentAccountStatusRepositoryException
    extends MentorXException<ParentAccountStatusRepositoryExceptionCode> {
  const ParentAccountStatusRepositoryException({
    required super.code,
    super.message,
  });
}

// ——— Repository ———

/// Polls the backend for the parent account's review state.
///
/// Backed by `GET /api/auth/pending-status` with optional fall-through to
/// `GET /api/auth/me` (which is exposed in Postman as a generic "current
/// user" endpoint) so the cubit can still resolve status when the
/// dedicated endpoint is missing on older backend builds.
abstract interface class ParentAccountStatusRepository {
  Future<void> initialize();

  /// Returns the latest [ParentAccountStatusEntity]. Implementations MUST
  /// never throw on 404/405 of the pending-status endpoint — they should
  /// fall back to /api/auth/me or return a default `pending` status so
  /// the UI can still render meaningfully.
  Future<ParentAccountStatusEntity> getStatus();

  /// Refreshes the cached [ParentEntity] from `GET /api/auth/me`. The
  /// caller passes the result back into [AppAuthenticationCubit.update].
  /// Returns `null` if the endpoint is unavailable.
  Future<ParentEntity?> refreshAuthenticatedUser();
}
