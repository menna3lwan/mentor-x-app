part of '../mentorx_core.dart';

class HttpClientResponse {
  final dynamic data;
  final int statusCode;
  final Map<String, dynamic>? headers;

  bool get isOk => statusCode >= 200 && statusCode < 300;

  const HttpClientResponse({
    this.headers,
    required this.data,
    required this.statusCode,
  });
}

abstract class HttpClient {
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

  /// Sets the bearer token for authentication
  /// This will automatically add/update the Authorization header
  void setBearerToken(String token);

  /// Removes the bearer token
  void removeBearerToken();

  /// Gets the current bearer token (without 'Bearer ' prefix)
  String? getBearerToken();

  /// Checks if the client is authenticated (has a valid token)
  Future<bool> isAuthenticated();

  Future<HttpClientResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  Future<HttpClientResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isFormData = false,
  });

  Future<HttpClientResponse> put(
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
}
