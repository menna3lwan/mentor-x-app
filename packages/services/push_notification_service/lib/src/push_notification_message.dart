import 'package:equatable/equatable.dart';

/// A push notification that has arrived while the app is in the foreground
/// (or that the user just tapped to open the app). The payload is generic
/// `Map<String, dynamic>` to match what FCM / APNs hand to the app.
class PushNotificationMessage extends Equatable {
  /// Stable identifier from the provider (e.g. FCM messageId).
  final String id;
  final String title;
  final String body;

  /// Arbitrary key-value pairs the backend attached. Used by the routing
  /// layer to decide where to navigate when the user taps the banner.
  final Map<String, dynamic> data;
  final DateTime receivedAt;

  const PushNotificationMessage({
    required this.id,
    required this.title,
    required this.body,
    required this.data,
    required this.receivedAt,
  });

  /// Returns the value at [data]['action'] if present, otherwise null.
  /// Convention used across the parent app: every actionable payload sets
  /// `action` to a deeplink-like string (e.g. `/notifications/123`).
  String? get actionPath {
    final action = data['action'];
    if (action is String && action.isNotEmpty) return action;
    return null;
  }

  @override
  List<Object?> get props => [id, title, body, data, receivedAt];
}
