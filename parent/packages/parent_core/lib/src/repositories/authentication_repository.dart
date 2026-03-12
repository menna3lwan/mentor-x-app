part of '../../parent_core.dart';

// ——— Exception codes ———

enum AuthenticationExceptionCode {
  unknown,
  invalidCredentials,
  networkError,
  sessionExpired,
  invalidOtp,
}

// ——— Typed exception ———

final class AuthenticationException
    extends MentorXException<AuthenticationExceptionCode> {
  const AuthenticationException({
    required super.code,
    super.message,
  });
}

// ——— Repository interface ———

abstract interface class AuthenticationRepository {
  Future<void> initialize();
  Future<ParentEntity> login({required String phone, required String password});
  Future<void> logout();
  Future<ParentEntity?> getCachedUser();
  Future<void> sendOtp(String phone);
  Future<ParentEntity> verifyOtp(String phone, String code);
}
