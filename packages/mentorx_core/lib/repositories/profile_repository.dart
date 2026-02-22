part of '../mentorx_core.dart';

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
  /// Get the current user's full profile.
  Future<StudentEntity> getProfile();

  /// Get registered devices.
  Future<List<DeviceEntity>> getDevices();

  /// Deactivate a device by ID.
  Future<void> deactivateDevice(String deviceId);
}
