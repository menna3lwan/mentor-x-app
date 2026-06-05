import 'package:mentorx_core/mentorx_core.dart';

/// In-memory mock of [ParentProfileRepository] used in `mock` builds.
///
/// Returns a stable [ParentEntity] that can be mutated in place by
/// `updateProfile`/`uploadAvatar` so the UI behaves like a real backend
/// without making any network calls.
final class MockParentProfileRepository implements ParentProfileRepository {
  final Duration delay;

  ParentEntity _profile;

  MockParentProfileRepository({
    this.delay = const Duration(milliseconds: 600),
    ParentEntity? initialProfile,
  }) : _profile = initialProfile ?? _seed();

  @override
  Future<void> initialize() async {}

  @override
  Future<ParentEntity> getProfile() async {
    await Future<void>.delayed(delay);
    return _profile;
  }

  @override
  Future<ParentEntity> updateProfile({String? name}) async {
    await Future<void>.delayed(delay);
    if (name == null || name.trim().isEmpty) {
      return _profile;
    }
    final parts = name.trim().split(RegExp(r'\s+'));
    final firstName = parts.isEmpty ? _profile.firstName : parts.first;
    final lastName = parts.length > 1
        ? parts.sublist(1).join(' ')
        : _profile.lastName;
    _profile = _profile.copyWith(
      firstName: firstName,
      lastName: lastName,
      updatedAt: DateTime.now(),
    );
    return _profile;
  }

  @override
  Future<ParentEntity> uploadAvatar(String imagePath) async {
    await Future<void>.delayed(delay);
    if (imagePath.trim().isEmpty) {
      throw const ParentProfileRepositoryException(
        code: ParentProfileRepositoryExceptionCode.invalidImage,
        message: 'No image was provided.',
      );
    }
    // The mock just echoes back the local path so the UI can preview it.
    _profile = _profile.copyWith(
      profileImageUrl: imagePath,
      updatedAt: DateTime.now(),
    );
    return _profile;
  }

  static ParentEntity _seed() {
    final now = DateTime.now();
    return ParentEntity(
      id: 'mock-parent-1',
      firstName: 'محمد',
      lastName: 'السعدي',
      phoneNumber: '01000000000',
      email: 'parent@example.com',
      status: ParentStatus.active,
      createdAt: now.subtract(const Duration(days: 120)),
      updatedAt: now,
      childrenCount: 2,
      walletBalance: 350.0,
      totalPoints: 120,
    );
  }
}
