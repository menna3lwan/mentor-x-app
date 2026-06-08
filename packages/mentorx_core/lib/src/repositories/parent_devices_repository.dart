part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentDevicesRepositoryExceptionCode {
  unknown,
  fetchError,
  forceLogoutFailed,
  deactivateFailed,
  notFound,
  unauthorized,
  networkError,
}

final class ParentDevicesRepositoryException
    extends MentorXException<ParentDevicesRepositoryExceptionCode> {
  const ParentDevicesRepositoryException({
    required super.code,
    super.message,
  });
}

// ——— Repository ———

/// Backs the Parent app's Devices & Sessions surface. Lets the user inspect
/// every device currently bound to their account and revoke them.
///
/// EduCore backend contract:
/// - `GET  /api/auth/session-status`     → list of active sessions / devices.
/// - `POST /api/auth/force-logout-all`   → revoke every session except the
///                                         current one.
///
/// The (optional) per-device revoke endpoint is not declared in Postman yet;
/// the repository exposes `deactivateDevice` so the UI can call it, and the
/// implementation degrades gracefully when the backend returns 404/405.
abstract interface class ParentDevicesRepository {
  Future<void> initialize();

  /// Returns every device/session currently associated with the parent
  /// account. The first element with `isActive == true` is treated as the
  /// "current" session by the UI; implementations should preserve a
  /// stable ordering (e.g., last-used first).
  Future<List<DeviceEntity>> getDevices();

  /// Revokes every session except the one making the call. Returns the
  /// updated list of devices (typically containing only the current one).
  Future<List<DeviceEntity>> forceLogoutAll();

  /// Revokes a single device by id. Falls back to silently succeeding on
  /// 404/405 so the UI keeps working when the backend doesn't expose this
  /// endpoint yet.
  Future<void> deactivateDevice(String deviceId);
}
