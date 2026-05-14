part of 'package:mentorx_core/mentorx_core.dart';

enum StudentProfileRepositoryExceptionCode {
  unknown,
  failedToSubmitEditRequest,
  failedToLoadEditRequests,
  failedToLoadProfile,
  failedToUpdateProfile,
  failedToLoadDevices,
  failedToDeactivateDevice,
}

final class StudentProfileRepositoryException
    extends MentorXException<StudentProfileRepositoryExceptionCode> {
  const StudentProfileRepositoryException({required super.code, super.message});
}

abstract interface class StudentProfileRepository implements ProfileRepository {
  @override
  Future<void> initialize();

  /// Submit a profile edit request.
  Future<ProfileEditRequestEntity> submitEditRequest({
    required String fieldName,
    required String oldValue,
    required String newValue,
    String? reason,
  });

  /// Get pending edit requests.
  Future<List<ProfileEditRequestEntity>> getPendingEditRequests();

  /// Update student location.
  Future<void> updateLocation({
    required String governorate,
    required String city,
    required String area,
  });

  // Pro Features
  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
