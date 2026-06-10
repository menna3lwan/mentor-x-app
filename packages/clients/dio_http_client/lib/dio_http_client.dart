import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'src/interceptors/refresh_token_interceptor.dart';
part 'src/interceptors/header_interceptor.dart';

final class DioHttpClient implements HttpClient {
  final Dio _dio;
  final CacheRepository _cacheRepository;
  final Map<String, String> _defaultHeaders = {};

  String? _accessToken;
  String? _refreshToken;
  String? _userId;
  String _languageCode = 'ar';
  final Future<void> Function()? _onSessionExpired;

  DioHttpClient({
    required String baseUrl,
    required CacheRepository cacheRepository,
    Future<void> Function()? onSessionExpired,
  }) : _dio = Dio(BaseOptions(baseUrl: baseUrl)),
       _cacheRepository = cacheRepository,
       _onSessionExpired = onSessionExpired {
    _registerInterceptors(baseUrl);
  }

  static final MentorXLogger _logger = MentorXLogger('DioHttpClient');

  @override
  Future<void> initialize() async {
    await _loadCachedToken();
  }

  void _registerInterceptors(String baseUrl) {
    // 1. Header Injection (Token, Device ID, Locale)
    addInterceptor(HeaderInterceptor(httpClient: this));

    // 2. Token Refresh Logic
    addInterceptor(
      RefreshTokenInterceptor(
        dio: _dio,
        cacheRepository: _cacheRepository,
        baseUrl: baseUrl,
        onTokensUpdated: (token, refreshToken) {
          _logger.info('Tokens updated via RefreshTokenInterceptor');
          return setAccessToken(token).then((_) {
            if (refreshToken != null) return setRefreshToken(refreshToken);
          });
        },
        onSessionExpired: () async {
          _logger.warning(
            'Session expired signal received from RefreshTokenInterceptor',
          );
          if (_onSessionExpired != null) {
            await _onSessionExpired.call();
          }
          await clearTokens();
        },
      ),
    );
  }

  /// Adds a Dio interceptor to the client
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  String get languageCode => _languageCode;

  set languageCode(String code) {
    _languageCode = code;
    setDefaultHeader('Accept-Language', code);
  }

  @override
  void setLocale(String languageCode) {
    this.languageCode = languageCode;
  }

  /// Loads cached token and sets it as bearer token
  /// Only loads the token if it's still valid (not expired)
  Future<void> _loadCachedToken() async {
    _logger.debug('Attempting to load cached authentication state...');

    final cachedToken = await _cacheRepository.get(CacheKeys.accessToken);
    final cachedRefreshToken = await _cacheRepository.get(
      CacheKeys.refreshToken,
    );
    final cachedDeviceId = await _cacheRepository.get(CacheKeys.deviceId);

    if (cachedDeviceId != null && cachedDeviceId.isNotEmpty) {
      _logger.debug('Restored Device ID from cache: $cachedDeviceId');
      setDefaultHeader(NetworkConstants.deviceIdHeader, cachedDeviceId);
    }

    if (cachedToken != null && cachedToken.isNotEmpty) {
      final isExpired = _isJwtTokenExpired(cachedToken);
      _logger.debug('Found cached access token (Expired: $isExpired)');

      if (isExpired) {
        _logger.warning('Cached token is expired, clearing session');
        await clearTokens();
      } else {
        await setAccessToken(cachedToken);
        if (cachedRefreshToken != null) {
          _logger.debug('Restored refresh token from cache');
          await setRefreshToken(cachedRefreshToken);
        }
        _logger.info(
          'Authentication state successfully restored from cache (token len=${cachedToken.length})',
        );
      }
      return;
    }

    _logger.info(
      'No valid cached token found, starting unauthenticated session',
    );
  }

