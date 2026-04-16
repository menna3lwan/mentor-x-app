part of '../../mentorx_core.dart';

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

abstract interface class AuthenticationRepository {
  Future<void> initialize();
  Future<ParentEntity> login({required String phone, required String password});
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
  Future<ParentEntity?> getCachedUser();
  Future<void> sendOtp(String phone);
  Future<Duration?> resendOtp(String phone);
  Future<void> requestPasswordReset(String phone);
  Future<void> resetPassword({
    required String phone,
    required String otp,
    required String newPassword,
  });
  Future<ParentEntity> verifyOtp(String phone, String code);
}
