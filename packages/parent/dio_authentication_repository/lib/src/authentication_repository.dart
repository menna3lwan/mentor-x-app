import 'dart:convert';

import 'package:mentorx_core/mentorx_core.dart';

typedef _Exception = AuthenticationException;
typedef _ExceptionCode = AuthenticationExceptionCode;

final class DioAuthenticationRepository
    extends HttpClientRepository<AuthenticationExceptionCode>
    implements AuthenticationRepository {
      
  @override
  Never throwException(
    AuthenticationExceptionCode code, {
    String? message,
  }) =>
      throw _Exception(code: code, message: message);

  final HttpClient httpClient;
  final CacheRepository cacheRepository;

  DioAuthenticationRepository({
    required this.httpClient,
    required this.cacheRepository,
  });

  static final MentorXLogger _logger = MentorXLogger('DioAuthenticationRepository');

  @override
  Future<void> initialize() async {}

  @override
  Future<ParentEntity> login({
    required String phone,
    required String password,
  }) async {
    const defaultException = _ExceptionCode.invalidCredentials;
    try {
      final response = await httpClient.post(
        '/api/auth/parent/login',
        data: {'phone': phone, 'password': password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
        final String? accessToken = data['accessToken'] as String? ?? response.data['accessToken'] as String?;
        
        if (accessToken != null) {
          httpClient.setBearerToken(accessToken);
        }

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
    const defaultException = _ExceptionCode.unknown;
    try {
      final response = await httpClient.post(
        '/api/parent/register/start',
        data: {'phone': phone},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw _Exception(code: defaultException);
      }
    } on HttpClientResponse catch (errorResponse) {
      handleHttpClientErrorResponse(defaultException, errorResponse);
    } catch (e, s) {
      _logger.error('Send OTP failed', e, s);
      if (e is _Exception) rethrow;
      throw _Exception(code: defaultException, message: e.toString());
    }
  }

  @override
  Future<ParentEntity> verifyOtp(String phone, String code) async {
    const defaultException = _ExceptionCode.invalidOtp;
    try {
      final response = await httpClient.post(
        '/api/parent/register/complete',
        data: {'phone': phone, 'otp': code},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
        final String? accessToken = data['accessToken'] as String? ?? response.data['accessToken'] as String?;
        
        if (accessToken != null) {
          httpClient.setBearerToken(accessToken);
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
}
