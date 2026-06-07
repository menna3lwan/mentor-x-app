import 'push_notification_message.dart';
import 'push_notification_permission.dart';

/// Cross-platform contract for push notifications.
///
/// The parent app talks to this interface only — never directly to FCM,
/// APNs, or any other provider. That lets us:
/// - swap in [MockPushNotificationService] for tests + dev,
/// - swap in `FirebasePushNotificationService` later without touching
///   any UI or bloc,
/// - run the entire push-notification flow in development before any
///   native config is in place.
///
/// Lifecycle:
///   1. App boot: `initialize()`.
///   2. User opts in (Settings toggle or login): `requestPermission()`
///      → if granted, `getToken()` returns a token to register with backend.
///   3. App listens to [tokens] and [messages] for the duration of the
///      authenticated session.
///   4. User logs out / opts out: `unregister()`.
abstract interface class PushNotificationService {
  /// Sets up the underlying provider. Safe to call multiple times — the
  /// implementation must be idempotent.
  Future<void> initialize();

  /// Current permission state, evaluated without prompting the user.
  Future<PushNotificationPermission> getPermissionStatus();

  /// Prompts the user for push notification permission and returns the
  /// resulting state. On platforms / configurations where prompting isn't
  /// possible (web, headless), returns the current status unchanged.
  Future<PushNotificationPermission> requestPermission();

  /// Returns the current FCM / APNs token, or `null` if permission has not
  /// been granted yet or the device hasn't been registered.
  Future<String?> getToken();

  /// Stream of new tokens. Fires once on registration and again whenever
  /// the provider rotates the token. The app should forward each value to
  /// the backend via `NotificationRepository.updateFCMToken`.
  Stream<String> get tokens;

  /// Stream of inbound push messages that arrived while the app was in
  /// the foreground or that opened the app from the background. The UI
  /// layer listens to this stream to show in-app banners and update the
  /// notifications badge counter.
  Stream<PushNotificationMessage> get messages;

  /// Called when the user disables push notifications or logs out.
  /// Implementations should delete the local token and tell the backend
  /// (via the caller) to forget this device.
  Future<void> unregister();
}
