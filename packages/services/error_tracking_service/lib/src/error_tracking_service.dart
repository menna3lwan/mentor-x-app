abstract interface class ErrorTrackingService {
  /// Initializes the error tracking service.
  Future<void> initialize();

  /// Captures an exception with an optional stack trace and hint.
  Future<void> captureException(
    dynamic exception, {
    StackTrace? stackTrace,
    dynamic hint,
  });

  /// Captures a message with an optional level and hint.
  Future<void> captureMessage(
    String message, {
    dynamic hint,
  });

  /// Adds a breadcrumb to the current scope.
  void addBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? data,
  });

  /// Sets the user identifier for the current scope.
  void setUserId(String? userId);

  /// Sets the user information for the current scope.
  void setUser({
    String? id,
    String? username,
    String? email,
    String? ipAddress,
    Map<String, dynamic>? extras,
  });

  /// Clears the current user.
  void clearUser();

  /// Sets a tag for the current scope.
  void setTag(String key, String value);

  /// Sets extra information for the current scope.
  void setExtra(String key, dynamic value);
}
