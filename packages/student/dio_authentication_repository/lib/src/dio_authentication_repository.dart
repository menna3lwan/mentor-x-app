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
    final defaultException = _ExceptionCode.failedToGetCurrentUser;
    try {
      final isAuthenticated = await httpClient.isAuthenticated();
      if (!isAuthenticated) {
        return null;
      }

      final response = await _getCurrentUserResponse();

      if (response.statusCode == 401) {
        return null;
      }

      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }

      final user = _extractStudentFromResponse(response.data);
      if (user == null) {
        throw _Exception(
          code: defaultException,
          message: 'User payload was missing from response.',
        );
      }

      await _cacheUser(user);
      return user;
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode == 401) {
        return null;
      }
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to get current user', e, s);
      if (e is _Exception) {
        rethrow;
      }
      throw _Exception(
        code: defaultException,
        message: 'Failed to get current user',
      );
    }
  }

  @override
  Future<Duration?> resendOtp(String phoneNumber) async {
    final defaultException = _ExceptionCode.failedToResendOtp;
    try {
      if (_pendingOtpPhoneNumber == null ||
          _pendingOtpPhoneNumber != phoneNumber) {
        setOtpVerificationContext(
          phoneNumber: phoneNumber,
          purpose: OtpVerificationPurpose.login,
        );
      }

      final response = await _resendOtpResponse(phoneNumber);

      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }

      final data = _extractDataMap(response.data);
      final expiresIn = _intOrNull(
        data['otp_expires_in_seconds'] ?? data['expires_in_seconds'],
      );

      return expiresIn == null ? null : Duration(seconds: expiresIn);
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to resend OTP', e, s);
      if (e is _Exception) {
        rethrow;
      }
      throw _Exception(code: defaultException);
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
      if (!_isSuccessStatus(response.statusCode) &&
          response.statusCode != 204) {
        throw _Exception(code: defaultException);
      }
    }

    try {
      await tryRequest('/api/v1/auth/forgot-password');
      setOtpVerificationContext(
        phoneNumber: phoneNumber,
        purpose: OtpVerificationPurpose.passwordReset,
      );
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode == 404) {
        try {
          await tryRequest('/api/auth/forgot-password');
          setOtpVerificationContext(
            phoneNumber: phoneNumber,
            purpose: OtpVerificationPurpose.passwordReset,
          );
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
      if (e is _Exception) {
        rethrow;
      }
      throw _Exception(code: defaultException);
    }
  }

  @override
  Future<void> resetPassword({
    required String phoneNumber,
    required String otp,
    required String newPassword,
  }) async {
    final defaultException = _ExceptionCode.failedToResetPassword;

    Future<void> tryReset(String endpoint, Map<String, dynamic> payload) async {
      final response = await httpClient.post(endpoint, data: payload);
      if (!_isSuccessStatus(response.statusCode) &&
          response.statusCode != 204) {
        throw _Exception(code: defaultException);
      }
    }

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
      await tryReset('/api/v1/auth/reset-password', primaryPayload);
      await _clearLocalAuthSession();
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode == 400 || errorResponse.statusCode == 422) {
        try {
          await tryReset('/api/v1/auth/reset-password', secondaryPayload);
          await _clearLocalAuthSession();
          return;
        } on HttpClientResponse catch (_) {
          // Continue to legacy fallbacks.
        }
      }

      if (errorResponse.statusCode == 404) {
        try {
          await tryReset('/api/auth/reset-password', primaryPayload);
          await _clearLocalAuthSession();
          return;
        } on HttpClientResponse catch (_) {
          try {
            await tryReset('/api/auth/reset-password', secondaryPayload);
            await _clearLocalAuthSession();
            return;
          } on HttpClientResponse catch (fallbackErrorResponse) {
            handleHttpClientErrorResponse(
              defaultException,
              fallbackErrorResponse,
            );
          }
        }
      }

      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to reset password', e, s);
      if (e is _Exception) {
        rethrow;
      }
      throw _Exception(code: defaultException);
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
    final defaultException = _ExceptionCode.failedToGetCurrentUser;
    try {
      final payload = await _buildLoginPayload(
        phoneNumber: phoneNumber,
        password: password,
      );

      final response = await _loginResponse(payload);

      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }

      final data = _extractDataMap(response.data);

      if (_boolOrFalse(data['requires_otp'])) {
        setOtpVerificationContext(
          phoneNumber: phoneNumber,
          purpose: OtpVerificationPurpose.login,
        );

        final otpDurationSeconds = _intOrNull(data['otp_expires_in_seconds']);
        final otpLength = _intOrNull(data['otp_length']);

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
          code: defaultException,
          message: 'Login response did not include user details.',
        );
      }

      await _cacheUser(user);
      clearOtpVerificationContext();
      return user;
    } on HttpClientResponse catch (errorResponse) {
      if (_isDeviceLimitError(errorResponse)) {
        final error = _extractErrorMap(errorResponse.data);
        throw DeviceLimitReachedException(
          message:
              _stringOrNull(error['message']) ?? 'Maximum devices reached.',
          maxDevices: _intOrNull(error['max_devices']) ?? 1,
          activeDevices: _parseActiveDevices(error['active_devices']),
        );
      }
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to login with password', e, s);
      if (e is AuthenticationRequiresOtpException ||
          e is DeviceLimitReachedException) {
        rethrow;
      }
      if (e is _Exception) {
        rethrow;
      }
      throw _Exception(code: defaultException);
    }
  }

  @override
  Future<({Duration? otpDuration, int? otpLength})?> sendOtp(
    String phoneNumber,
  ) async {
    final defaultException = _ExceptionCode.failedToSendOtp;
    try {
      final response = await _sendOtpResponse(phoneNumber);

      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(code: defaultException);
      }

      setOtpVerificationContext(
        phoneNumber: phoneNumber,
        purpose: OtpVerificationPurpose.registration,
      );

      final data = _extractDataMap(response.data);
      final otpDuration = _intOrNull(data['otp_expires_in_seconds']);
      final otpLength = _intOrNull(data['otp_length']);

      return (
        otpDuration: otpDuration == null
            ? null
            : Duration(seconds: otpDuration),
        otpLength: otpLength,
      );
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to send OTP', e, s);
      if (e is _Exception) {
        rethrow;
      }
      throw _Exception(code: defaultException);
    }
  }

  @override
  Future<StudentEntity> verifyOtp(String otp) async {
    final phone = _pendingOtpPhoneNumber;
    if (phone == null) {
      throw _Exception(code: _ExceptionCode.invalidPhoneNumber);
    }

    final defaultException = _ExceptionCode.failedToVerifyOtp;
    try {
      final response = await _verifyOtpResponse(phone, otp);

      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }

      final data = _extractDataMap(response.data);
      _setTokensIfPresent(data);

      final studentFromPayload = _extractStudentFromResponse(response.data);
      if (studentFromPayload != null) {
        await _cacheUser(studentFromPayload);
        clearOtpVerificationContext();
        return studentFromPayload;
      }

      final accountStatus = _parseStatus(_stringOrNull(data['user_status']));
      final fallbackUser = StudentEntity(
        id: _stringOrNull(data['user_id']) ?? '',
        name: _stringOrNull(data['name']) ?? '',
        phoneNumber: phone,
        studentCode: _stringOrNull(data['student_code']),
        status: accountStatus ?? StudentStatus.pending,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _cacheUser(fallbackUser);
      clearOtpVerificationContext();
      return fallbackUser;
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to verify OTP', e, s);
      if (e is _Exception) {
        rethrow;
      }
      throw _Exception(code: defaultException, message: 'Failed to verify OTP');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      try {
        await httpClient.post('/api/auth/student/logout');
      } on HttpClientResponse catch (errorResponse) {
        if (errorResponse.statusCode == 404) {
          await httpClient.post('/api/v1/auth/logout');
        } else {
          rethrow;
        }
      }
    } catch (_) {
      // Local cleanup still happens even if backend sign out fails.
    } finally {
      await _deleteCachedUser();
      httpClient.removeBearerToken();
      clearOtpVerificationContext();
    }
  }

  @override
  Future<StudentEntity> getAccountStatus() async {
    final defaultException = _ExceptionCode.unknown;
    try {
      HttpClientResponse response;
      try {
        response = await httpClient.get('/api/v1/auth/account-status');
      } on HttpClientResponse catch (errorResponse) {
        if (errorResponse.statusCode != 404) {
          rethrow;
        }
        response = await httpClient.get('/api/auth/student/account-status');
      }

      if (!_isSuccessStatus(response.statusCode)) {
        throw _Exception(
          code: defaultException,
          message: response.exception?.message,
        );
      }

      final user = _extractStudentFromResponse(response.data);
      if (user == null) {
        throw _Exception(
          code: defaultException,
          message: 'Account status payload was missing user details.',
        );
      }

      await _cacheUser(user);
      return user;
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Failed to get account status', e, s);
      if (e is _Exception) {
        rethrow;
      }
      throw _Exception(code: defaultException);
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
    final accessToken = _stringOrNull(
      data['access_token'] ?? data['accessToken'],
    );
    if (accessToken == null) {
      return;
    }

    final refreshToken = _stringOrNull(
      data['refresh_token'] ?? data['refreshToken'],
    );
    httpClient.setBearerToken(accessToken, refreshToken: refreshToken);
  }

  StudentEntity? _extractStudentFromResponse(dynamic rawResponse) {
    final root = _asMap(rawResponse);
    final data = _extractDataMap(rawResponse);

    if (data['user'] is Map || data['id'] != null || data['name'] != null) {
      return StudentModel.fromJson(data);
    }

    if (root['user'] is Map) {
      return StudentModel.fromJson(_asMap(root['user']));
    }

    return null;
  }

  bool _isDeviceLimitError(HttpClientResponse response) {
    final error = _extractErrorMap(response.data);
    final code = _stringOrNull(error['code'])?.toUpperCase();
    return response.statusCode == 403 && code == 'DEVICE_LIMIT_REACHED';
  }

  List<DeviceEntity> _parseActiveDevices(dynamic rawDevices) {
    if (rawDevices is! List) {
      return const [];
    }

    return rawDevices
        .map((entry) => _asMap(entry))
        .where((entry) => entry.isNotEmpty)
        .map((entry) {
          final rawDate = _stringOrNull(entry['last_used_at']);
          final parsedDate = rawDate == null
              ? DateTime.now()
              : DateTime.tryParse(rawDate) ?? DateTime.now();

          return DeviceEntity(
            id: _stringOrNull(entry['id']) ?? '',
            deviceName: _stringOrNull(entry['device_name']) ?? 'Unknown Device',
            deviceModel:
                _stringOrNull(entry['device_model']) ??
                _stringOrNull(entry['device_name']) ??
                'Unknown',
            osVersion: _stringOrNull(entry['os_version']),
            appVersion: _stringOrNull(entry['app_version']),
            isActive: true,
            lastUsedAt: parsedDate,
          );
        })
        .toList();
  }

  StudentStatus? _parseStatus(String? status) {
    if (status == null || status.isEmpty) {
      return null;
    }

    final normalized = status.toLowerCase();
    for (final value in StudentStatus.values) {
      if (value.name == normalized) {
        return value;
      }
    }
    return null;
  }

  Map<String, dynamic> _extractErrorMap(dynamic responseData) {
    final map = _asMap(responseData);
    final error = map['error'];
    return _asMap(error);
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }

  static Map<String, dynamic> _extractDataMap(dynamic responseData) {
    final root = _asMap(responseData);
    final data = root['data'];
    if (data is Map) {
      return _asMap(data);
    }
    return root;
  }

  static bool _isSuccessStatus(int statusCode) {
    return statusCode == 200 || statusCode == 201;
  }

  static int? _intOrNull(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value.toString());
  }

  static String? _stringOrNull(dynamic value) {
    if (value == null) {
      return null;
    }
    final parsed = value.toString().trim();
    return parsed.isEmpty ? null : parsed;
  }

  static bool _boolOrFalse(dynamic value) {
    if (value is bool) {
      return value;
    }
    if (value is num) {
      return value != 0;
    }
    final normalized = value?.toString().trim().toLowerCase();
    return normalized == 'true' || normalized == '1' || normalized == 'yes';
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
    if (Platform.isAndroid) {
      return 'Android Device';
    }
    if (Platform.isIOS) {
      return 'iPhone';
    }
    return 'Mobile Device';
  }

  static String _buildDeviceModel() {
    if (Platform.isAndroid) {
      return 'Android';
    }
    if (Platform.isIOS) {
      return 'iOS';
    }
    return Platform.operatingSystem;
  }
}
