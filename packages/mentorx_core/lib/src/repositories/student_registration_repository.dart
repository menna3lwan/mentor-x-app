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
  /// Step 1: Start registration by sending basic info.
  /// Triggers OTP.
  Future<void> startRegistration({
    required String firstName,
    required String phone,
    required String parentPhone,
  });

  /// Resend OTP if needed.
  Future<void> resendOtp(String phone);

  /// Step 3: Complete registration with all details and OTP.
  /// Uses multipart/form-data for images and query parameters for other fields as per API spec.
  Future<void> completeRegistration({
    required String firstName,
    required String secondName,
    required String thirdName,
    required String fourthName,
    required String governorate,
    required String area,
    required String grade,
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
  Future<List<String>> getAreas(String governorate);
  Future<Map<String, dynamic>> getApplicationInfo();
  Future<bool> checkPhone(String phone);
}