  /// Processes response and caches token if present
  Future<void> _processResponse(dynamic responseData, String path) async {
    if (responseData is! Map) {
      return;
    }

    final root = _asStringKeyedMap(responseData);
    final dynamic dataCandidate = root['data'];
    final data = dataCandidate is Map
        ? _asStringKeyedMap(dataCandidate)
        : const <String, dynamic>{};

    final accessToken = _findTokenValue(
      <String>[path],
      responseData,
      const [
        'token',
        'accessToken',
        'access_token',
        'jwtToken',
        'jwt_token',
        'bearer',
      ],
    );
    final deviceId = _stringOrNull(
      data['deviceId'] ??
          data['device_id'] ??
          data['device-id'] ??
          data['device_hash'] ??
          data['deviceHash'] ??
          root['deviceId'] ??
          root['device_id'] ??
          root['device-id'] ?? // Fallback variations
          root['device_hash'] ??
          root['deviceHash'],
    );

    if (deviceId != null && deviceId.isNotEmpty) {
      setDefaultHeader(NetworkConstants.deviceIdHeader, deviceId);
      _cacheRepository.put(CacheKeys.deviceId, deviceId).ignore();
    }
    final refreshToken = _findTokenValue(
      <String>[path],
      responseData,
      const ['refreshToken', 'refresh_token'],
    );

    // Only update tokens if they are valid JWTs.
    // We are also more selective: we only update if we are on an auth endpoint
    // OR if the response contains both a token and user data (typical for login/refresh).
    final bool isAuthPath =
        path.contains('/auth/') ||
        path.contains('/login') ||
        path.contains('/register');

    if (accessToken != null && _isJwtToken(accessToken)) {
      if (_isJwtTokenExpired(accessToken)) {
        _logger.warning(
          'Found expired token in response from $path, clearing tokens',
        );
        await clearTokens();
        return;
      }

      final bool isNewToken = accessToken != _accessToken;

      if (isNewToken || isAuthPath) {
        _logger.info(
          'Updating access token from response: $path (isNewToken: $isNewToken, isAuthPath: $isAuthPath)',
        );
        await setAccessToken(accessToken);
        if (refreshToken != null) await setRefreshToken(refreshToken);
      } else {
        _logger.debug(
          'Token in response from $path is identical to current token, skipping update',
        );
      }
    } else if (accessToken != null) {
      // Non-JWT opaque token — _processResponse skips auto-save.
      // The repository's _setTokensIfPresent handles saving it explicitly.
      _logger.info(
        '[_processResponse] Non-JWT token found in $path (len=${accessToken.length}) — skipping auto-save, repository will handle it',
      );
    }

    if (refreshToken != null && (isAuthPath || refreshToken != _refreshToken)) {
      // NOTE: We relaxed the check here to allow non-JWT refresh tokens.
      _logger.info('Updating refresh token from response: $path');
      await setRefreshToken(refreshToken);
    }
  }

  @override
  String? get userId => _userId;

