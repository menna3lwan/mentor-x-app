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

    // Proactively remove any legacy or variant device ID headers to ensure consistency
    // and prevent duplicate headers (e.g. device-id vs X-Device-Id)
    final variants = ['device-id', 'device_id', 'deviceId', 'x-device-id'];
    for (final variant in variants) {
      if (variant != NetworkConstants.deviceIdHeader) {
        options.headers.remove(variant);
      }
    }

    // Safely add core headers without overwriting explicitly provided Authorization
    coreHeaders.forEach((key, value) {
      if (key == 'Authorization') {
        if (!options.headers.containsKey('Authorization')) {
          options.headers[key] = value;
        } else {
          _logger.debug('Skipping Authorization header injection; already present in request options.');
        }
      } else {
        options.headers[key] = value;
      }
    });

    if (coreHeaders.containsKey('Authorization')) {
      final token = coreHeaders['Authorization']!;
      final displayToken = token.length > 15 
          ? '...${token.substring(token.length - 10)}' 
          : '***';
      _logger.info('🔑 Injected Authorization header for: ${options.path} (Token ends with: $displayToken)');
    } else {
      // Check if the client is authenticated at all
      if (!_httpClient.isAuthenticated) {
        _logger.warning('🚫 HttpClient.isAuthenticated is false. No token injected for: ${options.path}');
      } else {
        _logger.error('❌ CRITICAL: HttpClient is authenticated but _getCoreHeaders() returned no Authorization header for: ${options.path}');
      }
      
      // Also log if we have a device ID but no token, to confirm it's not a complete header failure
      if (coreHeaders.containsKey(NetworkConstants.deviceIdHeader)) {
        _logger.debug('📡 Device ID was successfully injected: ${coreHeaders[NetworkConstants.deviceIdHeader]}');
      }
    }

    _logger.debug('Headers after injection: ${options.headers.keys.toList()}');

    return handler.next(options);
  }
}
