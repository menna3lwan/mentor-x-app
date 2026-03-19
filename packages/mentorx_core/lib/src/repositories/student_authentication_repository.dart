part of '../../mentorx_core.dart';

enum AuthenticationRepositoryExceptionCode {
  unknown,
  invalidPhoneNumber,
  invalidOtp,
  userNotFound,
  failedToSendOtp,
  failedToVerifyOtp,
  failedToGetCurrentUser,
  failedToResendOtp,
  failedToSignOut,
}

final class AuthenticationRepositoryException
    extends MentorXException<AuthenticationRepositoryExceptionCode> {
  AuthenticationRepositoryException({required super.code, super.message});
}

// Authentication Repository
abstract interface class StudentAuthenticationRepository {
  Future<void> initialize();
  Future<({Duration? otpDuration, int? otpLength})?> sendOtp(
    String phoneNumber,
  );
  Future<StudentEntity> loginWithPassword({
    required String phoneNumber,
    required String password,
  });
  Future<StudentEntity> verifyOtp(String otp);
  Future<void> signOut();
  Future<StudentEntity?> getCurrentUser();
  Future<Duration?> resendOtp(String phoneNumber);
  Future<StudentEntity?> getCachedUser();
  Future<StudentEntity> getAccountStatus();
}
