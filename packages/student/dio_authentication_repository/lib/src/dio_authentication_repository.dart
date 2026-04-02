import 'dart:convert';

import 'package:mentorx_core/mentorx_core.dart';

import 'models/student_model.dart';

typedef _Exception = AuthenticationRepositoryException;
typedef _ExceptionCode = AuthenticationRepositoryExceptionCode;

final class DioAuthenticationRepository
    extends HttpClientRepository<AuthenticationRepositoryExceptionCode>
    implements StudentAuthenticationRepository {
  @override
  Never throwException(
    AuthenticationRepositoryExceptionCode code, {
    String? message,
  }) => throw _Exception(code: code, message: message);

  @override
  Future<void> initialize() async {}

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
      final model = StudentModel.fromEntity(user);
      final jsonData = json.encode(model.toJson());
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
      final bool isAuthenticated = await httpClient.isAuthenticated();
      if (!isAuthenticated) return null;

      final response = await httpClient.get('/api/auth/student/me');
      if (response.statusCode == 200) {
        final user = StudentModel.fromJson(response.data['data']);
        await _cacheUser(user);
        return user;
      }
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode == 401) return null;
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
      final response = await httpClient.post(
        '/api/student/register/resend-otp',
        data: {'phone': phoneNumber},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
        final expiresIn = data['otp_expires_in_seconds'] as int?;
        return expiresIn != null ? Duration(seconds: expiresIn) : null;
      }
      throw _Exception(code: defaultException);
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to resend OTP', e, s);
      if (e is _Exception) {
        rethrow;
      } else {
        throw _Exception(code: defaultException);
      }
    }
  }

  @override
  Future<void> requestPasswordReset(String phoneNumber) async {
    final defaultException = _ExceptionCode.failedToRequestPasswordReset;

    Future<void> tryRequest(String endpoint) async {
      final response = await httpClient.post(
        endpoint,
        data: {'phone': phoneNumber},
      );
      if (response.statusCode != 200 &&
          response.statusCode != 201 &&
          response.statusCode != 204) {
        throw _Exception(code: defaultException);
      }
    }

    try {
      await tryRequest('/api/v1/auth/forgot-password');
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode == 404) {
        try {
          await tryRequest('/api/auth/forgot-password');
          return;
        } on HttpClientResponse catch (fallbackErrorResponse) {
          handleHttpClientErrorResponse(
            defaultException,
            fallbackErrorResponse,
          );
        }
      }
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to request password reset', e, s);
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException);
    }
  }

  @override
  Future<StudentEntity> loginWithPassword({
    required String phoneNumber,
    required String password,
  }) async {
    final defaultException = _ExceptionCode.failedToGetCurrentUser;
    try {
      final response = await httpClient.post(
        '/api/v1/auth/login',
        data: {
          'phone': phoneNumber,
          'password': password,
          // Missing but required by API in full implementation
          'device_hash': 'mock_hash',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];

        final String? accessToken = data['access_token'] as String?;
        if (accessToken != null) {
          httpClient.setBearerToken(accessToken);
        }

        final user = StudentModel.fromJson(data['user'] ?? data);
        await _cacheUser(user);
        return user;
      }
      throw _Exception(code: defaultException);
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to login with password', e, s);
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException);
    }
  }

  @override
  Future<({Duration? otpDuration, int? otpLength})?> sendOtp(
    String phoneNumber,
  ) async {
    final defaultException = _ExceptionCode.failedToSendOtp;
    try {
      final response = await httpClient.post(
        '/api/student/register/start',
        data: {'phone': phoneNumber},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        phoneNumberToBeVerified = phoneNumber;
        final data = response.data['data'];

        Duration? otpDuration;
        if (data['otp_expires_in_seconds'] != null) {
          otpDuration = Duration(
            seconds: data['otp_expires_in_seconds'] as int,
          );
        }

        final int? otpLength = data['otp_length'] as int?;

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
        '/api/student/register/complete',
        data: {'otp': otp, 'phone': phoneNumberToBeVerified},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
        final String? accessToken =
            data['accessToken'] as String? ??
            response.data['accessToken'] as String?;

        if (accessToken != null) {
          httpClient.setBearerToken(accessToken);
        }

        final user = StudentModel.fromJson(data);
        await _cacheUser(user);
        return user;
      } else {
        throw _Exception(code: defaultException);
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
    try {
      await httpClient.post('/api/auth/student/logout');
      await _deleteCachedUser();
      httpClient.removeBearerToken();
    } on HttpClientResponse catch (_) {
      // Still logout locally if API fails
      await _deleteCachedUser();
      httpClient.removeBearerToken();
    } catch (e, s) {
      _logger.error('Failed to sign out', e, s);
      await _deleteCachedUser();
      httpClient.removeBearerToken();
    }
  }

  @override
  Future<StudentEntity> getAccountStatus() async {
    final defaultException = _ExceptionCode.unknown;
    try {
      final response = await httpClient.get('/api/auth/student/account-status');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = StudentModel.fromJson(response.data['data']);
        await _cacheUser(user);
        return user;
      }
      throw _Exception(code: defaultException);
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to get account status', e, s);
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException);
    }
  }
}
