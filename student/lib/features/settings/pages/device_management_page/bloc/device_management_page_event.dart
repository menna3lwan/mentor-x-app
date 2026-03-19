part of 'device_management_page_bloc.dart';

sealed class DeviceManagementPageEvent extends Equatable {
  const DeviceManagementPageEvent();

  @override
  List<Object?> get props => [];
}

final class DeviceManagementPageInitialized extends DeviceManagementPageEvent {
  const DeviceManagementPageInitialized();
}

final class DeviceManagementPageRefreshed extends DeviceManagementPageEvent {
  const DeviceManagementPageRefreshed();
}

final class DeviceManagementPageDeactivateRequested
    extends DeviceManagementPageEvent {
  final String deviceId;

  const DeviceManagementPageDeactivateRequested({required this.deviceId});

  @override
  List<Object?> get props => [deviceId];
}
