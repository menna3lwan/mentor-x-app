import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mentorx_core/mentorx_core.dart';

final class DioHttpClient implements HttpClient {
  final Dio _dio;
  final CacheRepository _cacheRepository;
  final Map<String, String> _defaultHeaders = {};

  DioHttpClient({
    required String baseUrl,
    required CacheRepository cacheRepository,
  }) : _dio = Dio(BaseOptions(baseUrl: baseUrl)),
       _cacheRepository = cacheRepository {
    _loadCachedToken();
  }

  /// Loads cached token and sets it as bearer token
  /// Only loads the token if it's still valid (not expired)
  Future<void> _loadCachedToken() async {
    final cachedToken = await _cacheRepository.get(CacheKeys.accessToken);
    if (cachedToken != null && cachedToken.isNotEmpty) {
      setBearerToken(cachedToken);
    }
  }

  /// Processes response and caches token if present
  Future<void> _processResponse(dynamic responseData) async {
    if (responseData is Map<String, dynamic>) {
      final accessToken = responseData['accessToken'];
      if (accessToken != null &&
          accessToken is String &&
          accessToken.isNotEmpty) {
        // Check if it's a JWT token (basic validation)
        if (_isJwtToken(accessToken)) {
          _cacheRepository.put(CacheKeys.accessToken, accessToken).ignore();
          setBearerToken(accessToken);
        }
      }
    }
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
  void setBearerToken(String token, {String? refreshToken}) async {
    _defaultHeaders['Authorization'] = 'Bearer $token';
  }

  @override
  void removeBearerToken() {
    _defaultHeaders.remove('Authorization');
  }

  @override
  String? getBearerToken() {
    final authHeader = _defaultHeaders['Authorization'];
    if (authHeader != null && authHeader.startsWith('Bearer ')) {
      return authHeader.substring(7); // Remove 'Bearer ' prefix
    }
    return null;
  }

  @override
  Future<bool> isAuthenticated() async {
    // Check if there's a token in memory first
    final memoryToken = getBearerToken();
    if (memoryToken != null && memoryToken.isNotEmpty) {
      return true;
    }
    // Check cached token
    final cachedToken = await _cacheRepository.get(CacheKeys.accessToken);
    if (cachedToken != null && cachedToken.isNotEmpty) {
      setBearerToken(cachedToken);
      return true;
    }

    return false;
  }

  /// Creates a new Dio instance with custom base URL and same configuration
  Dio _createDioInstanceWithBaseUrl(
    String baseUrl,
    Map<String, String>? headers,
  ) {
    print(headers);
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
        path,
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
        path,
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
        path,
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
        path,
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
        path,
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
    removeBearerToken();
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
