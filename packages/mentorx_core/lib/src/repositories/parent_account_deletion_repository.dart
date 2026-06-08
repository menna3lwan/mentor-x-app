part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentAccountDeletionRepositoryExceptionCode {
  unknown,
  submitError,
  unauthorized,
  networkError,
  /// Backend rejected the request because the consent flag wasn't set or
  /// the confirmation phrase was missing. Surfaced as a localised "please
  /// confirm" toast.
  validation,
}

final class ParentAccountDeletionRepositoryException
    extends MentorXException<ParentAccountDeletionRepositoryExceptionCode> {
  const ParentAccountDeletionRepositoryException({
    required super.code,
    super.message,
  });
}

// ——— Repository ———

/// Submits a parent-initiated "delete my account" request to the backend.
///
/// The flow is asynchronous on the backend side — submitting only *queues*
/// the deletion (compliance grace period, data export job, etc.). The
/// caller (cubit) is responsible for logging the user out as soon as the
/// repository returns; the session token is presumed invalid immediately
/// after.
abstract interface class ParentAccountDeletionRepository {
  Future<void> initialize();

  /// Sends the deletion request. Implementations MUST throw
  /// [ParentAccountDeletionRepositoryException] on failure; the bloc maps
  /// the [code] to a user-facing message and decides whether to retry.
  Future<void> submitDeletion(ParentAccountDeletionRequest request);
}
