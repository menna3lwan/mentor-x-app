part of '../../dio_http_client.dart';

/// Interceptor that automatically refreshes access tokens when they expire
///
/// When a 401 Unauthorized response is received, this interceptor will:
/// 1. Retrieve the refresh token from cache
/// 2. Request new access and refresh tokens from the refresh endpoint
/// 3. Update the cached tokens
/// 4. Retry the original request with the new access token
///
/// If the refresh fails (e.g., refresh token is expired), the interceptor
/// will forward the error and the user will need to re-authenticate.
class RefreshTokenInterceptor extends Interceptor {
  final Dio _dio;
  final CacheRepository _cacheRepository;
  final String _baseUrl;
  final Future<void> Function(String token, String? refreshToken) _onTokensUpdated;
  final Future<void> Function()? _onSessionExpired;

  static const String _accessTokenKey = CacheKeys.accessToken;
  static const String _refreshTokenKey = CacheKeys.refreshToken;
  
  // Use the project's actual endpoint found in Swagger
  static const String _refreshEndpoint = '/api/auth/refresh';
  static const String _retryKey = 'is_retry';

  static final MentorXLogger _logger = MentorXLogger('RefreshTokenInterceptor');

  /// Flag to prevent multiple simultaneous refresh requests
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  RefreshTokenInterceptor({
    required Dio dio,
    required CacheRepository cacheRepository,
    required String baseUrl,
    required Future<void> Function(String token, String? refreshToken) onTokensUpdated,
    Future<void> Function()? onSessionExpired,
  }) : _dio = dio,
       _cacheRepository = cacheRepository,
       _baseUrl = baseUrl,
       _onTokensUpdated = onTokensUpdated,
       _onSessionExpired = onSessionExpired;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if this is a 401 Unauthorized error
    if (err.response?.statusCode == 401) {
      // Don't refresh if the request was already a refresh attempt or is already a retry
      final isRetry = err.requestOptions.extra[_retryKey] == true;
      if (err.requestOptions.path.contains(_refreshEndpoint) || isRetry) {
        _isRefreshing = false;
        
        // If it was already a retry and still failed with 401, the session is dead
        if (isRetry) {
          _logger.warning('Retry request failed with 401 again, triggering session expiry');
          final didChange = await _hasTokenChangedSince(err.requestOptions);
          if (!didChange && _onSessionExpired != null) {
            await _onSessionExpired();
          }
        }
        
        return handler.next(err);
      }

      try {
        // Prevent multiple simultaneous refresh attempts
        if (_isRefreshing) {
          // Wait for the ongoing refresh to complete
          try {
            await _refreshCompleter?.future;
            // Retry the original request with the new token
            return handler.resolve(await _retry(err.requestOptions));
          } catch (e) {
            // Refresh failed for the other request too
            return handler.next(err);
          }
        }

        _isRefreshing = true;
        _refreshCompleter = Completer<void>();

        // Attempt to refresh the token
        final newTokens = await _refreshAccessToken();

        if (newTokens != null) {
          // Update the tokens in the client
          final accessToken = newTokens['accessToken'];
          final refreshToken = newTokens['refreshToken'];
          if (accessToken != null) {
            await _onTokensUpdated(accessToken, refreshToken);
          }

          // Complete the refresh process
          _isRefreshing = false;
          _refreshCompleter?.complete();

          // Retry the original request with the new token
          return handler.resolve(await _retry(err.requestOptions));
        } else {
          // Refresh failed
          _isRefreshing = false;
          _refreshCompleter?.completeError(err);

          // Guard: only expire the session if the token that caused the 401 is
          // still the current one. A newer login (e.g. OTP just completed) may
          // have already replaced it — wiping that fresh token would log the
          // user out immediately after a successful login.
          final didTokenChange = await _hasTokenChangedSince(err.requestOptions);
          if (didTokenChange) {
            _logger.info(
              'Skipping session expiry — token changed since the failed request '
              '(user re-authenticated while refresh was in flight)',
            );
            return handler.next(err);
          }

          _logger.warning('Token refresh failed, triggering session expiry');
          if (_onSessionExpired != null) {
            await _onSessionExpired();
          }

          return handler.next(err);
        }
      } catch (e, s) {
        _logger.error('Token refresh logic encountered an unexpected error', e, s);
        _isRefreshing = false;
        _refreshCompleter?.completeError(e);
        return handler.next(err);
      }
    }

