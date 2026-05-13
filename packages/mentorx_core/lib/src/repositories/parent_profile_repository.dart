part of 'package:mentorx_core/mentorx_core.dart';

enum ParentProfileRepositoryExceptionCode {
  unknown,
  failedToLoadProfile,
  failedToUpdateProfile,
}

final class ParentProfileRepositoryException
    extends MentorXException<ParentProfileRepositoryExceptionCode> {
  ParentProfileRepositoryException({required super.code, super.message});
}

abstract interface class ParentProfileRepository {
  Future<void> initialize();

  /// Get the current parent's full profile.
  Future<ParentEntity> getProfile();

  /// Update user profile.
  Future<ParentEntity> updateProfile(ParentEntity profile);

  /// Change user password.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
