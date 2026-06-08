part of 'devices_bloc.dart';

enum DevicesStatus { initial, loading, loaded, failure }

extension DevicesStatusX on DevicesStatus {
  bool get isInitial => this == DevicesStatus.initial;
  bool get isLoading => this == DevicesStatus.loading;
  bool get isLoaded => this == DevicesStatus.loaded;
  bool get isFailure => this == DevicesStatus.failure;
}

final class DevicesState extends Equatable {
  final DevicesStatus status;
  final List<DeviceEntity> devices;
  final String? errorMessage;
  final bool isRefreshing;
  final bool isForceLogoutInFlight;
  final String? deactivatingDeviceId;

  const DevicesState({
    required this.status,
    this.devices = const [],
    this.errorMessage,
    this.isRefreshing = false,
    this.isForceLogoutInFlight = false,
    this.deactivatingDeviceId,
  });

  factory DevicesState.initial() =>
      const DevicesState(status: DevicesStatus.initial);

  bool get hasMultipleDevices => devices.length > 1;

  DevicesState copyWith({
    DevicesStatus? status,
    List<DeviceEntity>? devices,
    String? errorMessage,
    bool? isRefreshing,
    bool? isForceLogoutInFlight,
    String? deactivatingDeviceId,
  }) {
    return DevicesState(
      status: status ?? this.status,
      devices: devices ?? this.devices,
      errorMessage: errorMessage,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isForceLogoutInFlight:
          isForceLogoutInFlight ?? this.isForceLogoutInFlight,
      deactivatingDeviceId: deactivatingDeviceId,
    );
  }

  @override
  List<Object?> get props => [
    status,
    devices,
    errorMessage,
    isRefreshing,
    isForceLogoutInFlight,
    deactivatingDeviceId,
  ];
}
