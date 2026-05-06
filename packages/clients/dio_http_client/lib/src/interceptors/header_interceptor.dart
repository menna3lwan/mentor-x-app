part of '../../dio_http_client.dart';

/// Interceptor that adds authentication and device identification headers to every request.
///
/// This interceptor pulls the current access token and device ID from the [DioHttpClient]
/// and injects them into the [RequestOptions.headers] map.
final class HeaderInterceptor extends Interceptor {
  final DioHttpClient _httpClient;

  HeaderInterceptor({required DioHttpClient httpClient}) : _httpClient = httpClient;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 1. Add Authorization header if token exists
    final token = _httpClient.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // 2. Add Device ID header if exists in default headers
    final deviceId = _httpClient.getDefaultHeaders()['X-Device-Id'];
    if (deviceId != null && deviceId.isNotEmpty) {
      options.headers['X-Device-Id'] = deviceId;
    }

    // 3. Ensure Accept-Language is set
    options.headers['Accept-Language'] = _httpClient.languageCode;

    return handler.next(options);
  }
}
