part of 'package:mentorx_core/mentorx_core.dart';

class DeviceEntity extends Equatable {
  final String id;
  final String deviceName;
  final String deviceModel;
  final String? deviceType;
  final String? osVersion;
  final String? appVersion;
  final bool isActive;
  final DateTime lastUsedAt;

  const DeviceEntity({
    required this.id,
    required this.deviceName,
    required this.deviceModel,
    required this.isActive,
    required this.lastUsedAt,
    this.deviceType,
    this.osVersion,
    this.appVersion,
  });

  static final placeholder = DeviceEntity(
    id: '',
    deviceName: '',
    deviceModel: '',
    isActive: false,
    lastUsedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        deviceName,
        deviceModel,
        deviceType,
        osVersion,
        appVersion,
        isActive,
        lastUsedAt,
      ];

  DeviceEntity copyWith({
    String? id,
    String? deviceName,
    String? deviceModel,
    String? deviceType,
    String? osVersion,
    String? appVersion,
    bool? isActive,
    DateTime? lastUsedAt,
  }) {
    return DeviceEntity(
      id: id ?? this.id,
      deviceName: deviceName ?? this.deviceName,
      deviceModel: deviceModel ?? this.deviceModel,
      deviceType: deviceType ?? this.deviceType,
      osVersion: osVersion ?? this.osVersion,
      appVersion: appVersion ?? this.appVersion,
      isActive: isActive ?? this.isActive,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
    );
  }
}
