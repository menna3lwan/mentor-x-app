part of 'package:mentorx_core/mentorx_core.dart';

enum StudentProfileRepositoryExceptionCode {
  unknown,
  failedToSubmitEditRequest,
  failedToLoadEditRequests,
  failedToVerifyIdentity,
  failedToGetVerificationStatus,
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
    required String newValue,
    String? reason,
  });

  /// Get pending edit requests.
  Future<List<ProfileEditRequestEntity>> getPendingEditRequests();

  /// Submit national ID verification (OCR upload).
  Future<NationalIdVerificationEntity> verifyIdentity(String imagePath);

  /// Get current national ID verification status.
  Future<NationalIdVerificationEntity> getVerificationStatus();
}
