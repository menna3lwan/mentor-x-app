part of 'device_management_bloc.dart';

final class DeviceManagementState extends Equatable {
  final LoadingState loadingState;
  final List<DeviceEntity> devices;
  final Set<String> deactivatingDeviceIds;
  final String? errorMessage;

  const DeviceManagementState({
    required this.loadingState,
    required this.devices,
    required this.deactivatingDeviceIds,
    this.errorMessage,
  });

  static const initial = DeviceManagementState(
    loadingState: LoadingState.initial,
    devices: <DeviceEntity>[],
    deactivatingDeviceIds: <String>{},
  );

  DeviceManagementState copyWith({
    LoadingState? loadingState,
    List<DeviceEntity>? devices,
    Set<String>? deactivatingDeviceIds,
    String? errorMessage,
  }) {
    return DeviceManagementState(
      loadingState: loadingState ?? this.loadingState,
      devices: devices ?? this.devices,
      deactivatingDeviceIds:
          deactivatingDeviceIds ?? this.deactivatingDeviceIds,
      errorMessage: errorMessage,
    );
  }

  bool get isLoading =>
      loadingState.isLoading || loadingState == LoadingState.initial;

  @override
  List<Object?> get props => [
    loadingState,
    devices,
    deactivatingDeviceIds,
    errorMessage,
  ];
}
