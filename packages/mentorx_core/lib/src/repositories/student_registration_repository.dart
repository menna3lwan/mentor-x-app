part of 'package:mentorx_core/mentorx_core.dart';

enum StudentRegistrationExceptionCode {
  unknown,
  phoneAlreadyExists,
  failedToLoadGovernorates,
  failedToLoadAreas,
  failedToLoadApplicationInfo,
  failedToStartRegistration,
  failedToResendOtp,
  failedToCompleteRegistration,
  invalidOtp,
}

final class StudentRegistrationException
    extends MentorXException<StudentRegistrationExceptionCode> {
  StudentRegistrationException({required super.code, super.message});
}

abstract interface class StudentRegistrationRepository {
  Future<void> initialize();

  /// Step 1: Start registration by sending basic info.
  /// Triggers OTP.
  Future<void> startRegistration({
    required String phone,
  });

  /// Step 2: Verify OTP code before proceeding.
  Future<void> verifyOtp({
    required String phone,
    required String otp,
    int? tenantId,
  });

  /// Resend OTP if needed.
  Future<void> resendOtp(String phone);

  /// Step 3: Complete registration with all details and OTP.
  /// Uses multipart/form-data for images and query parameters for other fields as per API spec.
  Future<StudentRegistrationResponseEntity> completeRegistration({
    required String firstName,
    required String secondName,
    required String thirdName,
    required String fourthName,
    required String governorateId,
    required String area,
    required String gradeId,
    required bool online,
    required String otp,
    required String parentPhone,
    required String phone,
    required String password,
    required String confirmPassword,
    String? schoolName,
    String? educationDepartment,
    String? centerName,
    String? profileImagePath,
    String? identityDocumentPath,
  });

  /// Lookups
  Future<List<GovernorateEntity>> getGovernorates();
  Future<List<GovernorateEntity>> getGovernoratesWithAreas();
  Future<List<AreaEntity>> getAreas(String governorateId);
  Future<List<Map<String, dynamic>>> getCenters({String? governorate});
  Future<StudentApplicationInfoEntity> getApplicationInfo();
  Future<bool> checkPhone(String phone);
}
