part of '../../dio_http_client.dart';

/// Interceptor that adds authentication and device identification headers to every request.
///
/// This interceptor pulls the current access token and device ID from the [DioHttpClient]
/// and injects them into the [RequestOptions.headers] map.
final class HeaderInterceptor extends Interceptor {
  final DioHttpClient _httpClient;

  HeaderInterceptor({required DioHttpClient httpClient}) : _httpClient = httpClient;

  static final MentorXLogger _logger = MentorXLogger('HeaderInterceptor');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.debug('Request to: ${options.path}');
    _logger.debug('Headers before injection: ${options.headers.keys.toList()}');

    // Inject core headers (Token, Device ID, Locale)
    final coreHeaders = _httpClient._getCoreHeaders();
    options.headers.addAll(coreHeaders);

    if (coreHeaders.containsKey('Authorization')) {
      final token = coreHeaders['Authorization']!;
      final displayToken = token.length > 15 
          ? '...${token.substring(token.length - 10)}' 
          : '***';
      _logger.info('🔑 Injected Authorization header for: ${options.path} (Token ends with: $displayToken)');
    } else {
      _logger.warning('🚫 No access token found in HttpClient for request: ${options.path}');
      // Also log if we have a device ID but no token, to confirm it's not a complete header failure
      if (coreHeaders.containsKey(NetworkConstants.deviceIdHeader)) {
        _logger.debug('📡 Device ID was found and injected: ${coreHeaders[NetworkConstants.deviceIdHeader]}');
      }
    }

    _logger.debug('Headers after injection: ${options.headers.keys.toList()}');

    return handler.next(options);
  }
}
