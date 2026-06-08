import 'package:mentorx_core/mentorx_core.dart';

/// In-memory mock for the account-status repository.
///
/// Simulates the typical pending-review timeline:
/// - first `getStatus()` call → `pending`.
/// - after [autoApproveAfter] elapsed since first poll → `active`.
///
/// The caller can override the initial behaviour via [initialStatus] for
/// widget tests that want to land on a specific state.
final class MockParentAccountStatusRepository
    implements ParentAccountStatusRepository {
  final Duration delay;

  /// Time after the first poll before the mock automatically flips the
  /// status from `pending` to `active`. Defaults to a short window so dev
  /// builds see the transition without sitting around.
  final Duration autoApproveAfter;

  ParentStatus _status;
  DateTime? _firstPolledAt;
  ParentEntity? _cachedUser;

  MockParentAccountStatusRepository({
    this.delay = const Duration(milliseconds: 600),
    this.autoApproveAfter = const Duration(seconds: 30),
    ParentStatus initialStatus = ParentStatus.pending,
    ParentEntity? initialUser,
  }) : _status = initialStatus,
       _cachedUser = initialUser;

  @override
  Future<void> initialize() async {}

  @override
  Future<ParentAccountStatusEntity> getStatus() async {
    await Future<void>.delayed(delay);
    _firstPolledAt ??= DateTime.now();
    if (_status == ParentStatus.pending &&
        DateTime.now().difference(_firstPolledAt!) >= autoApproveAfter) {
      _status = ParentStatus.active;
    }
    return ParentAccountStatusEntity(
      status: _status,
      message: _status == ParentStatus.pending
          ? 'Your account is under review. We\'ll notify you once approved.'
          : null,
      submittedAt: _firstPolledAt,
      estimatedReviewBy: _firstPolledAt?.add(const Duration(hours: 24)),
      supportContact: 'support@mentorx.com',
    );
  }

  @override
  Future<ParentEntity?> refreshAuthenticatedUser() async {
    await Future<void>.delayed(delay);
    if (_cachedUser == null) return null;
    return _cachedUser!.copyWith(status: _status);
  }

  /// Test/dev hook to nudge the mock state without waiting for the auto
  /// approve timer.
  void setStatus(ParentStatus status) {
    _status = status;
  }
}
