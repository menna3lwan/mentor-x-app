import 'dart:async';
import 'dart:math';

import 'push_notification_message.dart';
import 'push_notification_permission.dart';
import 'push_notification_service.dart';

/// In-memory mock used by every build until the Firebase implementation
/// lands. Behaves like a real provider — emits a stable token on first
/// initialize and surfaces simulated messages on demand.
final class MockPushNotificationService implements PushNotificationService {
  final _tokenController = StreamController<String>.broadcast();
  final _messageController =
      StreamController<PushNotificationMessage>.broadcast();

  PushNotificationPermission _permission =
      PushNotificationPermission.notDetermined;
  String? _token;
  bool _initialized = false;

  /// If non-null, the mock will use this exact token instead of generating
  /// a random one. Lets tests assert on the exact value.
  final String? injectedToken;

  /// Whether the mock should pretend the user already granted permission.
  /// Useful for widget tests that don't want to drive the permission UX.
  final bool initiallyGranted;

  MockPushNotificationService({
    this.injectedToken,
    this.initiallyGranted = false,
  });

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    if (initiallyGranted) {
      _permission = PushNotificationPermission.granted;
      _ensureToken();
    }
  }

  @override
  Future<PushNotificationPermission> getPermissionStatus() async {
    return _permission;
  }

  @override
  Future<PushNotificationPermission> requestPermission() async {
    if (_permission == PushNotificationPermission.permanentlyDenied) {
      return _permission;
    }
    _permission = PushNotificationPermission.granted;
    _ensureToken();
    return _permission;
  }

  @override
  Future<String?> getToken() async {
    if (!_permission.isGranted) return null;
    _ensureToken();
    return _token;
  }

  @override
  Stream<String> get tokens => _tokenController.stream;

  @override
  Stream<PushNotificationMessage> get messages => _messageController.stream;

  @override
  Future<void> unregister() async {
    _token = null;
    if (_permission == PushNotificationPermission.granted) {
      _permission = PushNotificationPermission.denied;
    }
  }

  /// Test/dev hook: simulates an inbound push that the [PushNotificationCubit]
  /// will react to. Production code should never call this.
  void simulateIncoming(PushNotificationMessage message) {
    _messageController.add(message);
  }

  /// Test/dev hook: simulates a provider-side token rotation.
  void simulateTokenRefresh(String newToken) {
    _token = newToken;
    _tokenController.add(newToken);
  }

  void _ensureToken() {
    if (_token != null) return;
    _token = injectedToken ?? _randomToken();
    _tokenController.add(_token!);
  }

  String _randomToken() {
    final rand = Random();
    final bytes = List<int>.generate(24, (_) => rand.nextInt(256));
    return 'mock-fcm-${bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}';
  }

  /// Releases stream subscriptions. Tests and DI containers should call
  /// this on shutdown.
  Future<void> dispose() async {
    await _tokenController.close();
    await _messageController.close();
  }
}
