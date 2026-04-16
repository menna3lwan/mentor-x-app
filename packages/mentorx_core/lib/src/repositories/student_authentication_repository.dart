part of '../../mentorx_core.dart';

enum AuthenticationRepositoryExceptionCode {
  unknown,
  invalidPhoneNumber,
  invalidOtp,
  userNotFound,
  requiresOtp,
  deviceLimitReached,
  failedToSendOtp,
  failedToRequestPasswordReset,
  failedToResetPassword,
  failedToVerifyOtp,
  failedToGetCurrentUser,
  failedToResendOtp,
  failedToSignOut,
}

final class AuthenticationRepositoryException
    extends MentorXException<AuthenticationRepositoryExceptionCode> {
  AuthenticationRepositoryException({required super.code, super.message});
}

final class AuthenticationRequiresOtpException
    extends AuthenticationRepositoryException {
  final Duration? otpDuration;
  final int? otpLength;

  AuthenticationRequiresOtpException({
    required super.message,
    this.otpDuration,
    this.otpLength,
  }) : super(code: AuthenticationRepositoryExceptionCode.requiresOtp);
}

final class DeviceLimitReachedException
    extends AuthenticationRepositoryException {
  final int maxDevices;
  final List<DeviceEntity> activeDevices;

  DeviceLimitReachedException({
    required super.message,
    required this.maxDevices,
    required this.activeDevices,
  }) : super(code: AuthenticationRepositoryExceptionCode.deviceLimitReached);
}

enum OtpVerificationPurpose { registration, login, passwordReset }

// Authentication Repository
abstract interface class StudentAuthenticationRepository {
  String? get pendingOtpPhoneNumber;
  OtpVerificationPurpose get pendingOtpPurpose;

  void setOtpVerificationContext({
    required String phoneNumber,
    required OtpVerificationPurpose purpose,
  });

  void clearOtpVerificationContext();

  Future<void> initialize();
  Future<({Duration? otpDuration, int? otpLength})?> sendOtp(
    String phoneNumber,
  );
  Future<void> requestPasswordReset(String phoneNumber);
  Future<void> resetPassword({
    required String phoneNumber,
    required String otp,
    required String newPassword,
  });
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
