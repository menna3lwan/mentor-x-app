import 'dart:convert';

import 'package:mentorx_core/mentorx_core.dart';

// Models
part 'models/student_model.dart';

typedef _Exception = AuthenticationRepositoryException;
typedef _ExceptionCode = AuthenticationRepositoryExceptionCode;

final class DioAuthenticationRepository
    extends HttpClientRepository<_ExceptionCode>
    implements AuthenticationRepository {
  final HttpClient httpClient;
  final CacheRepository cacheRepository;

  DioAuthenticationRepository({
    required this.httpClient,
    required this.cacheRepository,
  });

  String? phoneNumberToBeVerified;

  static final MentorXLogger _logger = MentorXLogger(
    'DioAuthenticationRepository',
  );

  @override
  Future<void> initialize() async {}

  @override
  Future<StudentEntity?> getCachedUser() async {
    try {
      final cachedUser = await cacheRepository.get(CacheKeys.user);
      if (cachedUser != null) {
        final jsonData = json.decode(cachedUser);
        return StudentModel.fromJson(jsonData);
      }
    } catch (e, s) {
      _logger.error('Failed to get cached user:', e, s);
    }
    return null;
  }

  Future<void> _cacheUser(StudentEntity user) async {
    try {
      final userModel = StudentModel.fromEntity(user);
      final jsonData = json.encode(userModel.toJson());
      await cacheRepository.put(CacheKeys.user, jsonData);
    } catch (e, s) {
      _logger.error('Failed to cache user:', e, s);
    }
  }

  Future<void> _deleteCachedUser() async {
    try {
      await cacheRepository.remove(CacheKeys.user);
    } catch (e, s) {
      _logger.error('Failed to delete cached user:', e, s);
    }
  }

  @override
  Future<StudentEntity?> getCurrentUser() async {
    final defaultException = _ExceptionCode.failedToGetCurrentUser;
    try {
      // Making sure that the client has the required authentication token
      final bool isAuthenticated = await httpClient.isAuthenticated();
      if (!isAuthenticated) return null;
      final response = await httpClient.get('/users/me');
      if (response.isOk) {
        final user = StudentModel.fromJson(response.data['data']['user']);
        try {
          await _cacheUser(user);
        } catch (e, s) {
          _logger.error('Failed to cache user', e, s);
        }
        return user;
      }
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to get current user', e, s);
      if (e is _Exception) {
        rethrow;
      } else {
        throw _Exception(
          code: defaultException,
          message: 'Failed to get current user',
        );
      }
    }
    return null;
  }

  @override
  Future<Duration?> resendOtp(String phoneNumber) async {
    final defaultException = _ExceptionCode.failedToResendOtp;
    try {
      final result = await sendOtp(phoneNumber);
      return result?.otpDuration;
    } catch (e, s) {
      _logger.error('Failed to resend OTP', e, s);
      if (e is _Exception) {
        if (e.code == _ExceptionCode.failedToSendOtp) {
          throw _Exception(code: defaultException, message: e.message);
        } else {
          rethrow;
        }
      } else {
        throw _Exception(code: defaultException);
      }
    }
  }

  @override
  Future<({Duration? otpDuration, int? otpLength})?> sendOtp(
    String phoneNumber,
  ) async {
    final defaultException = _ExceptionCode.failedToSendOtp;
    try {
      final response = await httpClient.post(
        '/auth/users/login',
        data: {'phoneNumber': phoneNumber},
      );

      if (response.isOk) {
        phoneNumberToBeVerified = phoneNumber;
        final data = response.data;

        // Parse OTP duration if provided
        Duration? otpDuration;
        if (data['expiresIn'] != null) {
          final durationInSeconds = data['expiresIn'] as int;
          otpDuration = Duration(seconds: durationInSeconds);
        }

        // Parse OTP length if provided
        final int? otpLength = data['otpLength'] as int?;

        return (otpDuration: otpDuration, otpLength: otpLength);
      } else {
        throw _Exception(code: defaultException);
      }
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to send OTP', e, s);
      if (e is _Exception) {
        rethrow;
      } else {
        throw _Exception(code: defaultException);
      }
    }
  }

  @override
  Future<StudentEntity> verifyOtp(String otp) async {
    if (phoneNumberToBeVerified == null) {
      throw _Exception(code: _ExceptionCode.invalidPhoneNumber);
    }
    final defaultException = _ExceptionCode.failedToVerifyOtp;
    try {
      final response = await httpClient.post(
        '/auth/users/verify',
        data: {'code': otp, 'phoneNumber': phoneNumberToBeVerified},
      );

      if (response.isOk) {
        final data = response.data;
        final String accessToken = data['accessToken'] as String;
        httpClient.setBearerToken(accessToken);
        final user = await getCurrentUser();
        if (user != null) {
          return user;
        } else {
          _logger.error('Failed to get current user after verification');
          throw _Exception(code: defaultException);
        }
      } else {
        throw _Exception(
          code: defaultException,
          message: 'Failed to verify OTP',
        );
      }
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to verify OTP', e, s);
      if (e is _Exception) {
        rethrow;
      } else {
        throw _Exception(
          code: defaultException,
          message: 'Failed to verify OTP',
        );
      }
    }
  }

  @override
  Future<void> signOut() async {
    final defaultException = _ExceptionCode.failedToSignOut;
    try {
      await _deleteCachedUser();
    } catch (e, s) {
      _logger.error('Failed to delete cached user', e, s);
      if (e is _Exception) {
        rethrow;
      } else {
        throw _Exception(code: defaultException);
      }
    }
  }
}
