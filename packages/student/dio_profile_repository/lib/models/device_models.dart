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
      deviceName:
          json['deviceName']?.toString() ?? json['device_name']?.toString() ?? '',
      deviceModel:
          json['deviceModel']?.toString() ?? json['device_model']?.toString() ?? '',
      isActive: json['isActive'] ?? json['is_active'] ?? false,
      lastUsedAt: json['lastUsedAt'] != null
          ? DateTime.parse(json['lastUsedAt'].toString())
          : (json['last_used_at'] != null
              ? DateTime.parse(json['last_used_at'].toString())
              : DateTime.now()),
      osVersion: json['osVersion']?.toString() ?? json['os_version']?.toString(),
      appVersion:
          json['appVersion']?.toString() ?? json['app_version']?.toString(),
    );
  }
}

final class StudentProfileModel extends StudentEntity {
  const StudentProfileModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.email,
    super.profileImageUrl,
    super.gender = Gender.male,
    super.gradeId,
    super.gradeName,
    super.studentCode,
    super.studyType,
    super.walletBalance = 0.0,
    super.totalPoints = 0,
    super.schoolName,
    super.centerId,
    super.centerName,
    super.parentName,
    super.parentPhone,
    super.academicLevel,
    super.dateOfBirth,
    super.address,
    super.city,
    super.governorate,
    super.enrolledCourseIds,
    super.metadata,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
    final user = json['data'] ?? json;

    final String fullName = (user['fullName'] ?? user['name'] ?? '')?.toString() ?? '';
    final nameParts = fullName.trim().split(' ');
    final String fallbackFirst = nameParts.isNotEmpty ? nameParts.first : '';
    final String fallbackLast = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    DateTime parseDate(dynamic value) {
      if (value == null) return DateTime.now();
      return DateTime.tryParse(value.toString()) ?? DateTime.now();
    }

    double parseDouble(dynamic value, double fallback) {
      if (value == null) return fallback;
      if (value is num) return value.toDouble();
      return double.tryParse(value.toString()) ?? fallback;
    }

    int parseInt(dynamic value, int fallback) {
      if (value == null) return fallback;
      if (value is num) return value.toInt();
      return int.tryParse(value.toString()) ?? fallback;
    }

    return StudentProfileModel(
      id: (user['userId'] ?? user['id'] ?? user['studentCode'] ?? '')?.toString() ?? '',
      firstName: (user['firstName'] ?? user['first_name'] ?? fallbackFirst)?.toString() ?? '',
      lastName: (user['lastName'] ?? user['last_name'] ?? fallbackLast)?.toString() ?? '',
      email: user['email']?.toString(),
      phoneNumber: (user['phone'] ?? user['phoneNumber'] ?? user['phone_number'] ?? '')?.toString() ?? '',
      profileImageUrl: (user['profileImageUrl'] ?? user['profileImage'] ?? user['avatarUrl'] ?? user['profile_photo_url'])?.toString(),
      gender: _parseGender(user['gender']),
      status: _parseStatus(user['status'] ?? user['accountStatus'] ?? user['account_status']),
      gradeId: (user['gradeId'] ?? user['grade_id'])?.toString(),
      gradeName: (user['gradeName'] ?? user['grade_name'] ?? user['grade'])?.toString(),
      studentCode: (user['studentCode'] ?? user['student_code'])?.toString(),
      studyType: (user['studyType'] ?? user['study_type'])?.toString(),
      walletBalance: parseDouble(user['walletBalance'] ?? user['wallet_balance'], 0.0),
      totalPoints: parseInt(user['totalPoints'] ?? user['total_points'], 0),
      schoolName: (user['schoolName'] ?? user['school_name'])?.toString(),
      centerId: (user['centerId'] ?? user['center_id'])?.toString(),
      centerName: (user['centerName'] ?? user['center_name'] ?? user['center'])?.toString(),
      parentName: (user['parentName'] ?? user['parent_name'])?.toString(),
      parentPhone: (user['parentPhone'] ?? user['parent_phone'])?.toString(),
      academicLevel: (user['academicLevel'] ?? user['academic_level'])?.toString(),
      dateOfBirth: DateTime.tryParse((user['dateOfBirth'] ?? user['date_of_birth'])?.toString() ?? ''),
      address: user['address']?.toString(),
      city: user['city']?.toString(),
      governorate: user['governorate']?.toString(),
      enrolledCourseIds: (user['enrolledCourseIds'] ?? user['enrolled_course_ids']) is List
          ? (user['enrolledCourseIds'] ?? user['enrolled_course_ids'] as List).map((e) => e.toString()).toList()
          : null,
      metadata: user['metadata'] is Map ? Map<String, dynamic>.from(user['metadata'] as Map) : null,
      createdAt: parseDate(user['createdAt'] ?? user['created_at']),
      updatedAt: parseDate(user['updatedAt'] ?? user['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender.name,
      'gradeId': gradeId,
      'schoolName': schoolName,
      'centerId': centerId,
      'parentName': parentName,
      'parentPhone': parentPhone,
      'academicLevel': academicLevel,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'address': address,
      'city': city,
      'governorate': governorate,
      'metadata': metadata,
    };
  }

  factory StudentProfileModel.fromEntity(StudentEntity entity) {
    return StudentProfileModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      profileImageUrl: entity.profileImageUrl,
      gender: entity.gender,
      status: entity.status,
      gradeId: entity.gradeId,
      gradeName: entity.gradeName,
      studentCode: entity.studentCode,
      studyType: entity.studyType,
      walletBalance: entity.walletBalance,
      totalPoints: entity.totalPoints,
      schoolName: entity.schoolName,
      centerId: entity.centerId,
      centerName: entity.centerName,
      parentName: entity.parentName,
      parentPhone: entity.parentPhone,
      academicLevel: entity.academicLevel,
      dateOfBirth: entity.dateOfBirth,
      address: entity.address,
      city: entity.city,
      governorate: entity.governorate,
      enrolledCourseIds: entity.enrolledCourseIds,
      metadata: entity.metadata,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static Gender _parseGender(dynamic value) {
    if (value == null) return Gender.male;
    final str = value.toString().toLowerCase();
    return Gender.values.firstWhere(
      (e) => e.name == str,
      orElse: () => Gender.male,
    );
  }

  static StudentStatus _parseStatus(dynamic value) {
    if (value == null) return StudentStatus.pending;
    final str = value.toString().toLowerCase();
    return StudentStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => StudentStatus.pending,
    );
  }
}
