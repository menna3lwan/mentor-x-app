import 'package:mentorx_core/mentorx_core.dart';

/// Wire model for a [DeviceEntity]. Accepts both camelCase and snake_case
/// keys plus a handful of common aliases so we don't have to bump the model
/// every time the backend shape drifts.
final class DeviceModel extends DeviceEntity {
  const DeviceModel({
    required super.id,
    required super.deviceName,
    required super.deviceModel,
    required super.isActive,
    required super.lastUsedAt,
    super.deviceType,
    super.osVersion,
    super.appVersion,
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
      id: ModelParser.asString(
        json['id'] ??
            json['deviceId'] ??
            json['device_id'] ??
            json['deviceHash'] ??
            json['device_hash'],
      ),
      deviceName: ModelParser.asString(
        json['deviceName'] ??
            json['device_name'] ??
            json['name'] ??
            json['label'],
        fallback: 'Unknown device',
      ),
      deviceModel: ModelParser.asString(
        json['deviceModel'] ??
            json['device_model'] ??
            json['model'] ??
            json['platform'],
      ),
      deviceType: _stringOrNull(
        json['deviceType'] ?? json['device_type'] ?? json['type'],
      ),
      osVersion: _stringOrNull(
        json['osVersion'] ?? json['os_version'] ?? json['os'],
      ),
      appVersion: _stringOrNull(
        json['appVersion'] ?? json['app_version'] ?? json['version'],
      ),
      isActive: ModelParser.asBool(
        json['isActive'] ?? json['is_active'] ?? json['active'],
        fallback: true,
      ),
      lastUsedAt:
          ModelParser.asDateTime(
            json['lastUsedAt'] ??
                json['last_used_at'] ??
                json['lastSeenAt'] ??
                json['last_seen_at'],
          ) ??
          DateTime.now(),
    );
  }

  DeviceEntity toEntity() {
    return DeviceEntity(
      id: id,
      deviceName: deviceName,
      deviceModel: deviceModel,
      isActive: isActive,
      lastUsedAt: lastUsedAt,
      deviceType: deviceType,
      osVersion: osVersion,
      appVersion: appVersion,
    );
  }

  static String? _stringOrNull(dynamic value) {
    if (value == null) return null;
    final str = value.toString().trim();
    return str.isEmpty ? null : str;
  }
}
