import 'dart:async';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockAuthenticationRepository implements AuthenticationRepository<ParentEntity> {
  final Duration delay;
  final String mockPhone;
  final String mockOtp;
  final String mockUserName;

  ParentEntity? _cachedUser;
  bool _passwordResetRequested = false;
  ParentStudentLookupEntity? _lastLookedUpStudent;
  ParentRegistrationResult? _pendingRegistration;

  static const List<ParentStudentLookupEntity> _mockStudents = [
    ParentStudentLookupEntity(
      studentId: '42',
      maskedName: 'Ah** Mo**',
      gradeName: 'Grade 10',
      centerName: 'Maadi Branch',
      canAutoVerify: true,
    ),
    ParentStudentLookupEntity(
      studentId: '84',
      maskedName: 'Sa** Al**',
      gradeName: 'Grade 7',
      centerName: 'Maadi Branch',
      canAutoVerify: false,
    ),
  ];

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
    String? deviceHash,
    String? deviceName,
    String? fcmToken,
    String? appVersion,
  }) async {
    await Future.delayed(delay);
    if (phone == '01011111111' && password == 'Test@1234') {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.otpRequired,
        message: 'OTP verification is required to continue.',
      );
    }
    if (phone == mockPhone) {
      final user = MockParentGenerator.generate(
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
  Future<ParentStudentLookupEntity> findStudentForParentRegistration({
    required ParentLookupType lookupType,
    required String value,
  }) async {
    await Future.delayed(delay);

    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.studentNotFound,
        message: 'Please enter a child phone or student code.',
      );
    }

    ParentStudentLookupEntity? matched;
    if (lookupType == ParentLookupType.phone) {
      if (trimmedValue == '01012345678') {
        matched = _mockStudents.first;
      }
      if (trimmedValue == '01087654321') {
        matched = _mockStudents.last;
      }
    } else {
      if (trimmedValue.toUpperCase() == 'MX-1001') {
        matched = _mockStudents.first;
      }
      if (trimmedValue.toUpperCase() == 'MX-2002') {
        matched = _mockStudents.last;
      }
    }

    if (matched == null) {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.studentNotFound,
        message: 'No student found with this phone number/code.',
      );
    }

    _lastLookedUpStudent = matched;
    return matched;
  }

  @override
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
  }) async {
    await Future.delayed(delay);

    if (phone.trim().isEmpty || password.trim().isEmpty) {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.registrationFailed,
        message: 'Phone and password are required.',
      );
    }
    if (password.trim().length < 8) {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.registrationFailed,
        message: 'Password must be at least 8 characters.',
      );
    }

    if (phone == mockPhone) {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.phoneAlreadyExists,
        message: 'This phone number is already registered.',
      );
    }

    final matchedStudent = _lastLookedUpStudent;
    if (matchedStudent == null || matchedStudent.studentId != studentId) {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.studentNotFound,
        message: 'Please find and confirm your child first.',
      );
    }

    _pendingRegistration = ParentRegistrationResult(
      userId: 'parent_${DateTime.now().millisecondsSinceEpoch}',
      status: 'active',
      childLinkStatus: matchedStudent.canAutoVerify
          ? ParentChildLinkStatus.linked
          : ParentChildLinkStatus.pending,
    );

    await sendOtp(phone);

    return _pendingRegistration!;
  }

  @override
  Future<void> logout() async {
    _cachedUser = null;
  }

  @override
  Future<void> forceLogoutAll() async {
    _cachedUser = null;
  }

  @override
  Future<ParentEntity> getMe() async {
    await Future.delayed(delay);
    if (_cachedUser != null) {
      return _cachedUser!;
    }
    throw const AuthenticationException(
      code: AuthenticationExceptionCode.unknown,
      message: 'User not found',
    );
  }

  @override
  Future<ParentEntity?> getCachedUser() async {
    return _cachedUser;
  }

  @override
  Future<void> sendOtp(String phone) async {
    await Future.delayed(delay);
    if (phone.isEmpty) {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.failedToSendOtp,
        message: 'Phone number is required',
      );
    }
  }

  @override
  Future<Duration?> resendOtp(String phone) async {
    await Future.delayed(delay);
    if (phone.isEmpty) {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.failedToResendOtp,
        message: 'Phone number is required',
      );
    }

    return const Duration(seconds: 60);
  }

  @override
  Future<void> requestPasswordReset(String phone) async {
    await Future.delayed(delay);
    if (phone != mockPhone) {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.failedToRequestPasswordReset,
        message: 'Phone number not found',
      );
    }

    _passwordResetRequested = true;
  }

  @override
  Future<void> resetPassword({
    required String phone,
    required String otp,
    required String newPassword,
  }) async {
    await Future.delayed(delay);

    if (!_passwordResetRequested || phone != mockPhone) {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.failedToResetPassword,
        message: 'Password reset request expired',
      );
    }

    if (otp != mockOtp) {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.invalidOtp,
        message: 'Invalid OTP code',
      );
    }

    if (newPassword.trim().length < 8) {
      throw const AuthenticationException(
        code: AuthenticationExceptionCode.failedToResetPassword,
        message: 'Password must be at least 8 characters',
      );
    }

    _passwordResetRequested = false;
  }

  @override
  Future<ParentEntity> verifyOtp(String phone, String code) async {
    await Future.delayed(delay);
    if (code == mockOtp) {
      final user = MockParentGenerator.generate(
        phoneNumber: phone,
      );
      _cachedUser = user;
      _pendingRegistration = null;
      return user;
    }
    throw const AuthenticationException(
      code: AuthenticationExceptionCode.invalidOtp,
      message: 'Invalid OTP code',
    );
  }
}