  String? _extractUserIdFromJwt(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final map = jsonDecode(payload) as Map<String, dynamic>;
      return map['sub']?.toString();
    } catch (_) {
      return null;
    }
  }

  String _resolvePath(String path) {
    if (_userId != null) {
      return path.replaceAll('[USER_ID]', _userId!);
    }
    return path;
  }

  /// Basic JWT token validation
  bool _isJwtToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) return false;

    try {
      // Try to decode the header and payload to validate JWT structure
      final header = base64Url.decode(base64Url.normalize(parts[0]));
      final payload = base64Url.decode(base64Url.normalize(parts[1]));

      // Basic validation: check if they contain valid JSON
      json.decode(String.fromCharCodes(header));
      json.decode(String.fromCharCodes(payload));

      return true;
    } catch (e) {
      return false;
    }
  }

  bool _isJwtTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        // Not a JWT — opaque/custom token. Treat as valid; let the backend
        // decide via 401. Returning true here incorrectly clears valid sessions.
        return false;
      }

      final payload = json.decode(
        String.fromCharCodes(base64Url.decode(base64Url.normalize(parts[1]))),
      );

      if (payload is! Map<String, dynamic>) {
        return true;
      }

      final dynamic expValue = payload['exp'];
      if (expValue == null) {
        return false;
      }

      final expirySeconds = expValue is int
          ? expValue
          : int.tryParse(expValue.toString());
      if (expirySeconds == null) {
        return true;
      }

      final expiresAt = DateTime.fromMillisecondsSinceEpoch(
        expirySeconds * 1000,
      );

      // Buffer of 30 seconds to be safe and match RefreshTokenInterceptor
      return DateTime.now().isAfter(
        expiresAt.subtract(const Duration(seconds: 30)),
      );
    } catch (_) {
      return true;
    }
  }

  Map<String, dynamic> _asStringKeyedMap(Map<dynamic, dynamic> source) {
    return source.map((key, value) => MapEntry(key.toString(), value));
  }

  String? _stringOrNull(dynamic value) {
    if (value == null) {
      return null;
    }

    final parsed = value.toString().trim();
    return parsed.isEmpty ? null : parsed;
  }

  /// Converts Dio Headers to Map of String, dynamic
  Map<String, dynamic>? _convertHeaders(Headers? dioHeaders) {
    if (dioHeaders == null) return null;

    final Map<String, dynamic> headerMap = {};
    dioHeaders.forEach((name, values) {
      if (values.isNotEmpty) {
        // If multiple values, keep as list, otherwise use single value
        headerMap[name] = values.length == 1 ? values.first : values;
      }
    });
    return headerMap;
  }

  /// Creates HttpClientResponse from Dio Response
  HttpClientResponse _createResponse(Response<dynamic> response) {
    return HttpClientResponse(
      data: response.data,
      statusCode: response.statusCode ?? 0,
      headers: _convertHeaders(response.headers),
    );
  }

  /// Maps DioException to HttpClientException and throws error response
  Never _handleDioException(DioException e) {
    final errorResponse = HttpClientResponse(
      data: e.response?.data,
      statusCode: e.response?.statusCode ?? 0,
      headers: _convertHeaders(e.response?.headers),
    );

    // Extract error message from backend response
    final errorMessage = extractErrorMessage(errorResponse);

    final HttpClientExceptionCode code;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        code = HttpClientExceptionCode.connectionTimeout;
      case DioExceptionType.sendTimeout:
        code = HttpClientExceptionCode.sendTimeout;
      case DioExceptionType.receiveTimeout:
        code = HttpClientExceptionCode.receiveTimeout;
      case DioExceptionType.badCertificate:
        code = HttpClientExceptionCode.badCertificate;
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          code = HttpClientExceptionCode.unauthorized;
        } else if (statusCode == 403) {
          code = HttpClientExceptionCode.forbidden;
        } else if (statusCode == 404) {
          code = HttpClientExceptionCode.notFound;
        } else if (statusCode != null && statusCode >= 500) {
          code = HttpClientExceptionCode.serverError;
        } else {
          code = HttpClientExceptionCode.badResponse;
        }
      case DioExceptionType.cancel:
        code = HttpClientExceptionCode.cancel;
      case DioExceptionType.connectionError:
        code = HttpClientExceptionCode.connectionError;
      case DioExceptionType.unknown:
        code = HttpClientExceptionCode.networkError;
    }

    final exception = HttpClientException(code: code, message: errorMessage);

    throw HttpClientResponse(
      data: errorResponse.data,
      statusCode: errorResponse.statusCode,
      headers: errorResponse.headers,
      exception: exception,
    );
  }

  @override
  void setDefaultHeaders(Map<String, String> headers) {
    _defaultHeaders.clear();
    _defaultHeaders.addAll(headers);
  }

  @override
  void setDefaultHeader(String key, String value) {
    _defaultHeaders[key] = value;
  }

  @override
  void removeDefaultHeader(String key) {
    _defaultHeaders.remove(key);
  }

  @override
  void clearDefaultHeaders() {
    _defaultHeaders.clear();
  }

  @override
  Map<String, String> getDefaultHeaders() {
    return Map<String, String>.from(_defaultHeaders);
  }

  @override
  String? get accessToken => _accessToken;

  @override
  String? get refreshToken => _refreshToken;

  @override
  bool get isAuthenticated =>
      _accessToken != null && !(_isJwtTokenExpired(_accessToken!));

  @override
  String? get deviceId => _defaultHeaders[NetworkConstants.deviceIdHeader];

  @override
  Future<void> setAccessToken(String token) async {
    _logger.debug('Setting new access token (length: ${token.length})');
    _accessToken = token;
    _userId = _extractUserIdFromJwt(token);

    // We no longer set 'Authorization' in _defaultHeaders or _dio.options.headers.
    // Instead, we rely on the HeaderInterceptor to inject it into every request
    // made via the main _dio instance. This ensures a single source of truth.
    // For custom baseUrl requests, we inject it manually in the request methods.

    await _cacheRepository.put(CacheKeys.accessToken, token);
    final cachedToken = await _cacheRepository.get(CacheKeys.accessToken);
    _logger.info(
      'Access token updated in memory and cache (read-back ok=${cachedToken == token}, token len=${token.length})',
    );
  }

  @override
  Future<void> setRefreshToken(String token) async {
    _refreshToken = token;
    await _cacheRepository.put(CacheKeys.refreshToken, token);
  }

  @override
  Future<void> clearTokens() async {
    _logger.info('Clearing all authentication tokens and session data');
    _accessToken = null;
    _refreshToken = null;
    _userId = null;

    // Clear any potentially lingering Authorization headers
    _defaultHeaders.remove('Authorization');
    _dio.options.headers.remove('Authorization');

    // Perform cache removals in parallel for efficiency
    await Future.wait([
      _cacheRepository.remove(CacheKeys.accessToken),
      _cacheRepository.remove(CacheKeys.refreshToken),
      // Crucial: Clear the user object to prevent SplashPage from attempting
      // authenticated calls with a cleared session.
      _cacheRepository.remove(CacheKeys.user),
    ]);

    _logger.debug('Tokens and user session cleared from memory and cache');
  }

  Future<bool> tryRestoreSession() async {
    if (_accessToken != null && !(_isJwtTokenExpired(_accessToken!))) {
      return true;
    }

    final cachedToken = await _cacheRepository.get(CacheKeys.accessToken);
    if (cachedToken != null && cachedToken.isNotEmpty) {
      if (_isJwtTokenExpired(cachedToken)) {
        await clearTokens();
        return false;
      }

      final cachedRefreshToken = await _cacheRepository.get(
        CacheKeys.refreshToken,
      );

      _accessToken = cachedToken;
      _refreshToken = cachedRefreshToken;
      _userId = _extractUserIdFromJwt(cachedToken);

      return true;
    }
    return false;
  }

  /// Returns the core headers required for every request:
  /// Authorization, Device ID, and Accept-Language.
  Map<String, String> _getCoreHeaders() {
    final headers = <String, String>{'Accept-Language': _languageCode};

    if (_accessToken != null && _accessToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_accessToken';
    }

    final deviceId = _defaultHeaders[NetworkConstants.deviceIdHeader];
    if (deviceId != null && deviceId.isNotEmpty) {
      headers[NetworkConstants.deviceIdHeader] = deviceId;
    }

    _logger.debug(
      'Generated core headers: ${headers.keys.toList()} (Token present: ${_accessToken != null}, token len: ${_accessToken?.length ?? 0})',
    );
    return headers;
  }

  String? _findTokenValue(
    List<String> pathHints,
    dynamic source,
    List<String> candidateKeys,
  ) {
    if (source is Map) {
      final map = _asStringKeyedMap(source);

      for (final key in candidateKeys) {
        final parsed = _stringOrNull(map[key]);
        if (parsed != null) {
          _logger.info(
            'Token discovered from response key "$key" for ${pathHints.join(', ')}',
          );
          return parsed;
        }
      }

      for (final value in map.values) {
        final nested = _findTokenValue(pathHints, value, candidateKeys);
        if (nested != null) {
          return nested;
        }
      }
    } else if (source is List) {
      for (final value in source) {
        final nested = _findTokenValue(pathHints, value, candidateKeys);
        if (nested != null) {
          return nested;
        }
      }
    }

    return null;
  }

  /// Merges default headers with core headers and request-specific headers.
  Map<String, String> _buildMergedHeaders(Map<String, String>? requestHeaders) {
    final merged = Map<String, String>.from(_defaultHeaders);
    merged.addAll(_getCoreHeaders());
    if (requestHeaders != null) {
      merged.addAll(requestHeaders);
    }
    return merged;
  }

  /// Creates a new Dio instance with custom base URL and same configuration
  Dio _createDioInstanceWithBaseUrl(
    String baseUrl,
    Map<String, String>? headers,
  ) {
    final customDio = Dio(BaseOptions(baseUrl: baseUrl, headers: headers));
    return customDio;
  }

  @override
  Future<HttpClientResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? baseUrl,
  }) async {
    try {
      final mergedHeaders = _buildMergedHeaders(headers);

      final Dio dioInstance = baseUrl != null
          ? _createDioInstanceWithBaseUrl(baseUrl, mergedHeaders)
          : _dio;

      final response = await dioInstance.get(
        _resolvePath(path),
        queryParameters: queryParameters,
        options: Options(headers: mergedHeaders),
      );

      // Process response for token caching
      await _processResponse(response.data, path);

      return _createResponse(response);
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<HttpClientResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFormData = false,
    String? baseUrl,
    bool mergeHeaders = true,
  }) async {
    try {
      final requestData = (isFormData && data is Map<String, dynamic>)
          ? FormData.fromMap(data.map((k, v) => MapEntry(k, v ?? '')))
          : data;

      final mergedHeaders = mergeHeaders
          ? _buildMergedHeaders(headers)
          : (headers ?? {});

      final Dio dioInstance = baseUrl != null
          ? _createDioInstanceWithBaseUrl(baseUrl, mergedHeaders)
          : _dio;

      final response = await dioInstance.post(
        _resolvePath(path),
        data: requestData,
        queryParameters: queryParameters,
        options: Options(headers: mergedHeaders),
      );

      // Process response for token caching
      await _processResponse(response.data, path);

      return _createResponse(response);
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<HttpClientResponse> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFormData = false,
  }) async {
    try {
      final requestData = (isFormData && data is Map<String, dynamic>)
          ? FormData.fromMap(data.map((k, v) => MapEntry(k, v ?? '')))
          : data;

      final mergedHeaders = _buildMergedHeaders(headers);

      final response = await _dio.put(
        _resolvePath(path),
        data: requestData,
        queryParameters: queryParameters,
        options: Options(headers: mergedHeaders),
      );

      // Process response for token caching
      await _processResponse(response.data, path);

      return _createResponse(response);
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<HttpClientResponse> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFormData = false,
  }) async {
    try {
      final requestData = (isFormData && data is Map<String, dynamic>)
          ? FormData.fromMap(data.map((k, v) => MapEntry(k, v ?? '')))
          : data;

      final mergedHeaders = _buildMergedHeaders(headers);

      final response = await _dio.delete(
        _resolvePath(path),
        data: requestData,
        queryParameters: queryParameters,
        options: Options(headers: mergedHeaders),
      );

      // Process response for token caching
      await _processResponse(response.data, path);

      return _createResponse(response);
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<HttpClientResponse> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFormData = false,
  }) async {
    try {
      final requestData = (isFormData && data is Map<String, dynamic>)
          ? FormData.fromMap(data.map((k, v) => MapEntry(k, v ?? '')))
          : data;

      final mergedHeaders = _buildMergedHeaders(headers);

      final response = await _dio.patch(
        _resolvePath(path),
        data: requestData,
        queryParameters: queryParameters,
        options: Options(headers: mergedHeaders),
      );

      // Process response for token caching
      await _processResponse(response.data, path);

      return _createResponse(response);
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  @override
  Future<HttpClientResponse> postMultipart(
    String path, {
    Map<String, dynamic>? data,
    Map<String, List<String>>? files,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final formData = FormData();

      // Add regular data fields
      if (data != null) {
        data.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      // Add file fields
      if (files != null) {
        for (final entry in files.entries) {
          final fieldName = entry.key;
          final filePaths = entry.value;

          for (final filePath in filePaths) {
            final file = await MultipartFile.fromFile(
              filePath,
              filename: filePath.split(RegExp(r'[/\\]')).last,
            );
            formData.files.add(MapEntry(fieldName, file));
          }
        }
      }

      final mergedHeaders = _buildMergedHeaders(headers);

      final response = await _dio.post(
        _resolvePath(path),
        data: formData,
        queryParameters: queryParameters,
        options: Options(headers: mergedHeaders),
      );

      // Process response for token caching
      await _processResponse(response.data, path);

      return _createResponse(response);
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  /// Logout method to clear cached tokens
  Future<void> logout() async {
    await _cacheRepository.remove(CacheKeys.accessToken);
    await _cacheRepository.remove(CacheKeys.refreshToken);
    await _cacheRepository.remove(CacheKeys.deviceId);
    await clearTokens();
    removeDefaultHeader(NetworkConstants.deviceIdHeader);
  }

  @override
  /// Extracts error message from HttpClientResponse
  ///
  /// If the response data is a map, it looks for 'message', then 'error'.
  /// This order is preferred because 'message' usually contains more descriptive
  /// user-facing information in the current backend implementation.
  String? extractErrorMessage(HttpClientResponse errorResponse) {
    final data = errorResponse.data;
    if (data is Map<String, dynamic>) {
      // Prefer 'message' as it's typically more descriptive
      final message = _stringOrNull(data['message'] ?? data['error']);
      if (message != null) return message;

      // Check for nested errors (e.g., from validation)
      if (data['errors'] is Map) {
        final errors = data['errors'] as Map;
        if (errors.isNotEmpty) {
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return _stringOrNull(firstError.first);
          }
          return _stringOrNull(firstError);
        }
      }
    }
    return null;
  }
}
