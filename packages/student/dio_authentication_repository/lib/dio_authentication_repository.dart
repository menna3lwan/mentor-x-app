import 'dart:convert';
import 'dart:io';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:device_info_service/device_info_service.dart';

import 'models/student_model.dart';

export 'models/student_model.dart';

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
  final DeviceInfoService deviceInfoService;

  DioAuthenticationRepository({
    required this.httpClient,
    required this.cacheRepository,
    DeviceInfoService? deviceInfoService,
  }) : deviceInfoService = deviceInfoService ?? DeviceInfoServiceImpl();

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
      final isAuthenticated = httpClient.isAuthenticated;
      if (!isAuthenticated) return null;

      final response = await _getCurrentUserResponse();
      final user = _extractStudentFromResponse(response.data);
      if (user == null) {
        throw AuthenticationRepositoryException(
          code: AuthenticationRepositoryExceptionCode.failedToGetCurrentUser,
          message: 'User payload was missing from /api/auth/me response.',
        );
      }

      await _cacheUser(user);
      return user;
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 401) return null;
      return handleHttpClientErrorResponse(
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
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToResendOtp,
      );
    }
  }

  @override
  Future<void> requestPasswordReset(String phoneNumber) async {
    try {
      await httpClient.clearTokens();
      await httpClient.post(
        '/api/auth/forgot-password',
        data: {'phone': phoneNumber},
      );
      setOtpVerificationContext(
        phoneNumber: phoneNumber,
        purpose: OtpVerificationPurpose.passwordReset,
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToRequestPasswordReset,
      );
    }
  }

  @override
  Future<void> resetPassword({
    required String phoneNumber,
    required String newPassword,
  }) async {
    final payload = {
      'phone': phoneNumber,
      'newPassword': newPassword, // Matches Postman CamelCase
    };

    try {
      await httpClient.post('/api/auth/reset-password', data: payload);
      await _clearLocalAuthSession();
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToResetPassword,
      );
    }
  }

  Future<void> _clearLocalAuthSession() async {
    await _deleteCachedUser();
    await httpClient.clearTokens();
    clearOtpVerificationContext();
  }


  @override
  Future<StudentEntity> loginWithPassword({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      // Proactively clear existing tokens to avoid sending stale/invalid
      // tokens in the Authorization header to the login endpoint.
      await httpClient.clearTokens();

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

      await _setTokensIfPresent(data);

      var user = _extractStudentFromResponse(response.data);
      user ??= await getCurrentUser();

      if (user == null) {
        throw _Exception(
          code: _ExceptionCode.failedToGetCurrentUser,
          message: 'Login succeeded but could not retrieve user details.',
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
      if (_isSessionAlreadyActiveError(e)) {
        final data = asMap(e.data);
        throw AuthenticationRepositoryException(
          code: AuthenticationRepositoryExceptionCode.sessionAlreadyActive,
          message: stringOrNull(data['error']) ?? 'Session already active on another device.',
        );
      }
      if (_isAccountPendingError(e)) {
        final data = asMap(e.data);
        throw AccountPendingException(
          message: stringOrNull(data['error'] ?? data['message']),
          supportWhatsApp: stringOrNull(data['supportWhatsApp']),
        );
      }
      if (_isAccountRejectedError(e)) {
        final data = asMap(e.data);
        throw AccountRejectedException(
          message: stringOrNull(data['error'] ?? data['message']),
          rejectionReason: stringOrNull(data['rejectionReason']),
          supportWhatsApp: stringOrNull(data['supportWhatsApp']),
        );
      }
      if (_isInvalidCredentialsError(e)) {
        return handleHttpClientErrorResponse(
          e,
          defaultCode: AuthenticationRepositoryExceptionCode.invalidCredentials,
        );
      }
      return handleHttpClientErrorResponse(
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
      // Clear existing tokens before starting a new registration/OTP flow.
      await httpClient.clearTokens();

      final response = await _sendOtpResponse(phoneNumber);

      setOtpVerificationContext(
        phoneNumber: phoneNumber,
        purpose: OtpVerificationPurpose.registration,
      );

      final data = response.asMap();
      final otpDuration = intOrNull(data['otp_expires_in_seconds']);
      final otpLength = intOrNull(data['otp_length']);

      return (
        otpDuration: otpDuration == null ? null : Duration(seconds: otpDuration),
        otpLength: otpLength,
      );
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
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

    final otpInt = int.tryParse(otp);
    if (otpInt == null) {
      throw _Exception(code: _ExceptionCode.invalidOtp);
    }

    try {
      final response = await _verifyOtpResponse(phone, otpInt);
      final data = response.asMap();
      await _setTokensIfPresent(data);

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
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToVerifyOtp,
      );
    }
  }

  @override
  Future<void> refreshToken() async {
    try {
      final currentRefreshToken = httpClient.refreshToken;
      if (currentRefreshToken == null || currentRefreshToken.isEmpty) {
        throw AuthenticationRepositoryException(
          code: AuthenticationRepositoryExceptionCode.failedToRefreshToken,
          message: 'No refresh token available.',
        );
      }

      // According to Swagger, it takes Authorization header.
      // Usually this means the refresh token is passed in the header.
      final response = await httpClient.post(
        '/api/auth/refresh',
        headers: {'Authorization': 'Bearer $currentRefreshToken'},
      );

      final data = asMap(response.data)['data'] ?? asMap(response.data);
      await _setTokensIfPresent(data);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToRefreshToken,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      try {
        await httpClient.post('/api/auth/student/logout');
      } on HttpClientResponse catch (e) {
        if (e.statusCode == 404) {
          await httpClient.post('/api/auth/logout');
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
      final response = await httpClient.get('/api/auth/session-status');

      var user = _extractStudentFromResponse(response.data);
      if (user == null) {
        // Fallback: If session status says we have a session, create a skeleton user
        final data = asMap(response.data);
        if (boolOrFalse(data['hasSession'])) {
          user = StudentEntity(
            id: stringOrNull(data['studentCode']) ?? '',
            firstName: 'Student',
            lastName: stringOrNull(data['studentCode']) ?? '',
            phoneNumber: '',
            status: _parseStatus(stringOrNull(data['status'])) ?? StudentStatus.active,
            studentCode: stringOrNull(data['studentCode']),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
        } else {
          throw _Exception(
            code: _ExceptionCode.unknown,
            message: 'Account status payload was missing user details.',
          );
        }
      }

      await _cacheUser(user);
      return user;
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 401) {
        return handleHttpClientErrorResponse(
          e,
          defaultCode: AuthenticationRepositoryExceptionCode.invalidCredentials,
        );
      }
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.unknown,
      );
    }
  }

  Future<HttpClientResponse> _getCurrentUserResponse() async {
    try {
      return await httpClient.get('/api/auth/me');
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode != 404) {
        rethrow;
      }
      return httpClient.get('/api/auth/student/me');
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
        '/api/auth/resend-otp',
        data: {
          'phone': phoneNumber,
        },
      );
    }
  }

  Future<HttpClientResponse> _resendOtpResponse(String phoneNumber) async {
    try {
      return await httpClient.post(
        '/api/auth/resend-otp',
        data: {'phone': phoneNumber},
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
    return httpClient.post('/api/auth/student/login', data: payload);
  }

  Future<HttpClientResponse> _verifyOtpResponse(
    String phone,
    int otp,
  ) async {
    return httpClient.post(
      '/api/auth/verify-otp',
      data: {
        'phone': phone,
        'otp': otp,
      },
    );
  }

  Future<Map<String, dynamic>> _buildLoginPayload({
    required String phoneNumber,
    required String password,
  }) async {
    final payload = <String, dynamic>{
      'phone': phoneNumber,
      'password': password,
      'device_hash': await deviceInfoService.getDeviceHash(),
      'device_name': await deviceInfoService.getDeviceName(),
      'device_model': _buildDeviceModel(),
      'os_version': Platform.operatingSystemVersion,
      'app_version': await deviceInfoService.getAppVersion(),
    };

    final tenantId = await cacheRepository.get(CacheKeys.tenantId);
    final parsedTenantId = int.tryParse(tenantId ?? '');
    if (parsedTenantId != null) {
      payload['tenant_id'] = parsedTenantId;
    }

    return payload;
  }

  Future<void> _setTokensIfPresent(Map<String, dynamic> data) async {
    final accessToken = stringOrNull(
      data['token'] ?? data['access_token'] ?? data['accessToken'],
    );
    
    if (accessToken == null) {
      _logger.warning('No access token found in response data keys: ${data.keys.toList()}');
      return;
    }

    _logger.info('Token found in response, updating HttpClient and Cache');
    final refreshToken = stringOrNull(
      data['refresh_token'] ?? data['refreshToken'],
    );
    await httpClient.setAccessToken(accessToken);
    if (refreshToken != null) {
      await httpClient.setRefreshToken(refreshToken);
    }
  }

  StudentEntity? _extractStudentFromResponse(dynamic rawResponse) {
    final data = ModelParser.extractData(rawResponse);

    if (data['user'] is Map ||
        data['id'] != null ||
        data['name'] != null ||
        data['userId'] != null ||
        data['fullName'] != null) {
      return StudentModel.fromJson(data);
    }

    if (data['user'] is Map) {
      return StudentModel.fromJson(asMap(data['user']));
    }

    return null;
  }

  bool _isDeviceLimitError(HttpClientResponse response) {
    final error = _extractErrorMap(response.data);
    final code = stringOrNull(error['code'])?.toUpperCase();
    return response.statusCode == 403 && code == 'DEVICE_LIMIT_REACHED';
  }

  bool _isSessionAlreadyActiveError(HttpClientResponse response) {
    final data = asMap(response.data);
    final error = stringOrNull(data['error']) ?? '';
    return response.statusCode == 400 &&
        (error.contains('تسجيل الخروج أولاً') || error.contains('logout first'));
  }

  bool _isInvalidCredentialsError(HttpClientResponse response) {
    final data = asMap(response.data);
    final error = stringOrNull(data['error'] ?? data['message']) ?? '';
    return response.statusCode == 401 ||
        error.contains('كلمة المرور غير صحيحة') ||
        error.contains('رقم الهاتف غير موجود') ||
        error.contains('رقم الهاتف أو كلمة المرور غير صحيحة');
  }

  bool _isAccountPendingError(HttpClientResponse response) {
    final data = asMap(response.data);
    final status = stringOrNull(data['status'])?.toUpperCase();
    return status == 'PENDING';
  }

  bool _isAccountRejectedError(HttpClientResponse response) {
    final data = asMap(response.data);
    final status = stringOrNull(data['status'])?.toUpperCase();
    return status == 'REJECTED';
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

  static String _buildDeviceModel() {
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    return Platform.operatingSystem;
  }

  @override
  Future<void> forceLogoutAll() async {
    try {
      await httpClient.post('/api/auth/force-logout-all');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToLogout,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getPendingStatus() async {
    try {
      final response = await httpClient.get('/api/auth/pending-status');
      return asMap(response.data);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.unknown,
      );
    }
  }

  @override
  Future<String> getEntryPoint() async {
    try {
      final response = await httpClient.get('/api/auth/entry-point');
      final data = asMap(response.data);
      return stringOrEmpty(data['entry_point'] ?? data['entryPoint']);
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.unknown,
      );
    }
  }

  @override
  Future<bool> checkPhone(String phone) async {
    try {
      final response = await httpClient.get('/api/auth/check-phone/$phone');
      final data = asMap(response.data);
      return boolOrNull(data['available'] ?? data['exists']) ?? true;
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.unknown,
      );
    }
  }

  @override
  Future<void> testMultiDevice() async {
    try {
      await httpClient.post('/api/auth/student/test-multi-device');
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.unknown,
      );
    }
  }
}

