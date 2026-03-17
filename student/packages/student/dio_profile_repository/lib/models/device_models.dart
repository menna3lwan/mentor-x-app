import 'package:mentorx_core/mentorx_core.dart';

final class DeviceModel extends DeviceEntity {
  const DeviceModel({
    required super.id,
    required super.deviceName,
    required super.deviceModel,
    required super.isActive,
    required super.lastUsedAt,
    super.osVersion,
    super.appVersion,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: json['id']?.toString() ?? '',
      deviceName: json['deviceName']?.toString() ?? json['device_name']?.toString() ?? '',
      deviceModel: json['deviceModel']?.toString() ?? json['device_model']?.toString() ?? '',
      isActive: json['isActive'] ?? json['is_active'] ?? false,
      lastUsedAt: json['lastUsedAt'] != null 
          ? DateTime.parse(json['lastUsedAt'].toString()) 
          : (json['last_used_at'] != null ? DateTime.parse(json['last_used_at'].toString()) : DateTime.now()),
      osVersion: json['osVersion']?.toString() ?? json['os_version']?.toString(),
      appVersion: json['appVersion']?.toString() ?? json['app_version']?.toString(),
    );
  }
}
