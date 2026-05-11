import 'package:sentry_flutter/sentry_flutter.dart';
import 'error_tracking_service.dart';

class SentryErrorTrackingService implements ErrorTrackingService {
  @override
  Future<void> initialize() async {
    // Sentry is typically initialized in main() using SentryFlutter.init
    // This method can be used for any post-initialization setup if needed.
  }

  @override
  Future<void> captureException(
    dynamic exception, {
    StackTrace? stackTrace,
    dynamic hint,
  }) async {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      hint: hint,
    );
  }

  @override
  Future<void> captureMessage(
    String message, {
    dynamic hint,
  }) async {
    await Sentry.captureMessage(
      message,
      hint: hint,
    );
  }

  @override
  void addBreadcrumb(
    String message, {
    String? category,
    Map<String, dynamic>? data,
  }) {
    Sentry.addBreadcrumb(
      Breadcrumb(
        message: message,
        category: category,
        data: data,
      ),
    );
  }

  @override
  void setUserId(String? userId) {
    Sentry.configureScope((scope) {
      scope.setUser(userId != null ? SentryUser(id: userId) : null);
    });
  }

  @override
  void setUser({
    String? id,
    String? username,
    String? email,
    String? ipAddress,
    Map<String, dynamic>? extras,
  }) {
    Sentry.configureScope((scope) {
      scope.setUser(
        SentryUser(
          id: id,
          username: username,
          email: email,
          ipAddress: ipAddress,
          extras: extras,
        ),
      );
    });
  }

  @override
  void clearUser() {
    Sentry.configureScope((scope) {
      scope.setUser(null);
    });
  }

  @override
  void setTag(String key, String value) {
    Sentry.configureScope((scope) {
      scope.setTag(key, value);
    });
  }

  @override
  void setExtra(String key, dynamic value) {
    Sentry.configureScope((scope) {
      scope.setExtra(key, value);
    });
  }
}
