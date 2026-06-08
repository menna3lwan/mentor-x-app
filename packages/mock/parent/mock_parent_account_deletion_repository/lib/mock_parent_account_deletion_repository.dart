import 'package:mentorx_core/mentorx_core.dart';

/// In-memory mock of [ParentAccountDeletionRepository].
///
/// Behaviour:
/// - Validates the same guards the real backend would enforce
///   (`acknowledgedPermanent` must be true) so the bloc-level wiring is
///   exercised end-to-end during local development.
/// - Sleeps for [delay] to mimic network latency.
/// - Tracks the last submitted [ParentAccountDeletionRequest] so widget
///   tests can assert against it.
final class MockParentAccountDeletionRepository
    implements ParentAccountDeletionRepository {
  final Duration delay;

  /// Optional toggle to make the next `submitDeletion` call throw
  /// `submitError` so QA can exercise the failure branch without backend
  /// help.
  bool failNext;

  ParentAccountDeletionRequest? lastRequest;

  MockParentAccountDeletionRepository({
    this.delay = const Duration(milliseconds: 600),
    this.failNext = false,
  });

  @override
  Future<void> initialize() async {}

  @override
  Future<void> submitDeletion(ParentAccountDeletionRequest request) async {
    await Future<void>.delayed(delay);
    lastRequest = request;
    if (failNext) {
      failNext = false;
      throw const ParentAccountDeletionRepositoryException(
        code: ParentAccountDeletionRepositoryExceptionCode.submitError,
        message: 'Mocked failure',
      );
    }
    if (!request.acknowledgedPermanent) {
      throw const ParentAccountDeletionRepositoryException(
        code: ParentAccountDeletionRepositoryExceptionCode.validation,
        message: 'Permanent-deletion acknowledgement required.',
      );
    }
    // Success — repository is fire-and-forget.
  }
}
