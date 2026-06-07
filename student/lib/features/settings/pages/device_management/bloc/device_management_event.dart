part of 'device_management_bloc.dart';

sealed class DeviceManagementEvent extends Equatable {
  const DeviceManagementEvent();

  @override
  List<Object?> get props => [];
}

final class DeviceManagementInitialized extends DeviceManagementEvent {
  const DeviceManagementInitialized();
}

final class DeviceManagementRefreshed extends DeviceManagementEvent {
  const DeviceManagementRefreshed();
}

final class DeviceManagementDeactivateRequested
    extends DeviceManagementEvent {
  final String deviceId;

  const DeviceManagementDeactivateRequested({required this.deviceId});

  @override
  List<Object?> get props => [deviceId];
}
