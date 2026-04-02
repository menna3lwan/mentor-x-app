import 'dart:async';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockAuthenticationRepository implements AuthenticationRepository {
  final Duration delay;
  final String mockPhone;
  final String mockOtp;
  final String mockUserName;

  ParentEntity? _cachedUser;

  MockAuthenticationRepository({
    this.delay = const Duration(seconds: 1),
    this.mockPhone = '01000000000',
    this.mockOtp = '123456',
    this.mockUserName = 'Mock Parent',
  });

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<ParentEntity> login({
    required String phone,
    required String password,
  }) async {
    await Future.delayed(delay);
    if (phone == mockPhone) {
      final user = MockParentGenerator.generate(
        name: mockUserName,
        phoneNumber: phone,
      );
      _cachedUser = user;
      return user;
    }
    throw const AuthenticationException(
      code: AuthenticationExceptionCode.invalidCredentials,
      message: 'Invalid phone or password',
    );
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
    await Future.delayed(delay);
  }

  @override
  Future<ParentEntity> verifyOtp(String phone, String code) async {
    await Future.delayed(delay);
    if (code == mockOtp) {
      final user = MockParentGenerator.generate(
        name: mockUserName,
        phoneNumber: phone,
      );
      _cachedUser = user;
      return user;
    }
    throw const AuthenticationException(
      code: AuthenticationExceptionCode.invalidOtp,
      message: 'Invalid OTP code',
    );
  }
}