    // Not a 401 error, pass through
    return handler.next(err);
  }

  /// Returns true if a newer/fresh session token exists compared to what was
  /// sent with [requestOptions]. This guards against clearing a valid new
  /// session when a stale 401 (from before login) arrives late.
  ///
  /// Two cases are covered:
  /// 1. Original request had a token → a different token is now cached
  ///    (user re-authenticated while refresh was in-flight).
  /// 2. Original request had NO token → a fresh token now exists
  ///    (e.g. background notification fired before login, OTP completed
  ///    before the 401 response arrived).
  Future<bool> _hasTokenChangedSince(RequestOptions requestOptions) async {
    final currentToken = await _cacheRepository.get(_accessTokenKey);
    final authHeader = requestOptions.headers['Authorization'] as String?;

    if (authHeader == null || !authHeader.startsWith('Bearer ')) {
      // Original request was unauthenticated. If we now have a fresh token,
      // a new login happened while this 401 was in-flight — protect it.
      return currentToken != null && currentToken.isNotEmpty;
    }

    final sentToken = authHeader.substring(7);
    return currentToken != null && currentToken != sentToken;
  }

  /// Refreshes the access token using the refresh token
  ///
  /// Returns a map with 'accessToken' and 'refreshToken' keys if successful,
  /// or null if the refresh fails
  Future<Map<String, String>?> _refreshAccessToken() async {
    try {
      // Get the refresh token from cache
      final refreshToken = await _cacheRepository.get(_refreshTokenKey);

      if (refreshToken == null || refreshToken.isEmpty) {
        _logger.warning('No refresh token available');
        return null;
      }

      // Validate refresh token expiry before attempting refresh
      if (!_isTokenValid(refreshToken)) {
        _logger.warning('Refresh token is expired or invalid');
        return null;
      }

      _logger.info('Attempting to refresh access token');

      // Create a new Dio instance to avoid interceptor loops
      final refreshDio = Dio(BaseOptions(baseUrl: _baseUrl));

      // Make the refresh request
      // Note: According to Swagger, it expects the refresh token in the Authorization header
      final response = await refreshDio.post(
        _refreshEndpoint,
        options: Options(headers: {
          'Authorization': 'Bearer $refreshToken',
        }),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = asMap(response.data)['data'] ?? asMap(response.data);
        final newAccessToken = stringOrNull(
          data['token'] ?? data['access_token'] ?? data['accessToken'],
        );
        final newRefreshToken = stringOrNull(
          data['refresh_token'] ?? data['refreshToken'],
        );

        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          // Cache the new tokens
          await _cacheRepository.put(_accessTokenKey, newAccessToken);

          if (newRefreshToken != null && newRefreshToken.isNotEmpty) {
            await _cacheRepository.put(_refreshTokenKey, newRefreshToken);
          }

          _logger.info('Access token refreshed successfully');

          return {
            'accessToken': newAccessToken,
            'refreshToken': newRefreshToken ?? refreshToken,
          };
        }
      }

      _logger.warning('Token refresh response missing required fields');
      return null;
    } catch (e, s) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        // Both 401 (Unauthorized) and 403 (Forbidden) usually indicate
        // that the refresh token is expired or has been revoked.
        if (statusCode == 401 || statusCode == 403) {
          _logger.warning('Refresh attempt returned $statusCode, session is definitely dead');
        }
      }
      _logger.error('Failed to refresh access token', e, s);
      return null;
    }
  }

  /// Retries the original request with the new access token
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    // Get the new access token from cache or client
    final accessToken = await _cacheRepository.get(_accessTokenKey);

    if (accessToken != null && accessToken.isNotEmpty) {
      // Update the Authorization header
      requestOptions.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Mark request as a retry to prevent infinite loops if the new token is also invalid
    requestOptions.extra[_retryKey] = true;

    // Retry the request using the main dio instance
    return _dio.fetch(requestOptions);
  }

  /// Validates a JWT token by checking its expiry.
  /// 
  /// If the token is not a valid JWT (not 3 parts), it returns true
  /// to allow the backend to be the source of truth for its validity.
  bool _isTokenValid(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        // Not a JWT, we assume it's an opaque token that might be valid.
        return true;
      }

      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final map = json.decode(payload) as Map<String, dynamic>;
      final exp = map['exp'] as int?;
      if (exp == null) return true;

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      // Buffer of 30 seconds to be safe
      return expiryDate.isAfter(DateTime.now().add(const Duration(seconds: 30)));
    } catch (_) {
      // On parsing error, let the backend decide
      return true;
    }
  }

  // Helper methods to match the repository's data parsing logic
  Map<String, dynamic> asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), value));
    }
    return {};
  }

  String? stringOrNull(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }
}
