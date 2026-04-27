part of 'package:mentorx_core/mentorx_core.dart';

enum ProfileRepositoryExceptionCode {
  unknown,
  failedToLoadProfile,
  failedToUpdateProfile,
  failedToLoadDevices,
  failedToDeactivateDevice,
}

final class ProfileRepositoryException
    extends MentorXException<ProfileRepositoryExceptionCode> {
  ProfileRepositoryException({required super.code, super.message});
}

abstract interface class ProfileRepository {
  Future<void> initialize();

  /// Get the current user's full profile.
  Future<StudentEntity> getProfile();

  /// Get registered devices.
  Future<List<DeviceEntity>> getDevices();

  /// Deactivate a device by ID.
  Future<void> deactivateDevice(String deviceId);

  /// Change user password.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Update user profile.
  Future<StudentEntity> updateProfile(StudentEntity profile);
}
