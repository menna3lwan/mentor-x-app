import 'dart:convert';

import 'package:mentorx_core/mentorx_core.dart' hide ParentModel;
import 'models/parent_model.dart';

typedef _Exception = AuthenticationException;
typedef _ExceptionCode = AuthenticationExceptionCode;

final class DioAuthenticationRepository
    extends HttpClientRepository<AuthenticationExceptionCode>
    implements AuthenticationRepository<ParentEntity> {
  static const String _hasLinkedChildrenCacheKey = 'parent_has_linked_children';

  @override
  Never throwException(
    AuthenticationExceptionCode code, {
    String? message,
  }) => throw _Exception(code: code, message: message);

  final HttpClient httpClient;
  final CacheRepository cacheRepository;

  static final MentorXLogger _logger = MentorXLogger(
    'DioAuthenticationRepository',
  );

  DioAuthenticationRepository({
    required this.httpClient,
    required this.cacheRepository,
  });

  @override
  Future<void> initialize() async {
    final cachedAccessToken = await cacheRepository.get(CacheKeys.accessToken);
    final cachedRefreshToken = await cacheRepository.get(
      CacheKeys.refreshToken,
    );

    if (cachedAccessToken != null && cachedAccessToken.isNotEmpty) {
      httpClient.setBearerToken(
        cachedAccessToken,
        refreshToken: cachedRefreshToken,
      );
    }
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
    const defaultException = _ExceptionCode.invalidCredentials;

    Future<HttpClientResponse> tryLogin(String endpoint) {
      return httpClient.post(
        endpoint,
        data: {
          'phone': phone,
          'password': password,
          if (deviceHash != null) 'device_hash': deviceHash,
          if (deviceName != null) 'device_name': deviceName,
          if (fcmToken != null) 'fcm_token': fcmToken,
          if (appVersion != null) 'app_version': appVersion,
        },
      );
    }

    try {
      late final HttpClientResponse response;

      try {
        response = await tryLogin('/api/v1/auth/login');
      } on HttpClientResponse catch (errorResponse) {
        if (errorResponse.statusCode != 404) {
          rethrow;
        }
        response = await tryLogin('/api/auth/parent/login');
      }

      if (_isSuccessfulStatus(response.statusCode)) {
        final data = _extractDataMap(response.data);
        final String? accessToken = _extractAccessToken(data);
        final String? refreshToken = _extractRefreshToken(data);

        if (accessToken != null) {
          httpClient.setBearerToken(accessToken, refreshToken: refreshToken);
        }

        final hasLinkedChildren = _extractHasLinkedChildren(data);
        await cacheRepository.put(
          _hasLinkedChildrenCacheKey,
          hasLinkedChildren.toString(),
        );

        final user = ParentModel.fromJson(data);
        await _cacheUser(user);
        return user;
      }

      throw _Exception(code: defaultException);
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Login failed', e, s);
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<ParentStudentLookupEntity> findStudentForParentRegistration({
    required ParentLookupType lookupType,
    required String value,
  }) async {
    const defaultException = _ExceptionCode.studentNotFound;

    Future<HttpClientResponse> tryFind(String endpoint) {
      return httpClient.post(
        endpoint,
        data: {
          'lookup_type': lookupType == ParentLookupType.phone
              ? 'phone'
              : 'student_code',
          'value': value.trim(),
        },
      );
    }

    try {
      late final HttpClientResponse response;

      try {
        response = await tryFind('/api/v1/parent/find-student');
      } on HttpClientResponse catch (errorResponse) {
        if (errorResponse.statusCode != 404) {
          rethrow;
        }
        response = await tryFind('/api/parent/find-student');
      }

      if (!_isSuccessfulStatus(response.statusCode)) {
        throw _Exception(code: defaultException);
      }

      final data = _extractDataMap(response.data);
      final studentId = _stringOrNull(data['student_id'] ?? data['id']);
      if (studentId == null) {
        throw _Exception(
          code: defaultException,
          message: 'No student was found for the provided lookup value.',
        );
      }

      return ParentStudentLookupEntity(
        studentId: studentId,
        maskedName: (
            _stringOrNull(data['first_name_masked'] ?? data['firstNameMasked']) ?? '**'
        ) + ' ' + (
            _stringOrNull(data['last_name_masked'] ?? data['lastNameMasked']) ?? '**'
        ),
        gradeName:
            _stringOrNull(data['grade_name'] ?? data['gradeName']) ??
            'Unknown Grade',
        centerName:
            _stringOrNull(data['tenant_name'] ?? data['tenantName']) ??
            'Unknown Tenant',
        profilePhotoUrl: _stringOrNull(
          data['profile_photo_url'] ?? data['profilePhotoUrl'],
        ),
        canAutoVerify: _boolOrFalse(
          data['can_auto_verify'] ?? data['canAutoVerify'],
        ),
      );
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode == 404) {
        throw const _Exception(
          code: _ExceptionCode.studentNotFound,
          message: 'No student found with this phone number or student code.',
        );
      }
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Find student failed', e, s);
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
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
    const defaultException = _ExceptionCode.registrationFailed;

    final payload = {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'password': password,
      'relationship': relationship,
      'student_id': studentId,
      if (email != null && email.trim().isNotEmpty) 'email': email.trim(),
      if (deviceHash != null && deviceHash.trim().isNotEmpty)
        'device_hash': deviceHash.trim(),
      if (deviceName != null && deviceName.trim().isNotEmpty)
        'device_name': deviceName.trim(),
      if (fcmToken != null && fcmToken.trim().isNotEmpty)
        'fcm_token': fcmToken.trim(),
      if (appVersion != null && appVersion.trim().isNotEmpty)
        'app_version': appVersion.trim(),
    };

    Future<HttpClientResponse> tryRegister(String endpoint) {
      return httpClient.post(endpoint, data: payload);
    }

    try {
      late final HttpClientResponse response;

      try {
        response = await tryRegister('/api/v1/auth/register-parent');
      } on HttpClientResponse catch (errorResponse) {
        if (errorResponse.statusCode != 404) {
          rethrow;
        }
        response = await tryRegister('/api/parent/register');
      }

      if (!_isSuccessfulStatus(response.statusCode)) {
        throw _Exception(code: defaultException);
      }

      final data = _extractDataMap(response.data);
      final userId = _stringOrNull(data['user_id'] ?? data['id']) ?? '';
      if (userId.isEmpty) {
        throw _Exception(
          code: defaultException,
          message: 'Registration response did not include user id.',
        );
      }

      final rawChildLinkStatus =
          _stringOrNull(data['child_link_status'] ?? data['childLinkStatus']) ??
          'pending';
      final childLinkStatus = rawChildLinkStatus.toLowerCase() == 'verified'
          ? ParentChildLinkStatus.linked
          : ParentChildLinkStatus.pending;

      await cacheRepository.put(
        _hasLinkedChildrenCacheKey,
        (childLinkStatus == ParentChildLinkStatus.linked).toString(),
      );

      return ParentRegistrationResult(
        userId: userId,
        status: _stringOrNull(data['status']) ?? 'active',
        childLinkStatus: childLinkStatus,
        otpExpiresInSeconds: _intOrNull(
          data['otp_expires_in_seconds'] ?? data['otpExpiresInSeconds'],
        ),
        phone: _stringOrNull(data['phone']) ?? phone,
      );
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode == 409) {
        throw const _Exception(
          code: _ExceptionCode.phoneAlreadyExists,
          message: 'This phone number is already registered.',
        );
      }
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Parent registration failed', e, s);
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await httpClient.post('/api/auth/parent/logout');
    } finally {
      await _deleteCachedUser();
      httpClient.removeBearerToken();
    }
  }

  @override
  Future<ParentEntity?> getCachedUser() async {
    try {
      final cachedUser = await cacheRepository.get(CacheKeys.user);
      if (cachedUser != null) {
        final jsonData = json.decode(cachedUser);
        return ParentModel.fromJson(jsonData);
      }
    } catch (e, s) {
      _logger.error('Failed to get cached user', e, s);
    }

    return null;
  }

  Future<void> _cacheUser(ParentEntity user) async {
    try {
      final jsonData = json.encode(ParentModel.toJson(user));
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
  Future<void> sendOtp(String phone) async {
    const defaultException = _ExceptionCode.failedToSendOtp;

    Future<void> trySend(String endpoint, Map<String, dynamic> payload) async {
      final response = await httpClient.post(endpoint, data: payload);
      if (!_isSuccessfulStatus(response.statusCode)) {
        throw _Exception(code: defaultException);
      }
    }

    try {
      await trySend('/api/v1/auth/register-parent/start', {'phone': phone});
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode == 404) {
        try {
          await trySend('/api/parent/register/start', {'phone': phone});
          return;
        } on HttpClientResponse catch (legacyError) {
          if (legacyError.statusCode == 404) {
            try {
              await trySend('/api/v1/auth/resend-otp', {
                'phone': phone,
                'purpose': 'registration',
              });
              return;
            } on HttpClientResponse catch (fallbackError) {
              handleHttpClientErrorResponse(defaultException, fallbackError);
            }
          }
          handleHttpClientErrorResponse(defaultException, legacyError);
        }
      }
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Send OTP failed', e, s);
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<Duration?> resendOtp(String phone) async {
    const defaultException = _ExceptionCode.failedToResendOtp;

    Future<Duration?> tryResend(String endpoint) async {
      final response = await httpClient.post(endpoint, data: {'phone': phone});
      if (!_isSuccessfulStatus(response.statusCode)) {
        throw _Exception(code: defaultException);
      }

      final data = response.data;
      if (data is Map<String, dynamic>) {
        final responseData = data['data'];
        if (responseData is Map<String, dynamic>) {
          final seconds = responseData['otp_expires_in_seconds'];
          if (seconds is int && seconds > 0) {
            return Duration(seconds: seconds);
          }
        }
      }

      return null;
    }

    try {
      return await tryResend('/api/v1/auth/resend-otp');
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode == 404) {
        try {
          return await tryResend('/api/auth/resend-otp');
        } on HttpClientResponse catch (legacyErrorResponse) {
          if (legacyErrorResponse.statusCode == 404) {
            try {
              return await tryResend('/api/parent/register/resend-otp');
            } on HttpClientResponse catch (fallbackErrorResponse) {
              handleHttpClientErrorResponse(
                defaultException,
                fallbackErrorResponse,
              );
            }
          }
          handleHttpClientErrorResponse(defaultException, legacyErrorResponse);
        }
      }
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Resend OTP failed', e, s);
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<void> requestPasswordReset(String phone) async {
    const defaultException = _ExceptionCode.failedToRequestPasswordReset;

    Future<void> tryRequest(String endpoint) async {
      final response = await httpClient.post(endpoint, data: {'phone': phone});
      if (!_isSuccessfulStatus(response.statusCode)) {
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
      _logger.error('Request password reset failed', e, s);
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<void> resetPassword({
    required String phone,
    required String otp,
    required String newPassword,
  }) async {
    const defaultException = _ExceptionCode.failedToResetPassword;

    Future<void> tryReset(String endpoint, Map<String, dynamic> payload) async {
      final response = await httpClient.post(endpoint, data: payload);
      if (!_isSuccessfulStatus(response.statusCode)) {
        throw _Exception(code: defaultException);
      }
    }

    final primaryPayload = {
      'phone': phone,
      'otp': otp,
      'new_password': newPassword,
    };
    final secondaryPayload = {
      'phone': phone,
      'otp_code': otp,
      'password': newPassword,
    };

    try {
      await tryReset('/api/v1/auth/reset-password', primaryPayload);
      await _clearLocalSession();
    } on HttpClientResponse catch (errorResponse) {
      if (errorResponse.statusCode == 400 || errorResponse.statusCode == 422) {
        try {
          await tryReset('/api/v1/auth/reset-password', secondaryPayload);
          await _clearLocalSession();
          return;
        } on HttpClientResponse catch (_) {
          // Continue to legacy endpoint fallback.
        }
      }

      if (errorResponse.statusCode == 404) {
        try {
          await tryReset('/api/auth/reset-password', primaryPayload);
          await _clearLocalSession();
          return;
        } on HttpClientResponse catch (_) {
          try {
            await tryReset('/api/auth/reset-password', secondaryPayload);
            await _clearLocalSession();
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
      _logger.error('Reset password failed', e, s);
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<ParentEntity> verifyOtp(String phone, String code) async {
    const defaultException = _ExceptionCode.invalidOtp;

    Future<HttpClientResponse> tryVerify(
      String endpoint,
      Map<String, dynamic> payload,
    ) {
      return httpClient.post(endpoint, data: payload);
    }

    try {
      late final HttpClientResponse response;

      try {
        response = await tryVerify('/api/v1/auth/verify-otp', {
          'phone': phone,
          'otp_code': code,
          'purpose': 'registration',
        });
      } on HttpClientResponse catch (errorResponse) {
        if (errorResponse.statusCode != 404) {
          rethrow;
        }

        response = await tryVerify('/api/parent/register/complete', {
          'phone': phone,
          'otp': code,
        });
      }

      if (_isSuccessfulStatus(response.statusCode)) {
        final data = _extractDataMap(response.data);
        final String? accessToken = _extractAccessToken(data);
        final String? refreshToken = _extractRefreshToken(data);

        if (accessToken != null) {
          httpClient.setBearerToken(accessToken, refreshToken: refreshToken);
        }

        final user = ParentModel.fromJson(data);
        await _cacheUser(user);
        return user;
      }

      throw _Exception(code: defaultException);
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Verify OTP failed', e, s);
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  Future<void> _clearLocalSession() async {
    await _deleteCachedUser();
    httpClient.removeBearerToken();
  }

  Map<String, dynamic> _extractDataMap(dynamic rawResponse) {
    final root = _asMap(rawResponse);
    final dynamic dataCandidate = root['data'];

    if (dataCandidate is Map) {
      return {
        ...root,
        ..._asMap(dataCandidate),
      };
    }

    return root;
  }

  String? _extractAccessToken(Map<String, dynamic> data) {
    return _stringOrNull(data['accessToken'] ?? data['access_token']);
  }

  String? _extractRefreshToken(Map<String, dynamic> data) {
    return _stringOrNull(data['refreshToken'] ?? data['refresh_token']);
  }

  bool _extractHasLinkedChildren(Map<String, dynamic> data) {
    final children = data['children'];
    if (children is List) {
      return children.isNotEmpty;
    }

    final count = _intOrNull(data['children_count'] ?? data['childrenCount']);
    if (count != null) {
      return count > 0;
    }

    return _boolOrFalse(data['has_children'] ?? data['hasChildren']);
  }

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }

    return <String, dynamic>{};
  }

  String? _stringOrNull(dynamic value) {
    if (value == null) {
      return null;
    }

    final parsed = value.toString().trim();
    return parsed.isEmpty ? null : parsed;
  }

  bool _boolOrFalse(dynamic value) {
    if (value is bool) {
      return value;
    }
    if (value is num) {
      return value != 0;
    }
    final normalized = value?.toString().trim().toLowerCase();
    return normalized == 'true' || normalized == '1' || normalized == 'yes';
  }

  int? _intOrNull(dynamic value) {
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

  bool _isSuccessfulStatus(int statusCode) {
    return statusCode == 200 || statusCode == 201 || statusCode == 204;
  }
}
