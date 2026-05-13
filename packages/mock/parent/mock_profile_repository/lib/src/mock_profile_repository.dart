import 'package:mentorx_core/mentorx_core.dart';

class MockProfileRepository implements ParentProfileRepository {
  final Duration delay;
  ParentEntity _profile;

  MockProfileRepository({
    this.delay = const Duration(milliseconds: 800),
  }) : _profile = ParentEntity(
          id: 'p-1',
          firstName: 'Ahmed',
          lastName: 'Hassan',
          email: 'ahmed.hassan@example.com',
          phoneNumber: '+201001234567',
          status: ParentStatus.active,
          createdAt: DateTime.now().subtract(const Duration(days: 365)),
          updatedAt: DateTime.now(),
          childrenCount: 2,
          walletBalance: 1500.0,
          totalPoints: 450,
        );

  @override
  Future<void> initialize() async {}

  @override
  Future<ParentEntity> getProfile() async {
    await Future.delayed(delay);
    return _profile;
  }

  @override
  Future<ParentEntity> updateProfile(ParentEntity profile) async {
    await Future.delayed(delay);
    _profile = profile;
    return _profile;
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await Future.delayed(delay);
    if (currentPassword == newPassword) {
      throw ParentProfileRepositoryException(
        code: ParentProfileRepositoryExceptionCode.failedToUpdateProfile,
        message: 'New password must be different',
      );
    }
  }
}
