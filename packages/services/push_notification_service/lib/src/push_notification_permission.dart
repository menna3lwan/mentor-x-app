/// Coarse-grained representation of the user's permission state for push
/// notifications. Maps cleanly to both the system permission status on
/// Android/iOS and to our own UI states.
enum PushNotificationPermission {
  /// Permission has never been requested.
  notDetermined,

  /// The user explicitly granted permission.
  granted,

  /// The user denied permission. Can usually be re-requested.
  denied,

  /// Permission has been denied permanently (e.g. iOS "deny" or Android 13
  /// "deny forever"). The app must direct the user to system settings.
  permanentlyDenied,

  /// Provisional permission (iOS quiet notifications). Treated as granted
  /// for routing purposes but the badge / banner should be muted.
  provisional,
}

extension PushNotificationPermissionX on PushNotificationPermission {
  bool get isGranted =>
      this == PushNotificationPermission.granted ||
      this == PushNotificationPermission.provisional;

  bool get canRequest =>
      this == PushNotificationPermission.notDetermined ||
      this == PushNotificationPermission.denied;
}
