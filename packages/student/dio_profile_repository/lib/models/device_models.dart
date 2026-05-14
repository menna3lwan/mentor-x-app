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
      id: ModelParser.asString(json['id']),
      deviceName: ModelParser.asString(json['deviceName'] ?? json['device_name']),
      deviceModel: ModelParser.asString(json['deviceModel'] ?? json['device_model']),
      isActive: ModelParser.asBool(json['isActive'] ?? json['is_active']),
      lastUsedAt: ModelParser.asDateTime(json['lastUsedAt'] ?? json['last_used_at']) ?? DateTime.now(),
      osVersion: ModelParser.asString(json['osVersion'] ?? json['os_version']),
      appVersion: ModelParser.asString(json['appVersion'] ?? json['app_version']),
    );
  }
}

