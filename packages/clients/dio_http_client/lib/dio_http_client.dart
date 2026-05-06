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


  DioHttpClient({
    required String baseUrl,
    required CacheRepository cacheRepository,
  }) : _dio = Dio(BaseOptions(baseUrl: baseUrl)),
       _cacheRepository = cacheRepository {
    _registerInterceptors(baseUrl);
    _loadCachedToken();
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
        onTokensUpdated: (token, refreshToken) =>
            setAccessToken(token).then((_) {
              if (refreshToken != null) setRefreshToken(refreshToken);
            }),
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
    final cachedToken = await _cacheRepository.get(CacheKeys.accessToken);
    final cachedRefreshToken = await _cacheRepository.get(
      CacheKeys.refreshToken,
    );
    final cachedDeviceId = await _cacheRepository.get(CacheKeys.deviceId);

    if (cachedDeviceId != null && cachedDeviceId.isNotEmpty) {
      setDefaultHeader('X-Device-Id', cachedDeviceId);
    }

    if (cachedToken != null && cachedToken.isNotEmpty) {
      if (_isJwtTokenExpired(cachedToken)) {
        await clearTokens();
      } else {
        await setAccessToken(cachedToken);
        if (cachedRefreshToken != null) {
          await setRefreshToken(cachedRefreshToken);
        }
      }
      return;
    }

  }

  /// Processes response and caches token if present
  Future<void> _processResponse(dynamic responseData) async {
    if (responseData is! Map) {
      return;
    }

    final root = _asStringKeyedMap(responseData);
    final dynamic dataCandidate = root['data'];
    final data = dataCandidate is Map
        ? _asStringKeyedMap(dataCandidate)
        : const <String, dynamic>{};

    final accessToken = _stringOrNull(
      data['token'] ??
          data['accessToken'] ??
          data['access_token'] ??
          root['token'] ??
          root['accessToken'] ??
          root['access_token'],
    );
    final refreshToken = _stringOrNull(
      data['refreshToken'] ??
          data['refresh_token'] ??
          root['refreshToken'] ??
          root['refresh_token'],
    );
    final deviceId = _stringOrNull(
      data['deviceId'] ??
          data['device_id'] ??
          root['deviceId'] ??
          root['device_id'],
    );

    if (deviceId != null && deviceId.isNotEmpty) {
      setDefaultHeader('X-Device-Id', deviceId);
      _cacheRepository.put(CacheKeys.deviceId, deviceId).ignore();
    }

    if (accessToken != null && _isJwtToken(accessToken)) {
      if (_isJwtTokenExpired(accessToken)) {
        clearTokens();
        return;
      }
      setAccessToken(accessToken);
      if (refreshToken != null) setRefreshToken(refreshToken);
      return;
    }

    if (refreshToken != null) {
      _cacheRepository.put(CacheKeys.refreshToken, refreshToken).ignore();
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
        return true;
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

      return DateTime.now().isAfter(expiresAt);
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
  bool get isAuthenticated => _accessToken != null && !(_isJwtTokenExpired(_accessToken!));

  @override
  Future<void> setAccessToken(String token) async {
    _accessToken = token;
    _userId = _extractUserIdFromJwt(token);
    _dio.options.headers['Authorization'] = 'Bearer $token';
    _defaultHeaders['Authorization'] = 'Bearer $token';
    await _cacheRepository.put(CacheKeys.accessToken, token);
  }

  @override
  Future<void> setRefreshToken(String token) async {
    _refreshToken = token;
    await _cacheRepository.put(CacheKeys.refreshToken, token);
  }

  @override
  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    _userId = null;
    _dio.options.headers.remove('Authorization');
    _defaultHeaders.remove('Authorization');
    await _cacheRepository.remove(CacheKeys.accessToken);
    await _cacheRepository.remove(CacheKeys.refreshToken);
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
      _dio.options.headers['Authorization'] = 'Bearer $cachedToken';
      _defaultHeaders['Authorization'] = 'Bearer $cachedToken';
      
      return true;
    }
    return false;
  }

  /// Creates a new Dio instance with custom base URL and same configuration
  Dio _createDioInstanceWithBaseUrl(
    String baseUrl,
    Map<String, String>? headers,
  ) {
    final customDio = Dio(BaseOptions(baseUrl: baseUrl, headers: headers));
    return customDio;
  }

  /// Merges default headers with request-specific headers
  /// Request-specific headers take precedence over default headers
  Map<String, String> _mergeHeaders(Map<String, String>? requestHeaders) {
    final mergedHeaders = Map<String, String>.from(_defaultHeaders);
    if (requestHeaders != null) {
      mergedHeaders.addAll(requestHeaders);
    }
    return mergedHeaders;
  }

  @override
  Future<HttpClientResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? baseUrl,
  }) async {
    try {
      final Dio dioInstance = baseUrl != null
          ? _createDioInstanceWithBaseUrl(baseUrl, headers)
          : _dio;

      final response = await dioInstance.get(
        _resolvePath(path),
        queryParameters: queryParameters,
        options: Options(headers: _mergeHeaders(headers)),
      );

      // Process response for token caching
      await _processResponse(response.data);

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

      final Dio dioInstance = baseUrl != null
          ? _createDioInstanceWithBaseUrl(baseUrl, headers)
          : _dio;

      final response = await dioInstance.post(
        _resolvePath(path),
        data: requestData,
        queryParameters: queryParameters,
        options: Options(
          headers: mergeHeaders ? _mergeHeaders(headers) : headers,
        ),
      );

      // Process response for token caching
      await _processResponse(response.data);

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

      final response = await _dio.put(
        _resolvePath(path),
        data: requestData,
        queryParameters: queryParameters,
        options: Options(headers: _mergeHeaders(headers)),
      );

      // Process response for token caching
      await _processResponse(response.data);

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

      final response = await _dio.delete(
        _resolvePath(path),
        data: requestData,
        queryParameters: queryParameters,
        options: Options(headers: _mergeHeaders(headers)),
      );

      // Process response for token caching
      await _processResponse(response.data);

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

      final response = await _dio.patch(
        _resolvePath(path),
        data: requestData,
        queryParameters: queryParameters,
        options: Options(headers: _mergeHeaders(headers)),
      );

      // Process response for token caching
      await _processResponse(response.data);

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

      final response = await _dio.post(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: Options(headers: _mergeHeaders(headers)),
      );

      // Process response for token caching
      await _processResponse(response.data);

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
    removeDefaultHeader('X-Device-Id');
  }

  @override
  /// Extracts error message from HttpClientResponse
  ///
  /// If the response data is a map with 'error' or 'message' key, it returns the value of that key.
  /// If the response data is not a map, it returns null.
  String? extractErrorMessage(HttpClientResponse errorResponse) {
    final data = errorResponse.data;
    if (data is Map<String, dynamic>) return data['error'] ?? data['message'];
    return null;
  }
}
