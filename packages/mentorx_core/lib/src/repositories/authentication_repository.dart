part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception codes ———

enum AuthenticationExceptionCode {
  unknown,
  invalidCredentials,
  otpRequired,
  networkError,
  sessionExpired,
  invalidOtp,
  studentNotFound,
  phoneAlreadyExists,
  registrationFailed,
  failedToSendOtp,
  failedToResendOtp,
  failedToRequestPasswordReset,
  failedToResetPassword,
}

// ——— Typed exception ———

final class AuthenticationException
    extends MentorXException<AuthenticationExceptionCode> {
  const AuthenticationException({required super.code, super.message});
}

// ——— Repository interface ———

abstract interface class AuthenticationRepository<T> {
  Future<void> initialize();
  Future<T> login({
    required String phone,
    required String password,
    String? deviceHash,
    String? deviceName,
    String? fcmToken,
    String? appVersion,
  });
  Future<ParentStudentLookupEntity> findStudentForParentRegistration({
    required ParentLookupType lookupType,
    required String value,
  });
  Future<ParentRegistrationResult> registerParent({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String relationship,
    required String studentId,
    String? email,
    String? deviceHash,
    String? deviceName,
    String? fcmToken,
    String? appVersion,
  });
  Future<void> logout();
  Future<T?> getCachedUser();
  Future<void> sendOtp(String phone);
  Future<Duration?> resendOtp(String phone);
  Future<void> requestPasswordReset(String phone);
  Future<void> resetPassword({
    required String phone,
    required String otp,
    required String newPassword,
  });
  Future<T> verifyOtp(String phone, String code);
}
