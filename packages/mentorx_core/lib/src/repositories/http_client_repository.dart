part of 'package:mentorx_core/mentorx_core.dart';

/// A base class for repositories that use [HttpClient].
/// 
/// It provides centralized error handling through [handleHttpClientErrorResponse]
/// and common data parsing utilities through [DataParsingMixin].
abstract class HttpClientRepository<T extends Enum> with DataParsingMixin {
  const HttpClientRepository();

  /// Throws a domain-specific exception for the given [code].
  Never throwException(T code, {String? message});

  /// Handles HTTP client error responses and maps them to domain-specific exceptions.
  ///
  /// [errorResponse] contains the HttpClientResponse with the error details.
  /// [codeFromStatusCode] is an optional function to map HTTP status codes to domain codes.
  /// [defaultCode] is the code to use if mapping is not provided or fails.
  Never handleHttpClientErrorResponse(
    HttpClientResponse errorResponse, {
    T Function(int statusCode)? codeFromStatusCode,
    T? defaultCode,
    String? message,
  }) {
    final statusCode = errorResponse.statusCode;
    final code = codeFromStatusCode?.call(statusCode) ?? defaultCode;

    if (code == null) {
      throw StateError(
        'Either defaultCode or codeFromStatusCode mapping must be provided',
      );
    }

    final errorMessage = message ?? errorResponse.exception?.message;

    throwException(code, message: errorMessage);
  }
}
