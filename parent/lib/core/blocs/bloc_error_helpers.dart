import 'package:mentorx_core/mentorx_core.dart';

/// Shared utility helpers for translating low-level transport errors into
/// user-facing strings and typed kind enums.
///
/// Every parent Bloc previously inlined identical copies of `_describe` and
/// `_maybeEmitUnauthorized`-style helpers; centralising them here avoids
/// drift and gives a single place to tweak the wording of "Request failed
/// (500)" or how 401 vs 403 are surfaced.
extension BlocErrorDescribe on Object {
  /// Best-effort, non-localised string description of a thrown error.
  ///
  /// Prefers the typed [MentorXException.message]; falls back to the HTTP
  /// status code embedded in [HttpClientResponse]; finally collapses to
  /// `toString()` for unexpected types.
  String describeError() {
    final error = this;
    if (error is MentorXException) {
      return error.message ?? error.toString();
    }
    if (error is HttpClientResponse) {
      return error.exception?.message ?? 'Request failed (${error.statusCode})';
    }
    return error.toString();
  }
}

/// Generic "is this an auth failure" classifier used by every dashboard
/// Bloc to decide whether to bounce the user back to login.
bool isUnauthorizedError(Object error) {
  if (error is HttpClientResponse) {
    return error.statusCode == 401 || error.statusCode == 403;
  }
  if (error is AuthenticationException) {
    return error.code == AuthenticationExceptionCode.sessionExpired;
  }
  // Catch domain exceptions whose repo mapped 401/403 → unauthorized code.
  if (error is MentorXException) {
    return error.code.name == 'unauthorized';
  }
  return false;
}

/// Tri-state classification useful for "show empty / show toast / redirect"
/// decisions without each Bloc having to switch on raw status codes.
enum GenericFailureKind {
  unknown,
  network,
  notFound,
  unauthorized,
}

GenericFailureKind classifyHttpFailure(Object error) {
  if (error is HttpClientResponse) {
    return switch (error.statusCode) {
      401 || 403 => GenericFailureKind.unauthorized,
      404 => GenericFailureKind.notFound,
      _ => GenericFailureKind.unknown,
    };
  }
  // Detect domain exceptions whose enum code signals an auth or not-found
  // failure — this covers repos that map HTTP status → typed enum before
  // the error reaches the BLoC layer.
  if (error is MentorXException) {
    final name = error.code.name;
    if (name == 'unauthorized') return GenericFailureKind.unauthorized;
    if (name == 'notFound' || name == 'courseNotFound') {
      return GenericFailureKind.notFound;
    }
    return GenericFailureKind.unknown;
  }
  return GenericFailureKind.unknown;
}
