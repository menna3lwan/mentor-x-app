part of '../mentorx_core.dart';

abstract class HttpClientRepository<T> {
  /// Handles HTTP client error responses and maps them to domain-specific exceptions
  ///
  /// Takes an [exceptionCode] of type [T] that represents the domain-specific error code,
  /// and an [errorResponse] containing the HttpClientException with the error details.
  ///
  /// Throws an [EventiException<T>] with the provided code and the message from the
  /// HttpClientException if available.
  Never handleHttpClientErrorResponse(
    T exceptionCode,
    HttpClientResponse errorResponse,
  ) {
    final httpException = errorResponse.exception;
    final errorMessage = httpException?.message;

    throw MentorXException(
      code: exceptionCode,
      message: errorMessage,
    );
  }
}
