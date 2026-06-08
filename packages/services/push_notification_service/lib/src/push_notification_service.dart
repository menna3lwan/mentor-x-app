import 'dart:async';

// ─────────────────────────────────────────────────────────────────────────────
// Value types
// ─────────────────────────────────────────────────────────────────────────────

/// Whether the user has granted permission for push notifications.
enum PushNotificationPermission {
  /// The app has not yet asked the user.
  notDetermined,

  /// The user granted permission.
  granted,

  /// The user denied permission (can still be changed in device settings).
  denied,

  /// The user permanently denied (on Android, also covers "don't ask again").
  permanentlyDenied;

  /// Convenience getter — `true` when the app is allowed to show notifications.
  bool get isGranted => this == PushNotificationPermission.granted;
}

/// A lightweight envelope for an incoming push notification message.
///
/// Only the fields that the parent-app UI actually uses are surfaced here.
/// Implementations may carry a richer platform-specific payload internally.
class PushNotificationMessage {
  /// Notification title. Empty string for data-only messages.
  final String title;

  /// Notification body text. Empty string for data-only messages.
  final String body;

  /// Arbitrary key/value data payload.
  final Map<String, dynamic> data;

  /// When the message was received locally (defaults to [DateTime.now]).
  final DateTime receivedAt;

  const PushNotificationMessage({
    this.title = '',
    this.body = '',
    this.data = const {},
    required this.receivedAt,
  });

  factory PushNotificationMessage.fromMap(Map<String, dynamic> map) {
    final notification = map['notification'] as Map<String, dynamic>?;
    return PushNotificationMessage(
      title: (notification?['title'] as String?) ?? '',
      body: (notification?['body'] as String?) ?? '',
      data: (map['data'] as Map<String, dynamic>?) ?? {},
      receivedAt: DateTime.now(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Abstract interface
// ─────────────────────────────────────────────────────────────────────────────

/// Abstract interface for push notification handling.
///
/// Concrete implementations (e.g. Firebase FCM) or a
/// [MockPushNotificationService] can be injected via the repository layer.
abstract interface class PushNotificationService {
  /// Initialises the service (registers channels, loads cached token, etc.).
  Future<void> initialize();

  /// Returns the current device registration token, or `null` if the service
  /// is not ready or permissions have been denied.
  Future<String?> getToken();

  /// Returns the current permission state without requesting it.
  Future<PushNotificationPermission> getPermissionStatus();

  /// Requests push-notification permission from the OS.
  ///
  /// On iOS this shows the system prompt the first time. On Android 13+ it
  /// also shows a runtime-permission prompt. Subsequent calls simply return
  /// the current status without prompting again.
  Future<PushNotificationPermission> requestPermission();

  /// Unregisters the device from push notifications (clears the token from
  /// the local cache and notifies the backend if applicable).
  Future<void> unregister();

  /// Subscribe to a named topic (e.g. `announcements`).
  Future<void> subscribeToTopic(String topic);

  /// Unsubscribe from a previously subscribed topic.
  Future<void> unsubscribeFromTopic(String topic);

  /// Stream of FCM token rotations. Emit a new string whenever the underlying
  /// provider hands us a fresh token (token refresh, reinstall, etc.).
  Stream<String> get tokens;

  /// Stream of inbound push messages received while the app is in the
  /// foreground.
  Stream<PushNotificationMessage> get messages;
}

// ─────────────────────────────────────────────────────────────────────────────
// Mock implementation
// ─────────────────────────────────────────────────────────────────────────────

/// No-op mock that satisfies the [PushNotificationService] contract for
/// development / testing without a real Firebase project.
final class MockPushNotificationService implements PushNotificationService {
  MockPushNotificationService();

  final _tokensController = StreamController<String>.broadcast();
  final _messagesController =
      StreamController<PushNotificationMessage>.broadcast();

  String? _token;
  PushNotificationPermission _permission =
      PushNotificationPermission.notDetermined;

  @override
  Future<void> initialize() async {
    _token = 'mock-fcm-token-000000';
    // Simulate the token arriving immediately after init.
    _tokensController.add(_token!);
  }

  @override
  Future<String?> getToken() async => _token;

  @override
  Future<PushNotificationPermission> getPermissionStatus() async =>
      _permission;

  @override
  Future<PushNotificationPermission> requestPermission() async {
    _permission = PushNotificationPermission.granted;
    return _permission;
  }

  @override
  Future<void> unregister() async {
    _token = null;
  }

  @override
  Future<void> subscribeToTopic(String topic) async {}

  @override
  Future<void> unsubscribeFromTopic(String topic) async {}

  @override
  Stream<String> get tokens => _tokensController.stream;

  @override
  Stream<PushNotificationMessage> get messages => _messagesController.stream;

  /// Injects a fake incoming message — useful in tests and dev menus.
  void simulateMessage(PushNotificationMessage message) {
    _messagesController.add(message);
  }

  /// Closes the broadcast streams. Call in test [tearDown] if needed.
  Future<void> dispose() async {
    await _tokensController.close();
    await _messagesController.close();
  }
}
