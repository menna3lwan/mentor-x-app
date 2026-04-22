import 'dart:convert';
import 'dart:io';

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

  String? _pendingOtpPhoneNumber;
  OtpVerificationPurpose _pendingOtpPurpose = OtpVerificationPurpose.login;

  static final MentorXLogger _logger = MentorXLogger(
    'DioAuthenticationRepository',
  );

  @override
  String? get pendingOtpPhoneNumber => _pendingOtpPhoneNumber;

  @override
  OtpVerificationPurpose get pendingOtpPurpose => _pendingOtpPurpose;

  @override
  void setOtpVerificationContext({
    required String phoneNumber,
    required OtpVerificationPurpose purpose,
  }) {
    _pendingOtpPhoneNumber = phoneNumber;
    _pendingOtpPurpose = purpose;
  }

  @override
  void clearOtpVerificationContext() {
    _pendingOtpPhoneNumber = null;
    _pendingOtpPurpose = OtpVerificationPurpose.login;
  }

  @override
  Future<StudentEntity?> getCachedUser() async {
    try {
      final cachedUser = await cacheRepository.get(CacheKeys.user);
      if (cachedUser == null) {
        return null;
      }

      final jsonData = json.decode(cachedUser);
      return StudentModel.fromJson(jsonData as Map<String, dynamic>);
    } catch (e, s) {
      _logger.error('Failed to get cached user', e, s);
      return null;
    }
  }

  Future<void> _cacheUser(StudentEntity user) async {
    try {
      final model = StudentModel.fromEntity(user);
      final jsonData = json.encode(model.toJson());
      await cacheRepository.put(CacheKeys.user, jsonData);
    } catch (e, s) {
      _logger.error('Failed to cache user', e, s);
    }
  }

  Future<void> _deleteCachedUser() async {
    try {
      await cacheRepository.remove(CacheKeys.user);
    } catch (e, s) {
      _logger.error('Failed to delete cached user', e, s);
    }
  }

  @override
  Future<StudentEntity?> getCurrentUser() async {
    try {
      final isAuthenticated = await httpClient.isAuthenticated();
      if (!isAuthenticated) return null;

      final response = await _getCurrentUserResponse();
      final user = _extractStudentFromResponse(response.data);
      if (user == null) {
        throw _Exception(
          code: _ExceptionCode.failedToGetCurrentUser,
          message: 'User payload was missing from response.',
        );
      }

      await _cacheUser(user);
      return user;
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 401) return null;
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToGetCurrentUser,
      );
    }
  }

  @override
  Future<Duration?> resendOtp(String phoneNumber) async {
    final result = AuthRateLimiter.canAttempt(phoneNumber, 'resend_otp');
    if (!result.canAttempt) {
      throw RateLimitExceededException(
        message: 'Too many OTP requests. Please wait.',
        remainingCooldown: result.remainingCooldown,
        identifier: phoneNumber,
        endpoint: 'resend_otp',
      );
    }

    try {
      if (_pendingOtpPhoneNumber == null ||
          _pendingOtpPhoneNumber != phoneNumber) {
        setOtpVerificationContext(
          phoneNumber: phoneNumber,
          purpose: OtpVerificationPurpose.login,
        );
      }

      final response = await _resendOtpResponse(phoneNumber);
      AuthRateLimiter.recordSuccessfulAttempt(phoneNumber, 'resend_otp');

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final expiresIn = intOrNull(
        data['otp_expires_in_seconds'] ?? data['expires_in_seconds'],
      );

      return expiresIn == null ? null : Duration(seconds: expiresIn);
    } on HttpClientResponse catch (e) {
      AuthRateLimiter.recordFailedAttempt(phoneNumber, 'resend_otp');
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToResendOtp,
      );
    }
  }

  @override
  Future<void> requestPasswordReset(String phoneNumber) async {
    try {
      await httpClient.post(
        '/api/v1/auth/forgot-password',
        data: {'phone': phoneNumber},
      );
      setOtpVerificationContext(
        phoneNumber: phoneNumber,
        purpose: OtpVerificationPurpose.passwordReset,
      );
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404) {
        try {
          await httpClient.post(
            '/api/auth/forgot-password',
            data: {'phone': phoneNumber},
          );
          setOtpVerificationContext(
            phoneNumber: phoneNumber,
            purpose: OtpVerificationPurpose.passwordReset,
          );
          return;
        } on HttpClientResponse catch (fallbackE) {
          handleHttpClientErrorResponse(
            fallbackE,
            defaultCode: _ExceptionCode.failedToRequestPasswordReset,
          );
        }
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToRequestPasswordReset,
      );
    }
  }

  @override
  Future<void> resetPassword({
    required String phoneNumber,
    required String otp,
    required String newPassword,
  }) async {
    final primaryPayload = {
      'phone': phoneNumber,
      'otp': otp,
      'new_password': newPassword,
    };
    final secondaryPayload = {
      'phone': phoneNumber,
      'otp_code': otp,
      'password': newPassword,
    };

    try {
      await httpClient.post('/api/v1/auth/reset-password', data: primaryPayload);
      await _clearLocalAuthSession();
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 400 || e.statusCode == 422) {
        try {
          await httpClient.post(
            '/api/v1/auth/reset-password',
            data: secondaryPayload,
          );
          await _clearLocalAuthSession();
          return;
        } catch (_) {}
      }

      if (e.statusCode == 404) {
        try {
          await httpClient.post(
            '/api/auth/reset-password',
            data: primaryPayload,
          );
          await _clearLocalAuthSession();
          return;
        } on HttpClientResponse catch (_) {
          try {
            await httpClient.post(
              '/api/auth/reset-password',
              data: secondaryPayload,
            );
            await _clearLocalAuthSession();
            return;
          } on HttpClientResponse catch (fallbackE) {
            handleHttpClientErrorResponse(
              fallbackE,
              defaultCode: _ExceptionCode.failedToResetPassword,
            );
          }
        }
      }

      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToResetPassword,
      );
    }
  }

  Future<void> _clearLocalAuthSession() async {
    await _deleteCachedUser();
    httpClient.removeBearerToken();
    clearOtpVerificationContext();
  }

  @override
  Future<StudentEntity> loginWithPassword({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final payload = await _buildLoginPayload(
        phoneNumber: phoneNumber,
        password: password,
      );

      final response = await _loginResponse(payload);
      final data = asMap(response.data)['data'] ?? asMap(response.data);

      if (boolOrFalse(data['requires_otp'])) {
        setOtpVerificationContext(
          phoneNumber: phoneNumber,
          purpose: OtpVerificationPurpose.login,
        );

        final otpDurationSeconds = intOrNull(data['otp_expires_in_seconds']);
        final otpLength = intOrNull(data['otp_length']);

        throw AuthenticationRequiresOtpException(
          message: 'OTP required for this login.',
          otpDuration: otpDurationSeconds == null
              ? null
              : Duration(seconds: otpDurationSeconds),
          otpLength: otpLength,
        );
      }

      _setTokensIfPresent(data);

      final user = _extractStudentFromResponse(response.data);
      if (user == null) {
        throw _Exception(
          code: _ExceptionCode.failedToGetCurrentUser,
          message: 'Login response did not include user details.',
        );
      }

      await _cacheUser(user);
      clearOtpVerificationContext();
      return user;
    } on HttpClientResponse catch (e) {
      if (_isDeviceLimitError(e)) {
        final error = _extractErrorMap(e.data);
        throw DeviceLimitReachedException(
          message: stringOrNull(error['message']) ?? 'Maximum devices reached.',
          maxDevices: intOrNull(error['max_devices']) ?? 1,
          activeDevices: _parseActiveDevices(error['active_devices']),
        );
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToGetCurrentUser,
      );
    }
  }

  @override
  Future<({Duration? otpDuration, int? otpLength})?> sendOtp(
    String phoneNumber,
  ) async {
    try {
      final response = await _sendOtpResponse(phoneNumber);

      setOtpVerificationContext(
        phoneNumber: phoneNumber,
        purpose: OtpVerificationPurpose.registration,
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      final otpDuration = intOrNull(data['otp_expires_in_seconds']);
      final otpLength = intOrNull(data['otp_length']);

      return (
        otpDuration: otpDuration == null ? null : Duration(seconds: otpDuration),
        otpLength: otpLength,
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToSendOtp,
      );
    }
  }

  @override
  Future<StudentEntity> verifyOtp(String otp) async {
    final phone = _pendingOtpPhoneNumber;
    if (phone == null) {
      throw _Exception(code: _ExceptionCode.invalidPhoneNumber);
    }

    try {
      final response = await _verifyOtpResponse(phone, otp);
      final data = asMap(response.data)['data'] ?? asMap(response.data);
      _setTokensIfPresent(data);

      final studentFromPayload = _extractStudentFromResponse(response.data);
      if (studentFromPayload != null) {
        await _cacheUser(studentFromPayload);
        clearOtpVerificationContext();
        return studentFromPayload;
      }

      final String rawName = stringOrNull(data['name']) ?? '';
      final nameParts = rawName.split(' ');
      final String fallbackFirstName = nameParts.isNotEmpty ? nameParts[0] : '';
      final String fallbackLastName =
          nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      final studentStatus = _parseStatus(
        stringOrNull(data['status'] ?? data['account_status']),
      );

      final fallbackUser = StudentEntity(
        id: stringOrNull(data['user_id']) ?? '',
        firstName: stringOrNull(data['first_name']) ?? fallbackFirstName,
        lastName: stringOrNull(data['last_name']) ?? fallbackLastName,
        phoneNumber: phone,
        studentCode: stringOrNull(data['student_code']),
        status: studentStatus ?? StudentStatus.pending,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _cacheUser(fallbackUser);
      clearOtpVerificationContext();
      return fallbackUser;
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToVerifyOtp,
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      try {
        await httpClient.post('/api/auth/student/logout');
      } on HttpClientResponse catch (e) {
        if (e.statusCode == 404) {
          await httpClient.post('/api/v1/auth/logout');
        } else {
          rethrow;
        }
      }
    } catch (_) {
      // Local cleanup still happens even if backend sign out fails.
    } finally {
      await _clearLocalAuthSession();
    }
  }

  @override
  Future<StudentEntity> getAccountStatus() async {
    try {
      HttpClientResponse response;
      try {
        response = await httpClient.get('/api/v1/auth/account-status');
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404) rethrow;
        response = await httpClient.get('/api/auth/student/account-status');
      }

      final user = _extractStudentFromResponse(response.data);
      if (user == null) {
        throw _Exception(
          code: _ExceptionCode.unknown,
          message: 'Account status payload was missing user details.',
        );
      }

      await _cacheUser(user);
      return user;
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.unknown,
      );
    }
  }

  Future<HttpClientResponse> _getCurrentUserResponse() async {
    try {
      return await httpClient.get('/api/auth/student/me');
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode != 404) {
        rethrow;
      }
      return httpClient.get('/api/v1/auth/me');
    }
  }

  Future<HttpClientResponse> _sendOtpResponse(String phoneNumber) async {
    try {
      return await httpClient.post(
        '/api/student/register/start',
        data: {'phone': phoneNumber},
      );
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode != 404) {
        rethrow;
      }
      return httpClient.post(
        '/api/v1/auth/resend-otp',
        data: {
          'phone': phoneNumber,
          'purpose': OtpVerificationPurpose.registration.name,
        },
      );
    }
  }

  Future<HttpClientResponse> _resendOtpResponse(String phoneNumber) async {
    try {
      return await httpClient.post(
        '/api/v1/auth/resend-otp',
        data: {'phone': phoneNumber, 'purpose': _pendingOtpPurpose.name},
      );
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode != 404) {
        rethrow;
      }
      return httpClient.post(
        '/api/student/register/resend-otp',
        data: {'phone': phoneNumber},
      );
    }
  }

  Future<HttpClientResponse> _loginResponse(
    Map<String, dynamic> payload,
  ) async {
    try {
      return await httpClient.post('/api/v1/auth/login', data: payload);
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode != 404) {
        rethrow;
      }
      return httpClient.post('/api/auth/login', data: payload);
    }
  }

  Future<HttpClientResponse> _verifyOtpResponse(
    String phone,
    String otp,
  ) async {
    if (_pendingOtpPurpose == OtpVerificationPurpose.registration) {
      try {
        return await httpClient.post(
          '/api/student/register/complete',
          data: {'phone': phone, 'otp': otp},
        );
      } on HttpClientResponse catch (errorResponse) {
        if (errorResponse.statusCode != 404) {
          rethrow;
        }
      }
    }

    try {
      return await httpClient.post(
        '/api/v1/auth/verify-otp',
        data: {
          'phone': phone,
          'otp_code': otp,
          'purpose': _pendingOtpPurpose.name,
        },
      );
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode != 404) {
        rethrow;
      }
      return httpClient.post(
        '/api/auth/verify-otp',
        data: {
          'phone': phone,
          'otp_code': otp,
          'purpose': _pendingOtpPurpose.name,
        },
      );
    }
  }

  Future<Map<String, dynamic>> _buildLoginPayload({
    required String phoneNumber,
    required String password,
  }) async {
    final payload = <String, dynamic>{
      'phone': phoneNumber,
      'password': password,
      'device_hash': _buildDeviceHash(),
      'device_name': _buildDeviceName(),
      'device_model': _buildDeviceModel(),
      'os_version': Platform.operatingSystemVersion,
      'app_version': '1.0.0',
    };

    final tenantId = await cacheRepository.get(CacheKeys.tenantId);
    final parsedTenantId = int.tryParse(tenantId ?? '');
    if (parsedTenantId != null) {
      payload['tenant_id'] = parsedTenantId;
    }

    return payload;
  }

  void _setTokensIfPresent(Map<String, dynamic> data) {
    final accessToken = stringOrNull(data['access_token'] ?? data['accessToken']);
    if (accessToken == null) return;

    final refreshToken = stringOrNull(data['refresh_token'] ?? data['refreshToken']);
    httpClient.setBearerToken(accessToken, refreshToken: refreshToken);
  }

  StudentEntity? _extractStudentFromResponse(dynamic rawResponse) {
    final root = asMap(rawResponse);
    final data = asMap(root['data'] ?? root);

    if (data['user'] is Map || data['id'] != null || data['name'] != null) {
      return StudentModel.fromJson(data);
    }

    if (root['user'] is Map) {
      return StudentModel.fromJson(asMap(root['user']));
    }

    return null;
  }

  bool _isDeviceLimitError(HttpClientResponse response) {
    final error = _extractErrorMap(response.data);
    final code = stringOrNull(error['code'])?.toUpperCase();
    return response.statusCode == 403 && code == 'DEVICE_LIMIT_REACHED';
  }

  List<DeviceEntity> _parseActiveDevices(dynamic rawDevices) {
    if (rawDevices is! List) return const [];

    return rawDevices
        .map((entry) => asMap(entry))
        .where((entry) => entry.isNotEmpty)
        .map((entry) {
          final rawDate = stringOrNull(entry['last_used_at']);
          final parsedDate = rawDate == null
              ? DateTime.now()
              : DateTime.tryParse(rawDate) ?? DateTime.now();

          return DeviceEntity(
            id: stringOrNull(entry['id']) ?? '',
            deviceName: stringOrNull(entry['device_name']) ?? 'Unknown Device',
            deviceModel: stringOrNull(entry['device_model']) ??
                stringOrNull(entry['device_name']) ??
                'Unknown',
            osVersion: stringOrNull(entry['os_version']),
            appVersion: stringOrNull(entry['app_version']),
            isActive: true,
            lastUsedAt: parsedDate,
          );
        })
        .toList();
  }

  StudentStatus? _parseStatus(String? status) {
    if (status == null || status.isEmpty) return null;

    final normalized = status.toLowerCase();
    for (final value in StudentStatus.values) {
      if (value.name == normalized) return value;
    }
    return null;
  }

  Map<String, dynamic> _extractErrorMap(dynamic responseData) {
    final map = asMap(responseData);
    final error = map['error'];
    return asMap(error);
  }



  static String _buildDeviceHash() {
    final raw = [
      Platform.operatingSystem,
      Platform.operatingSystemVersion,
      Platform.localHostname,
      Platform.localeName,
    ].join('|');

    return base64UrlEncode(utf8.encode(raw)).replaceAll('=', '');
  }

  static String _buildDeviceName() {
    if (Platform.isAndroid) return 'Android Device';
    if (Platform.isIOS) return 'iPhone';
    return 'Mobile Device';
  }

  static String _buildDeviceModel() {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    return Platform.operatingSystem;
  }
}

