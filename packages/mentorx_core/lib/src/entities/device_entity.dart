part of '../../mentorx_core.dart';

final class DeviceEntity extends Equatable {
  final String id;
  final String deviceName;
  final String deviceModel;
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
        osVersion,
        appVersion,
        isActive,
        lastUsedAt,
      ];
}
