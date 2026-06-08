import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:push_notification_service/push_notification_service.dart';

part 'push_notifications_state.dart';

/// Owns the lifecycle of [PushNotificationService] inside the parent app.
///
/// Responsibilities:
/// - Track current permission state.
/// - Forward new tokens to the backend via [NotificationRepository.updateFCMToken].
/// - Pipe inbound messages onto [messages] so UI listeners (banner + badge)
///   can react.
/// - React to login / logout / settings-toggle events from the rest of the
///   app via [enable] / [disable] / [refreshToken].
final class PushNotificationsCubit extends Cubit<PushNotificationsState> {
  final PushNotificationService _service;
  final NotificationRepository _notificationRepository;
  static final MentorXLogger _logger = MentorXLogger('PushNotificationsCubit');

  StreamSubscription<String>? _tokensSub;
  StreamSubscription<PushNotificationMessage>? _messagesSub;

  /// Re-broadcast of messages from the underlying service. Lets multiple
  /// listeners (banner widget + badge cubit) subscribe simultaneously
  /// without competing for the single underlying subscription.
  final _messagesController =
      StreamController<PushNotificationMessage>.broadcast();

  Stream<PushNotificationMessage> get messages => _messagesController.stream;

  PushNotificationsCubit({
    required PushNotificationService service,
    required NotificationRepository notificationRepository,
  }) : _service = service,
       _notificationRepository = notificationRepository,
       super(PushNotificationsState.initial());

  /// Wires up the service on app boot. Idempotent.
  Future<void> bootstrap() async {
    if (state.isBootstrapped) return;
    try {
      await _service.initialize();
      final permission = await _service.getPermissionStatus();
      emit(
        state.copyWith(
          permission: permission,
          isBootstrapped: true,
        ),
      );
      _attachStreams();
      if (permission.isGranted) {
        final token = await _service.getToken();
        if (token != null) {
          emit(state.copyWith(token: token));
          await _registerWithBackend(token);
        }
      }
    } catch (e, s) {
      _logger.error('Push bootstrap failed: $e', e, s);
      emit(state.copyWith(isBootstrapped: true));
    }
  }

  /// Called when the user flips Settings → push toggle to ON, or after a
  /// successful login. Returns the resulting permission state so the UI
  /// can react (e.g. show a "go to settings" hint on permanent denial).
  Future<PushNotificationPermission> enable() async {
    final permission = await _service.requestPermission();
    emit(state.copyWith(permission: permission));
    if (!permission.isGranted) {
      return permission;
    }
    _attachStreams();
    final token = await _service.getToken();
    if (token != null) {
      emit(state.copyWith(token: token));
      await _registerWithBackend(token);
    }
    return permission;
  }

  /// Called when the user flips Settings → push toggle to OFF, or on
  /// logout. Tells the service to forget the device and stops streaming
  /// further messages until [enable] is called again.
  Future<void> disable() async {
    await _service.unregister();
    emit(state.copyWith(token: null));
    // We intentionally do NOT cancel the stream subscriptions: an
    // immediate re-`enable` should still work without re-attaching them.
  }

  /// Re-fetches the token from the provider and forwards to backend. Use
  /// when the app suspects the token is stale (e.g. after a long pause).
  Future<void> refreshToken() async {
    final token = await _service.getToken();
    if (token == null || token == state.token) return;
    emit(state.copyWith(token: token));
    await _registerWithBackend(token);
  }

  /// Exposed for tests / dev menus — injects a fake message into the
  /// stream. Production callers ignore this.
  void debugSimulateIncoming(PushNotificationMessage message) {
    _messagesController.add(message);
  }

  void _attachStreams() {
    _tokensSub ??= _service.tokens.listen((token) async {
      _logger.info('FCM token rotated');
      emit(state.copyWith(token: token));
      await _registerWithBackend(token);
    });
    _messagesSub ??= _service.messages.listen(_messagesController.add);
  }

  Future<void> _registerWithBackend(String token) async {
    try {
      await _notificationRepository.updateFCMToken(token);
    } catch (e, s) {
      // Backend endpoint may not exist yet (graceful 404 swallow), or the
      // network may be down. Either way: don't crash the app.
      _logger.error('updateFCMToken failed: $e', e, s);
    }
  }

  @override
  Future<void> close() async {
    await _tokensSub?.cancel();
    await _messagesSub?.cancel();
    await _messagesController.close();
    return super.close();
  }
}
