import 'package:sentry_flutter/sentry_flutter.dart';
import 'error_tracking_service.dart';

class SentryErrorTrackingService implements ErrorTrackingService {
  @override
  Future<void> initialize() async {
    // Sentry is typically initialized in main() using SentryFlutter.init
    // This method can be used for any post-initialization setup if needed.
  }

  Hint? _toSentryHint(dynamic hint) {
    if (hint == null) return null;
    if (hint is Hint) return hint;
    if (hint is Map<String, dynamic>) {
      return Hint.withMap(hint);
    }
    return Hint.withMap({'message': hint});
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
      hint: _toSentryHint(hint),
    );
  }

  @override
  Future<void> captureMessage(
    String message, {
    dynamic hint,
  }) async {
    await Sentry.captureMessage(
      message,
      hint: _toSentryHint(hint),
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
