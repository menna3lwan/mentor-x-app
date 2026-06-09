import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'push_notification_service.dart';

/// Firebase Cloud Messaging implementation of [PushNotificationService].
///
/// Wraps [FirebaseMessaging] with the app's abstraction layer so the cubit
/// and the rest of the app remain decoupled from the Firebase SDK.
///
/// Prerequisites (must be completed before shipping):
/// 1. `google-services.json` placed at `android/app/google-services.json`
/// 2. `GoogleService-Info.plist` placed at `ios/Runner/GoogleService-Info.plist`
/// 3. `firebase_options.dart` populated via `flutterfire configure`
/// 4. `Firebase.initializeApp()` called in `main()` before this service is
///    constructed.
final class FirebasePushNotificationService implements PushNotificationService {
  final FirebaseMessaging _messaging;

  final _tokensController = StreamController<String>.broadcast();
  final _messagesController =
      StreamController<PushNotificationMessage>.broadcast();

  FirebasePushNotificationService({FirebaseMessaging? messaging})
    : _messaging = messaging ?? FirebaseMessaging.instance;

  @override
  Future<void> initialize() async {
    // Opt out of automatic data-message delivery on iOS so we control
    // exactly when the message stream emits.
    await _messaging.setAutoInitEnabled(true);

    // Wire token rotation into our broadcast stream.
    FirebaseMessaging.instance.onTokenRefresh.listen(
      _tokensController.add,
      onError: _tokensController.addError,
    );

    // Wire foreground messages into our broadcast stream.
    FirebaseMessaging.onMessage.listen((message) {
      _messagesController.add(_fromRemoteMessage(message));
    });
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _messaging.getToken();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<PushNotificationPermission> getPermissionStatus() async {
    final settings = await _messaging.getNotificationSettings();
    return _mapAuthorizationStatus(settings.authorizationStatus);
  }

  @override
  Future<PushNotificationPermission> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    return _mapAuthorizationStatus(settings.authorizationStatus);
  }

  @override
  Future<void> unregister() async {
    await _messaging.deleteToken();
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
  }

  @override
  Stream<String> get tokens => _tokensController.stream;

  @override
  Stream<PushNotificationMessage> get messages => _messagesController.stream;

  // ─────────────────────────── Helpers ────────────────────────────────────

  PushNotificationPermission _mapAuthorizationStatus(
    AuthorizationStatus status,
  ) {
    return switch (status) {
      AuthorizationStatus.authorized => PushNotificationPermission.granted,
      AuthorizationStatus.provisional => PushNotificationPermission.granted,
      AuthorizationStatus.denied => PushNotificationPermission.denied,
      AuthorizationStatus.notDetermined =>
        PushNotificationPermission.notDetermined,
    };
  }

  PushNotificationMessage _fromRemoteMessage(RemoteMessage message) {
    return PushNotificationMessage(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      data: message.data,
      receivedAt: DateTime.now(),
    );
  }
}
