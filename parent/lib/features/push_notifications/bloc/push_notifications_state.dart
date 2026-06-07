part of 'push_notifications_cubit.dart';

final class PushNotificationsState extends Equatable {
  final PushNotificationPermission permission;
  final String? token;
  final bool isBootstrapped;

  const PushNotificationsState({
    required this.permission,
    this.token,
    this.isBootstrapped = false,
  });

  factory PushNotificationsState.initial() => const PushNotificationsState(
    permission: PushNotificationPermission.notDetermined,
  );

  bool get isEnabled => permission.isGranted && token != null;

  PushNotificationsState copyWith({
    PushNotificationPermission? permission,
    String? token,
    bool? isBootstrapped,
  }) {
    return PushNotificationsState(
      permission: permission ?? this.permission,
      token: token,
      isBootstrapped: isBootstrapped ?? this.isBootstrapped,
    );
  }

  @override
  List<Object?> get props => [permission, token, isBootstrapped];
}
