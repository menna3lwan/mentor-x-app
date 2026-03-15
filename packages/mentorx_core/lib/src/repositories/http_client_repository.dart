part of '../../mentorx_core.dart';

abstract class HttpClientRepository<T extends Enum> {
  const HttpClientRepository();

  Never throwException(T code, {String? message});

  /// Handles HTTP client error responses and maps them to domain-specific exceptions
  ///
  /// Takes an [exceptionCode] of type [T] that represents the domain-specific error code,
  /// and an [errorResponse] containing the HttpClientException with the error details.
  Never handleHttpClientErrorResponse(
    T exceptionCode,
    HttpClientResponse errorResponse,
  ) {
    final httpException = errorResponse.exception;
    final errorMessage = httpException?.message;

    throwException(exceptionCode, message: errorMessage);
  }
}
