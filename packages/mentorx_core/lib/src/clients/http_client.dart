part of 'package:mentorx_core/mentorx_core.dart';

/// A client that supports locale updates when the app language changes.
abstract interface class LocalizedClient {
  /// Called by the locale cubit when the user changes language.
  void setLocale(String languageCode);
}

enum HttpClientExceptionCode {
  unknown,
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  badCertificate,
  badResponse,
  cancel,
  connectionError,
  networkError,
  unauthorized,
  forbidden,
  notFound,
  serverError,
}

final class HttpClientException
    extends MentorXException<HttpClientExceptionCode> {
  HttpClientException({required super.code, super.message});
}

final class HttpClientResponse {
  final dynamic data;
  final int statusCode;
  final Map<String, dynamic>? headers;
  final HttpClientException? exception;

  bool get isOk => statusCode >= 200 && statusCode < 300;

  const HttpClientResponse({
    this.headers,
    this.exception,
    required this.data,
    required this.statusCode,
  });

  /// Converts data to `Map<String, dynamic>` safely
  Map<String, dynamic> asMap() {
    final value = data;
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }

  /// Converts data to `List<dynamic>` safely
  /// Prioritizes 'data' or 'items' keys if value is a Map
  List<dynamic> asList() {
    final value = data;
    if (value is List<dynamic>) return value;
    if (value is Map) {
      final d = value['data'] ?? value['items'] ?? value['content'];
      if (d is List<dynamic>) return d;
    }
    return <dynamic>[];
  }

  /// Safe cast to String or null from data Map
  String? stringOrNull(String key) => asMap()[key]?.toString();

  /// Safe cast to int or null from data Map
  int? intOrNull(String key) {
    final value = asMap()[key];
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  /// Safe cast to bool or null from data Map
  bool? boolOrNull(String key) {
    final value = asMap()[key];
    if (value == null) return null;
    if (value is bool) return value;
    if (value is String) {
      final v = value.toLowerCase();
      if (v == 'true' || v == '1') return true;
      if (v == 'false' || v == '0') return false;
    }
    return null;
  }
}

abstract interface class HttpClient extends LocalizedClient {
  /// Returns the current authenticated user ID if available
  String? get userId;

  /// Returns the current access token if available
  String? get accessToken;

  /// Returns the current refresh token if available
  String? get refreshToken;

  /// Checks if the client is authenticated (has a valid access token)
  bool get isAuthenticated;

  /// Sets default headers that will be included in all requests
  void setDefaultHeaders(Map<String, String> headers);

  /// Adds a single default header
  void setDefaultHeader(String key, String value);

  /// Removes a default header
  void removeDefaultHeader(String key);

  /// Clears all default headers
  void clearDefaultHeaders();

  /// Gets current default headers
  Map<String, String> getDefaultHeaders();

  /// Sets the access token for authentication
  Future<void> setAccessToken(String token);

  /// Sets the refresh token for authentication
  Future<void> setRefreshToken(String token);

  /// Clears all authentication tokens
  Future<void> clearTokens();

  /// Initializes the client (e.g., loads cached tokens)
  Future<void> initialize();

  Future<HttpClientResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? baseUrl,
  });

  Future<HttpClientResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFormData = false,
    String? baseUrl,
    bool mergeHeaders = true,
  });

  Future<HttpClientResponse> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFormData = false,
  });

  Future<HttpClientResponse> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFormData = false,
  });

  Future<HttpClientResponse> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFormData = false,
  });

  /// Uploads files using multipart form data
  Future<HttpClientResponse> postMultipart(
    String path, {
    Map<String, dynamic>? data,
    Map<String, List<String>>? files, // Map of field names to file paths
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  String? extractErrorMessage(HttpClientResponse errorResponse);
}

