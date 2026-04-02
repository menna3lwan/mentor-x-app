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

  final MentorXLogger _logger = MentorXLogger('MockAuthenticationRepository');

  MockAuthenticationRepository({this.delay = const Duration(seconds: 2)});

  Future<void> get _delay async => await Future.delayed(delay);

  @override
  Future<void> initialize() async {
    _isInitialized = true;
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
    _sentOtpPhoneNumber = phoneNumber;
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

    _logger.info('Mock password reset requested for $phoneNumber');
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

    _currentUser = MockStudentGenerator.generate(phoneNumber: phoneNumber);
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
    );

    // Clear OTP after successful verification
    _validOtp = null;

    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    await _delay;

    if (!_isInitialized) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.unknown,
        message: 'Repository not initialized',
      );
    }

    if (_currentUser == null) {
      throw AuthenticationRepositoryException(
        code: AuthenticationRepositoryExceptionCode.failedToSignOut,
        message: 'No user is currently signed in',
      );
    }

    _currentUser = null;
    _sentOtpPhoneNumber = null;
    _validOtp = null;
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
}
