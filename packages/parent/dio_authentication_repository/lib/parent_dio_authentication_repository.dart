import 'dart:convert';

import 'package:mentorx_core/mentorx_core.dart';
import 'models/parent_model.dart';
export 'models/parent_model.dart';

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
      httpClient.setAccessToken(cachedAccessToken).ignore();
      if (cachedRefreshToken != null) {
        httpClient.setRefreshToken(cachedRefreshToken).ignore();
      }
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
    // ─────────────────────────────────────────────────────────────────────
    // API-CONTRACT (Swagger): parent login is OTP-based.
    //
    //   POST /api/parent/start-login    body: { parentPhone }
    //   POST /api/parent/complete-login body: { parentPhone, otp }
    //
    // The login form still collects a password for backward compatibility
    // with older UI builds, but the backend flow now starts by sending the
    // login code and then switching the UI to the OTP screen.
    // ─────────────────────────────────────────────────────────────────────
    try {
      await sendOtp(phone);
      throw const _Exception(code: _ExceptionCode.otpRequired);
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.invalidCredentials,
      );
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // API-CONTRACT (KNOWN MISMATCH):
  // The EduCore Postman collection does NOT declare a parent self-registration
  // endpoint. The methods below (registerParent / findStudentForParentRegistration)
  // continue to call the legacy paths /api/parent/register and
  // /api/parent/find-student so the UI flow does not regress; on a 404/405
  // they surface AuthenticationException with the appropriate code so the
  // caller can present a localized "feature unavailable" message.
  // Coordinate with backend before re-enabling this flow in production.
  // ─────────────────────────────────────────────────────────────────────────
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
    try {
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

      final response = await httpClient.post(
        '/api/parent/register',
        data: payload,
      );

      final data = _extractDataMap(response.data);
      final userId = stringOrNull(data['user_id'] ?? data['id']) ?? '';
      if (userId.isEmpty) {
        throw _Exception(
          code: _ExceptionCode.registrationFailed,
          message: 'Registration response did not include user id.',
        );
      }

      final rawChildLinkStatus =
          stringOrNull(data['child_link_status'] ?? data['childLinkStatus']) ??
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
        status: stringOrNull(data['status']) ?? 'active',
        childLinkStatus: childLinkStatus,
        otpExpiresInSeconds: intOrNull(
          data['otp_expires_in_seconds'] ?? data['otpExpiresInSeconds'],
        ),
        phone: stringOrNull(data['phone']) ?? phone,
      );
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 409) {
        throw const _Exception(
          code: _ExceptionCode.phoneAlreadyExists,
          message: 'This phone number is already registered.',
        );
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.registrationFailed,
      );
    }
  }

  @override
  Future<ParentStudentLookupEntity> findStudentForParentRegistration({
    required ParentLookupType lookupType,
    required String value,
  }) async {
    try {
      final lookupTypeWire = switch (lookupType) {
        ParentLookupType.phone => 'phone',
        ParentLookupType.studentCode => 'student_code',
      };
      final payload = {
        'lookup_type': lookupTypeWire,
        'value': value.trim(),
      };

      final response = await httpClient.post(
        '/api/parent/find-student',
        data: payload,
      );

      final data = _extractDataMap(response.data);
      final studentId = stringOrNull(data['student_id'] ?? data['id']);
      if (studentId == null) {
        throw _Exception(
          code: _ExceptionCode.studentNotFound,
          message: 'No student was found for the provided lookup value.',
        );
      }

      return ParentStudentLookupEntity(
        studentId: studentId,
        maskedName:
            '${stringOrNull(data['first_name_masked'] ?? data['firstNameMasked']) ?? '**'} ${stringOrNull(data['last_name_masked'] ?? data['lastNameMasked']) ?? '**'}',
        gradeName:
            stringOrNull(data['grade_name'] ?? data['gradeName']) ??
            'Unknown Grade',
        centerName:
            stringOrNull(data['tenant_name'] ?? data['tenantName']) ??
            'Unknown Tenant',
        profilePhotoUrl: stringOrNull(
          data['profile_photo_url'] ?? data['profilePhotoUrl'],
        ),
        canAutoVerify: boolOrFalse(
          data['can_auto_verify'] ?? data['canAutoVerify'],
        ),
      );
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404) {
        throw const _Exception(
          code: _ExceptionCode.studentNotFound,
          message: 'No student found with this phone number or student code.',
        );
      }
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.studentNotFound,
      );
    }
  }

  @override
  Future<void> forceLogoutAll() async {
    try {
      await httpClient.post('/api/parent/logout-all');
    } catch (_) {
    } finally {
      await _deleteCachedUser();
      await httpClient.clearTokens();
    }
  }

  @override
  Future<ParentEntity> getMe() async {
    try {
      final response = await httpClient.get('/api/parent/me');
      final data = _extractDataMap(response.data);
      final user = ParentModel.fromJson(data);
      await _cacheUser(user);
      return user;
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.sessionExpired,
      );
    }
  }

  @override
  Future<void> logout() async {
    // Backend contract (Postman): primary logout is POST /api/parent/logout.
    // Generic /api/auth/logout is the secondary fallback; the legacy
    // /api/auth/parent/logout path is kept last for backward compatibility
    // with older backend builds. Local session is always cleared.
    try {
      try {
        await httpClient.post('/api/parent/logout');
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404 && e.statusCode != 405) rethrow;
        try {
          await httpClient.post('/api/auth/logout');
        } on HttpClientResponse catch (e2) {
          if (e2.statusCode != 404 && e2.statusCode != 405) rethrow;
          await httpClient.post('/api/auth/parent/logout');
        }
      }
    } catch (_) {
      // Network or unknown error — drop local session regardless.
    } finally {
      await _deleteCachedUser();
      await httpClient.clearTokens();
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
      final jsonData = json.encode(ParentModel.fromEntity(user).toJson());
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
  Future<void> requestPasswordReset(String phone) async {
    try {
      await httpClient.post(
        '/api/auth/forgot-password',
        data: {'phone': phone},
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
    required String phone,
    required String otp,
    required String newPassword,
  }) async {
    // Backend contract (OpenAPI): /api/auth/reset-password body shape is
    // { phone, newPassword }. OTP is verified by /api/auth/verify-otp before
    // this step; legacy payloads are kept as fallbacks for older builds.
    final primaryPayload = {
      'phone': phone,
      'newPassword': newPassword,
    };
    final legacyPayloadWithOtp = {
      'phone': phone,
      'otp': otp,
      'newPassword': newPassword,
    };
    final legacySnakeCasePayload = {
      'phone': phone,
      'otp': otp,
      'new_password': newPassword,
    };

    try {
      await httpClient.post('/api/auth/reset-password', data: primaryPayload);
      await _clearLocalSession();
    } on HttpClientResponse catch (e) {
      // If the primary payload shape was rejected, try the legacy shape.
      if (e.statusCode == 400 || e.statusCode == 422) {
        try {
          await httpClient.post(
            '/api/auth/reset-password',
            data: legacyPayloadWithOtp,
          );
          await _clearLocalSession();
          return;
        } catch (_) {}
        try {
          await httpClient.post(
            '/api/auth/reset-password',
            data: legacySnakeCasePayload,
          );
          await _clearLocalSession();
          return;
        } catch (_) {}
      }

      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToResetPassword,
      );
    }
  }

  Future<void> _clearLocalSession() async {
    await _deleteCachedUser();
    await httpClient.clearTokens();
  }

  @override
  Future<void> sendOtp(String phone) async {
    final result = AuthRateLimiter.canAttempt(phone, 'send_otp');
    if (!result.canAttempt) {
      throw RateLimitExceededException(
        message: 'Too many OTP requests. Please wait.',
        remainingCooldown: result.remainingCooldown,
        identifier: phone,
        endpoint: 'send_otp',
      );
    }

    // Backend contract (Swagger): the parent OTP send path is
    //   POST /api/parent/start-login  body: { parentPhone }
    // or the generic
    //   POST /api/auth/resend-otp     body: { phone }
    // The legacy /api/parent/register/start is kept as a last fallback only.
    try {
      try {
        await httpClient.post(
          '/api/parent/start-login',
          data: {'parentPhone': phone},
        );
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404 && e.statusCode != 405) rethrow;
        await httpClient.post(
          '/api/auth/resend-otp',
          data: {'phone': phone},
        );
      }
      AuthRateLimiter.recordSuccessfulAttempt(phone, 'send_otp');
    } on HttpClientResponse catch (e) {
      AuthRateLimiter.recordFailedAttempt(phone, 'send_otp');
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToSendOtp,
      );
    }
  }

  @override
  Future<Duration?> resendOtp(String phone) async {
    final result = AuthRateLimiter.canAttempt(phone, 'resend_otp');
    if (!result.canAttempt) {
      throw RateLimitExceededException(
        message: 'Too many OTP requests. Please wait.',
        remainingCooldown: result.remainingCooldown,
        identifier: phone,
        endpoint: 'resend_otp',
      );
    }

    // Backend contract (Swagger): POST /api/auth/resend-otp body { phone }.
    // Fallback: POST /api/parent/start-login body { parentPhone }.
    try {
      HttpClientResponse response;
      try {
        response = await httpClient.post(
          '/api/auth/resend-otp',
          data: {'phone': phone},
        );
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404 && e.statusCode != 405) rethrow;
        response = await httpClient.post(
          '/api/parent/start-login',
          data: {'parentPhone': phone},
        );
      }

      AuthRateLimiter.recordSuccessfulAttempt(phone, 'resend_otp');
      final data = _extractDataMap(response.data);
      final seconds = intOrNull(
        data['otp_expires_in_seconds'] ?? data['otpExpiresInSeconds'],
      );
      return seconds != null && seconds > 0 ? Duration(seconds: seconds) : null;
    } on HttpClientResponse catch (e) {
      AuthRateLimiter.recordFailedAttempt(phone, 'resend_otp');
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToResendOtp,
      );
    }
  }

  @override
  Future<ParentEntity> verifyOtp(String phone, String code) async {
    // Backend contract (Swagger):
    //   POST /api/auth/verify-otp        body: { phone, otp (int) }
    //   POST /api/parent/complete-login  body: { parentPhone, otp (string) }
    try {
      HttpClientResponse response;
      try {
        response = await httpClient.post(
          '/api/auth/verify-otp',
          data: {'phone': phone, 'otp': int.tryParse(code) ?? code},
        );
      } on HttpClientResponse catch (e) {
        if (e.statusCode != 404 && e.statusCode != 405) rethrow;
        response = await httpClient.post(
          '/api/parent/complete-login',
          data: {'parentPhone': phone, 'otp': code},
        );
      }

      final data = _extractDataMap(response.data);
      _setTokensIfPresent(data);

      final user = ParentModel.fromJson(data);
      await _cacheUser(user);
      return user;
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.invalidOtp,
      );
    }
  }

  void _setTokensIfPresent(Map<String, dynamic> data) {
    // Backend contract (Swagger): complete-login returns { token }, while
    // verify-otp may return { accessToken } or { access_token }. Try all
    // known key names.
    final accessToken = stringOrNull(
      data['accessToken'] ?? data['access_token'] ?? data['token'],
    );
    if (accessToken == null) return;

    final refreshToken = stringOrNull(
      data['refreshToken'] ?? data['refresh_token'],
    );

    httpClient.setAccessToken(accessToken).ignore();
    cacheRepository.put(CacheKeys.accessToken, accessToken).ignore();

    if (refreshToken != null) {
      httpClient.setRefreshToken(refreshToken).ignore();
      cacheRepository.put(CacheKeys.refreshToken, refreshToken).ignore();
    }
  }

  Map<String, dynamic> _extractDataMap(dynamic rawResponse) {
    final root = asMap(rawResponse);
    final dynamic dataCandidate = root['data'];

    if (dataCandidate is Map) {
      return {
        ...root,
        ...asMap(dataCandidate),
      };
    }

    return root;
  }
}
