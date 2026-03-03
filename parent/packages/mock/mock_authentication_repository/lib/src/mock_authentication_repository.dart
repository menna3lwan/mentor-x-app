import 'dart:async';
import 'package:parent_core/parent_core.dart';

class MockAuthenticationRepository implements AuthenticationRepository {
  ParentEntity? _cachedUser;

  @override
  Future<void> initialize() async {
    // Simulate init
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<ParentEntity> login({
    required String phone,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    if (phone == "01000000000" && password == "password") {
      final user = ParentEntity(
        id: "mock_id_123",
        name: "Mock Parent",
        phoneNumber: phone,
      );
      _cachedUser = user;
      return user;
    } else {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.invalidCredentials,
        message: "Invalid phone or password in mock",
      );
    }
  }

  @override
  Future<void> logout() async {
    _cachedUser = null;
  }

  @override
  Future<ParentEntity?> getCachedUser() async {
    return _cachedUser;
  }

  @override
  Future<void> sendOtp(String phone) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<ParentEntity> verifyOtp(String phone, String code) async {
    await Future.delayed(const Duration(seconds: 1));
    if (code == "123456") {
      final user = ParentEntity(
        id: "mock_id_123",
        name: "Mock Parent",
        phoneNumber: phone,
      );
      _cachedUser = user;
      return user;
    } else {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.invalidOtp,
        message: "Invalid OTP",
      );
    }
  }
}
