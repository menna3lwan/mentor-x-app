part of 'device_management_page_bloc.dart';

final class DeviceManagementPageState extends Equatable {
  final LoadingState loadingState;
  final List<DeviceEntity> devices;
  final Set<String> deactivatingDeviceIds;
  final String? errorMessage;

  const DeviceManagementPageState({
    required this.loadingState,
    required this.devices,
    required this.deactivatingDeviceIds,
    this.errorMessage,
  });

  static const initial = DeviceManagementPageState(
    loadingState: LoadingState.initial,
    devices: <DeviceEntity>[],
    deactivatingDeviceIds: <String>{},
  );

  DeviceManagementPageState copyWith({
    LoadingState? loadingState,
    List<DeviceEntity>? devices,
    Set<String>? deactivatingDeviceIds,
    String? errorMessage,
  }) {
    return DeviceManagementPageState(
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
