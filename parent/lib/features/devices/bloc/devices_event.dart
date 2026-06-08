part of 'devices_bloc.dart';

sealed class DevicesEvent extends Equatable {
  const DevicesEvent();

  @override
  List<Object?> get props => const [];
}

final class DevicesStarted extends DevicesEvent {
  const DevicesStarted();
}

final class DevicesRefreshRequested extends DevicesEvent {
  const DevicesRefreshRequested();
}

final class DevicesForceLogoutAllRequested extends DevicesEvent {
  const DevicesForceLogoutAllRequested();
}

final class DeviceDeactivationRequested extends DevicesEvent {
  final String deviceId;
  const DeviceDeactivationRequested(this.deviceId);

  @override
  List<Object?> get props => [deviceId];
}
