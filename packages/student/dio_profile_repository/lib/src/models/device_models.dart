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
          : (json['last_used_at'] != null 
              ? DateTime.parse(json['last_used_at'].toString()) 
              : DateTime.now()),
      osVersion: json['osVersion']?.toString() ?? json['os_version']?.toString(),
      appVersion: json['appVersion']?.toString() ?? json['app_version']?.toString(),
    );
  }
}

final class StudentProfileModel extends StudentEntity {
  const StudentProfileModel({
    required super.id,
    required super.name,
    super.email,
    required super.phoneNumber,
    super.profileImageUrl,
    super.gender,
    required super.status,
    super.gradeId,
    required super.createdAt,
    required super.updatedAt,
    super.parentName,
    super.parentPhone,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
    return StudentProfileModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString(),
      phoneNumber: (json['phoneNumber'] ?? json['phone_number'])?.toString() ?? '',
      profileImageUrl: (json['profileImageUrl'] ?? json['avatarUrl'] ?? json['avatar_url'] ?? json['profile_image_url'])?.toString(),
      gender: _parseGender(json['gender']),
      status: _parseStatus(json['status']),
      gradeId: (json['gradeId'] ?? json['grade_id'])?.toString(),
      parentName: (json['parentName'] ?? json['parent_name'])?.toString(),
      parentPhone: (json['parentPhone'] ?? json['parent_phone'])?.toString(),
      createdAt: DateTime.tryParse((json['createdAt'] ?? json['created_at'])?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse((json['updatedAt'] ?? json['updated_at'])?.toString() ?? '') ?? DateTime.now(),
    );
  }

  static Gender _parseGender(dynamic value) {
    final str = value?.toString().toLowerCase();
    return Gender.values.firstWhere(
      (e) => e.name == str,
      orElse: () => Gender.male,
    );
  }

  static StudentStatus _parseStatus(dynamic value) {
    final str = value?.toString().toLowerCase();
    return StudentStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => StudentStatus.pending,
    );
  }
}
