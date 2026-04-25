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
  final void Function(String token, String? refreshToken) _onTokensUpdated;

  static const String _accessTokenKey = CacheKeys.accessToken;
  static const String _refreshTokenKey = CacheKeys.refreshToken;
  
  // Use the project's actual endpoint found in Swagger
  static const String _refreshEndpoint = '/api/auth/refresh';

  static final MentorXLogger _logger = MentorXLogger('RefreshTokenInterceptor');

  /// Flag to prevent multiple simultaneous refresh requests
  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  RefreshTokenInterceptor({
    required Dio dio,
    required CacheRepository cacheRepository,
    required String baseUrl,
    required void Function(String token, String? refreshToken) onTokensUpdated,
  }) : _dio = dio,
       _cacheRepository = cacheRepository,
       _baseUrl = baseUrl,
       _onTokensUpdated = onTokensUpdated;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if this is a 401 Unauthorized error
    if (err.response?.statusCode == 401) {
      // Don't refresh if the request was already a refresh attempt
      if (err.requestOptions.path.contains(_refreshEndpoint)) {
        _isRefreshing = false;
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
            // Refresh failed, forward the error
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
            _onTokensUpdated(accessToken, refreshToken);
          }

          // Complete the refresh process
          _isRefreshing = false;
          _refreshCompleter?.complete();

          // Retry the original request with the new token
          return handler.resolve(await _retry(err.requestOptions));
        } else {
          // Refresh failed, forward the error
          _isRefreshing = false;
          _refreshCompleter?.completeError(err);
          return handler.next(err);
        }
      } catch (e, s) {
        _logger.error('Token refresh failed', e, s);
        _isRefreshing = false;
        _refreshCompleter?.completeError(e);
        return handler.next(err);
      }
    }

    // Not a 401 error, pass through
    return handler.next(err);
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
        // Clean up tokens
        await _cacheRepository.remove(_refreshTokenKey);
        await _cacheRepository.remove(_accessTokenKey);
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

    // Retry the request using the main dio instance
    return _dio.fetch(requestOptions);
  }

  /// Validates a JWT token by checking its expiry
  bool _isTokenValid(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;

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
      return false;
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
