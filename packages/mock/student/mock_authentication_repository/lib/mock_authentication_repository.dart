import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockAuthenticationRepository
    implements StudentAuthenticationRepository {
  final Duration delay;

  // Simulated state
  String? _sentOtpPhoneNumber;
  String? _validOtp;
  StudentEntity? _currentUser;
  bool _isInitialized = false;
  OtpVerificationPurpose _pendingOtpPurpose = OtpVerificationPurpose.login;

  final MentorXLogger _logger = MentorXLogger('MockAuthenticationRepository');

  MockAuthenticationRepository({this.delay = const Duration(seconds: 2)});

  Future<void> get _delay async => await Future.delayed(delay);

  @override
  Future<void> initialize() async {
    _isInitialized = true;
  }

  @override
  String? get pendingOtpPhoneNumber => _sentOtpPhoneNumber;

  @override
  OtpVerificationPurpose get pendingOtpPurpose => _pendingOtpPurpose;

  @override
  void setOtpVerificationContext({
    required String phoneNumber,
    required OtpVerificationPurpose purpose,
  }) {
    _sentOtpPhoneNumber = phoneNumber;
    _pendingOtpPurpose = purpose;
  }

  @override
  void clearOtpVerificationContext() {
    _sentOtpPhoneNumber = null;
    _pendingOtpPurpose = OtpVerificationPurpose.login;
  }

  @override
  Future<({Duration? otpDuration, int? otpLength})?> sendOtp(
    String phoneNumber,
  ) async {
    await _delay;

    if (!_isInitialized) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.unknown,
        message: 'Repository not initialized',
      );
    }

    // Store OTP details
    setOtpVerificationContext(
      phoneNumber: phoneNumber,
      purpose: OtpVerificationPurpose.registration,
    );
    _validOtp = '000000';

    // Simulate OTP sent successfully
    _logger.info(
      'Mock OTP sent to $phoneNumber: $_validOtp',
    ); // For testing purposes

    return (
      otpDuration: MockDataConfig.otpDuration,
      otpLength: MockDataConfig.otpLength,
    );
  }

  @override
  Future<void> requestPasswordReset(String phoneNumber) async {
    await _delay;

    if (!_isInitialized) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.unknown,
        message: 'Repository not initialized',
      );
    }

    if (phoneNumber.trim().isEmpty) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.invalidPhoneNumber,
        message: 'Phone number is required',
      );
    }

    setOtpVerificationContext(
      phoneNumber: phoneNumber,
      purpose: OtpVerificationPurpose.passwordReset,
    );
    _validOtp = '000000';

    _logger.info('Mock password reset requested for $phoneNumber');
  }

  @override
  Future<void> resetPassword({
    required String phoneNumber,
    required String otp,
    required String newPassword,
  }) async {
    await _delay;

    if (!_isInitialized) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.unknown,
        message: 'Repository not initialized',
      );
    }

    if (_sentOtpPhoneNumber == null || _validOtp == null) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.failedToResetPassword,
        message: 'No reset request found for this phone number',
      );
    }

    if (phoneNumber != _sentOtpPhoneNumber) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.invalidPhoneNumber,
        message: 'Phone number does not match the reset request',
      );
    }

    if (otp != _validOtp) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.invalidOtp,
        message: 'Invalid OTP provided',
      );
    }

    if (newPassword.length < 8) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.failedToResetPassword,
        message: 'Password must be at least 8 characters long',
      );
    }

    _validOtp = null;
    _logger.info('Mock password reset completed for $phoneNumber');
  }

  @override
  Future<StudentEntity> loginWithPassword({
    required String phoneNumber,
    required String password,
  }) async {
    await _delay;

    if (!_isInitialized) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.unknown,
        message: 'Repository not initialized',
      );
    }

    // if (password != 'password123') {
    //    throw AuthenticationRepositoryException(
    //     code: AuthenticationRepositoryExceptionCode.unknown,
    //     message: 'Invalid credentials. Use password123 to mock login.',
    //   );
    // }

    if (phoneNumber == '01000000004') {
      setOtpVerificationContext(
        phoneNumber: phoneNumber,
        purpose: OtpVerificationPurpose.login,
      );
      _validOtp = '000000';

      throw AuthenticationRequiresOtpException(
        message: 'OTP verification is required to continue.',
        otpDuration: MockDataConfig.otpDuration,
        otpLength: MockDataConfig.otpLength,
      );
    }

    if (phoneNumber == '01000000005') {
      throw DeviceLimitReachedException(
        message: 'Maximum number of devices reached.',
        maxDevices: 1,
        activeDevices: [
          DeviceEntity(
            id: 'device-1',
            deviceName: 'Current Test Device',
            deviceModel: 'iPhone',
            isActive: true,
            lastUsedAt: DateTime.fromMillisecondsSinceEpoch(0),
          ),
        ],
      );
    }

    _currentUser = MockStudentGenerator.generate(
      phoneNumber: phoneNumber,
    ).copyWith(status: _statusForPhone(phoneNumber));

    setOtpVerificationContext(
      phoneNumber: phoneNumber,
      purpose: OtpVerificationPurpose.login,
    );

    return _currentUser!;
  }

  @override
  Future<StudentEntity> verifyOtp(String otp) async {
    await _delay;

    if (!_isInitialized) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.unknown,
        message: 'Repository not initialized',
      );
    }

    if (_sentOtpPhoneNumber == null || _validOtp == null) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.failedToVerifyOtp,
        message: 'No OTP was sent',
      );
    }

    if (otp != _validOtp) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.invalidOtp,
        message: 'Invalid OTP provided',
      );
    }

    _currentUser = MockStudentGenerator.generate(
      phoneNumber: _sentOtpPhoneNumber!,
    ).copyWith(status: _statusForPhone(_sentOtpPhoneNumber!));

    // Clear OTP after successful verification
    _validOtp = null;
    clearOtpVerificationContext();

    return _currentUser!;
  }

  @override
  Future<void> logout() async {
    await _delay;

    if (!_isInitialized) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.unknown,
        message: 'Repository not initialized',
      );
    }

    if (_currentUser == null) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.failedToLogout,
        message: 'No user is currently signed in',
      );
    }

    _currentUser = null;
    clearOtpVerificationContext();
    _validOtp = null;
  }

  @override
  Future<void> refreshToken() async {
    await _delay;
    if (!_isInitialized) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.failedToRefreshToken,
        message: 'Repository not initialized',
      );
    }
  }

  @override
  Future<StudentEntity?> getCurrentUser() async {
    await _delay;

    if (!_isInitialized) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.failedToGetCurrentUser,
        message: 'Repository not initialized',
      );
    }

    return _currentUser;
  }

  @override
  Future<Duration?> resendOtp(String phoneNumber) async {
    await _delay;

    if (!_isInitialized) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.unknown,
        message: 'Repository not initialized',
      );
    }

    if (_sentOtpPhoneNumber != phoneNumber) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.failedToResendOtp,
        message: 'Phone number does not match the original OTP request',
      );
    }

    // Generate a new OTP
    _validOtp = MockOtpGenerator.generate();

    _logger.info(
      'Mock OTP resent to $phoneNumber: $_validOtp',
    ); // For testing purposes

    return MockDataConfig.resendOtpDuration;
  }

  @override
  Future<StudentEntity?> getCachedUser() async {
    // Simulate instant cache access (no delay)
    return _currentUser;
  }

  @override
  Future<StudentEntity> getAccountStatus() async {
    await _delay;

    if (!_isInitialized) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.unknown,
        message: 'Repository not initialized',
      );
    }

    if (_currentUser == null) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.failedToGetCurrentUser,
        message: 'No user is currently signed in',
      );
    }

    return _currentUser!;
  }

  // Helper method for testing - allows setting a specific OTP
  void setMockOtp(String otp) {
    _validOtp = otp;
  }

  // Helper method for testing - get current valid OTP
  String? get currentValidOtp => _validOtp;

  StudentStatus _statusForPhone(String phoneNumber) {
    switch (phoneNumber) {
      case '01000000001':
        return StudentStatus.pending;
      case '01000000002':
        return StudentStatus.suspended;
      case '01000000003':
        return StudentStatus.inactive;
      default:
        return StudentStatus.active;
    }
  }
}
