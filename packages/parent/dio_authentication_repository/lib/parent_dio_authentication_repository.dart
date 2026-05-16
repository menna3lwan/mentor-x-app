import 'dart:convert';

import 'package:mentorx_core/mentorx_core.dart';
import 'models/parent_model.dart';
export 'models/parent_model.dart';

typedef _Exception = AuthenticationException;
typedef _ExceptionCode = AuthenticationExceptionCode;

final class DioAuthenticationRepository
    extends HttpClientRepository<AuthenticationExceptionCode>
    implements AuthenticationRepository<ParentEntity> {
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
    try {
      final response = await httpClient.post(
        '/api/parent/start-login',
        data: {'phone': phone, 'password': password},
      );

      final data = response.asMap();
      throw AuthenticationRequiresOtpException(
        message: ModelParser.asString(data['message'], fallback: 'OTP Sent'),
        otpDuration: Duration(
          seconds: ModelParser.asInt(data['otpExpiresInSeconds']),
        ),
      );
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.invalidCredentials,
      );
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
    try {
      final payload = {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'password': password,
        'relationship': relationship,
        'studentId': studentId,
        if (email != null) 'email': email,
      };

      final response = await httpClient.post(
        '/api/parent/register',
        data: payload,
      );
      final data = response.asMap();

      return ParentRegistrationResult(
        userId: ModelParser.asString(data['id'] ?? data['parentId']),
        status: ModelParser.asString(data['status'], fallback: 'active'),
        childLinkStatus: ParentChildLinkStatus.linked,
        phone: phone,
      );
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 409) {
        throw const _Exception(
          code: _ExceptionCode.phoneAlreadyExists,
          message: 'This phone number is already registered.',
        );
      }
      return handleHttpClientErrorResponse(
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
      final payload = {
        'lookupType': lookupType == ParentLookupType.phone
            ? 'PHONE'
            : 'STUDENT_CODE',
        'value': value.trim(),
      };

      final response = await httpClient.post(
        '/api/parent/find-student',
        data: payload,
      );
      final data = response.asMap();

      return ParentStudentLookupEntity(
        studentId: ModelParser.asString(data['studentId']),
        maskedName: ModelParser.asString(data['studentName']),
        gradeName: ModelParser.asString(data['grade']),
        centerName: ModelParser.asString(data['centerName']),
        profilePhotoUrl: ModelParser.asString(data['profileImageUrl']),
        canAutoVerify: true,
      );
    } on HttpClientResponse catch (e) {
      if (e.statusCode == 404) {
        throw const _Exception(
          code: _ExceptionCode.studentNotFound,
          message: 'No student found with this phone number or student code.',
        );
      }
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.studentNotFound,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await httpClient.post('/api/parent/logout');
    } catch (_) {
    } finally {
      await _deleteCachedUser();
      await httpClient.clearTokens();
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
      final user = ParentModel.fromJson(response.asMap());
      await _cacheUser(user);
      return user;
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.unknown,
      );
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
    try {
      await httpClient.post(
        '/api/auth/reset-password',
        data: {
          'phone': phone,
          'otp': otp,
          'newPassword': newPassword,
        },
      );
      await _clearLocalSession();
    } on HttpClientResponse catch (e) {
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
    try {
      await httpClient.post(
        '/api/parent/register/start',
        data: {'phone': phone},
      );
    } on HttpClientResponse catch (e) {
      handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToSendOtp,
      );
    }
  }

  @override
  Future<Duration?> resendOtp(String phone) async {
    try {
      final response = await httpClient.post(
        '/api/auth/resend-otp',
        data: {'phone': phone},
      );
      final data = response.asMap();
      final seconds = ModelParser.asInt(data['otpExpiresInSeconds']);
      return seconds > 0 ? Duration(seconds: seconds) : null;
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.failedToResendOtp,
      );
    }
  }

  @override
  Future<ParentEntity> verifyOtp(String phone, String code) async {
    try {
      final response = await httpClient.post(
        '/api/parent/complete-login',
        data: {
          'phone': phone,
          'otp': code,
        },
      );

      final data = response.asMap();
      _setTokensIfPresent(data);

      final user = ParentModel.fromJson(data);
      await _cacheUser(user);
      return user;
    } on HttpClientResponse catch (e) {
      return handleHttpClientErrorResponse(
        e,
        defaultCode: _ExceptionCode.invalidOtp,
      );
    }
  }

  void _setTokensIfPresent(Map<String, dynamic> data) {
    final accessToken = stringOrNull(
      data['accessToken'] ?? data['access_token'],
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

}
