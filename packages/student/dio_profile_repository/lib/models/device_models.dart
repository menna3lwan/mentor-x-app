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

final class StudentProfileModel extends StudentEntity {
  const StudentProfileModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.secondName,
    super.thirdName,
    super.fourthName,
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
    super.area,
    super.governorate,
    super.isOnline,
    super.enrolledCourseIds,
    super.metadata,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
    final user = ModelParser.asMap(json['data'] ?? json);

    final String fullName = ModelParser.asString(user['fullName'] ?? user['name']);
    final nameParts = fullName.trim().split(' ');
    final String fallbackFirst = nameParts.isNotEmpty ? nameParts.first : '';
    final String fallbackLast = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return StudentProfileModel(
      id: ModelParser.asString(user['userId'] ?? user['id'] ?? user['studentCode']),
      firstName: ModelParser.asString(user['firstName'] ?? user['first_name'], fallback: fallbackFirst),
      secondName: ModelParser.asString(user['secondName'] ?? user['second_name']),
      thirdName: ModelParser.asString(user['thirdName'] ?? user['third_name']),
      fourthName: ModelParser.asString(user['fourthName'] ?? user['fourth_name']),
      lastName: ModelParser.asString(user['lastName'] ?? user['last_name'] ?? user['fourthName'], fallback: fallbackLast),
      email: ModelParser.asString(user['email']),
      phoneNumber: ModelParser.asString(user['phone'] ?? user['phoneNumber'] ?? user['phone_number']),
      profileImageUrl: ModelParser.asString(user['profileImageUrl'] ?? user['profileImage'] ?? user['avatarUrl'] ?? user['profile_photo_url']),
      gender: _parseGender(user['gender']),
      status: _parseStatus(user['status'] ?? user['accountStatus'] ?? user['account_status']),
      gradeId: ModelParser.asString(user['gradeId'] ?? user['grade_id']),
      gradeName: ModelParser.asString(user['gradeName'] ?? user['grade_name'] ?? user['grade']),
      studentCode: ModelParser.asString(user['studentCode'] ?? user['student_code']),
      studyType: ModelParser.asString(user['studyType'] ?? user['study_type']),
      walletBalance: ModelParser.asDouble(user['walletBalance'] ?? user['wallet_balance']),
      totalPoints: ModelParser.asInt(user['totalPoints'] ?? user['total_points']),
      schoolName: ModelParser.asString(user['schoolName'] ?? user['school_name']),
      centerId: ModelParser.asString(user['centerId'] ?? user['center_id']),
      centerName: ModelParser.asString(user['centerName'] ?? user['center_name'] ?? user['center']),
      parentName: ModelParser.asString(user['parentName'] ?? user['parent_name']),
      parentPhone: ModelParser.asString(user['parentPhone'] ?? user['parent_phone']),
      academicLevel: ModelParser.asString(user['academicLevel'] ?? user['academic_level']),
      dateOfBirth: ModelParser.asDateTime(user['dateOfBirth'] ?? user['date_of_birth']),
      address: ModelParser.asString(user['address']),
      city: ModelParser.asString(user['city']),
      area: ModelParser.asString(user['area'] ?? user['city']),
      governorate: ModelParser.asString(user['governorate']),
      isOnline: ModelParser.asBool(user['online'] ?? user['isOnline']),
      enrolledCourseIds: ModelParser.asList(user['enrolledCourseIds'] ?? user['enrolled_course_ids'])
          .map((e) => e.toString())
          .toList(),
      metadata: ModelParser.asMap(user['metadata']),
      createdAt: ModelParser.asDateTime(user['createdAt'] ?? user['created_at']) ?? DateTime.now(),
      updatedAt: ModelParser.asDateTime(user['updatedAt'] ?? user['updated_at']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'secondName': secondName,
      'thirdName': thirdName,
      'fourthName': fourthName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender.name,
      'grade': gradeName,
      'gradeId': gradeId,
      'schoolName': schoolName,
      'centerId': centerId,
      'parentName': parentName,
      'parentPhone': parentPhone,
      'academicLevel': academicLevel,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'address': address,
      'city': city,
      'area': area ?? city,
      'governorate': governorate,
      'online': isOnline ?? true,
      'metadata': metadata,
    };
  }

  factory StudentProfileModel.fromEntity(StudentEntity entity) {
    return StudentProfileModel(
      id: entity.id,
      firstName: entity.firstName,
      secondName: entity.secondName,
      thirdName: entity.thirdName,
      fourthName: entity.fourthName,
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
      area: entity.area,
      governorate: entity.governorate,
      enrolledCourseIds: entity.enrolledCourseIds,
      isOnline: entity.isOnline,
      metadata: entity.metadata,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }


  static Gender _parseGender(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    return Gender.values.firstWhere(
      (e) => e.name == str,
      orElse: () => Gender.male,
    );
  }

  static StudentStatus _parseStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    return StudentStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => StudentStatus.pending,
    );
  }
}
