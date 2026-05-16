import 'package:mentorx_core/mentorx_core.dart';

final class StudentModel extends StudentEntity {
  const StudentModel({
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
    super.identityDocumentUrl,
    super.gender = Gender.male,
    super.gradeId,
    super.gradeName,
    super.studentCode,
    super.studyType,
    super.studyLocation,
    super.walletBalance = 0.0,
    super.totalPoints = 0,
    super.schoolName,
    super.educationDepartment,
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
    super.enabled,
    super.hasActiveSession,
    super.devicesCount,
    super.loginCount,
    super.logoutCount,
    super.rejectionReason,
    super.mapAddress,
    super.latitude,
    super.longitude,
    super.lastLoginAt,
    super.enrolledCourseIds,
    super.metadata,
  });

  factory StudentModel.fromEntity(StudentEntity entity) {
    return StudentModel(
      id: entity.id,
      firstName: entity.firstName,
      secondName: entity.secondName,
      thirdName: entity.thirdName,
      fourthName: entity.fourthName,
      lastName: entity.lastName,
      phoneNumber: entity.phoneNumber,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      email: entity.email,
      profileImageUrl: entity.profileImageUrl,
      identityDocumentUrl: entity.identityDocumentUrl,
      gender: entity.gender,
      gradeId: entity.gradeId,
      gradeName: entity.gradeName,
      studentCode: entity.studentCode,
      studyType: entity.studyType,
      studyLocation: entity.studyLocation,
      walletBalance: entity.walletBalance,
      totalPoints: entity.totalPoints,
      schoolName: entity.schoolName,
      educationDepartment: entity.educationDepartment,
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
      isOnline: entity.isOnline,
      enabled: entity.enabled,
      hasActiveSession: entity.hasActiveSession,
      devicesCount: entity.devicesCount,
      loginCount: entity.loginCount,
      lastLoginAt: entity.lastLoginAt,
      enrolledCourseIds: entity.enrolledCourseIds,
      metadata: entity.metadata,
    );
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    // Standardize data extraction using ModelParser
    final user = ModelParser.extractData(json);

    // 1. Resolve ID (userId or id or studentCode)
    final id = ModelParser.asString(
      user['id'] ?? user['userId'] ?? user['user_id'] ?? user['studentCode'],
    );

    // 2. Resolve Names (Handle 4-part names and fullName split)
    final String first = ModelParser.asString(
      user['firstName'] ?? user['first_name'],
    );
    final String second = ModelParser.asString(
      user['secondName'] ?? user['second_name'],
    );
    final String third = ModelParser.asString(
      user['thirdName'] ?? user['third_name'],
    );
    final String fourth = ModelParser.asString(
      user['fourthName'] ?? user['fourth_name'],
    );

    final String fullName = ModelParser.asString(
      user['fullName'] ?? user['full_name'] ?? user['name'],
    );
    final nameParts = fullName.trim().split(' ');

    final String resolvedFirst = first.isNotEmpty
        ? first
        : (nameParts.isNotEmpty ? nameParts.first : '');
    final String resolvedLast = fourth.isNotEmpty
        ? fourth
        : (user['lastName'] ??
              user['last_name'] ??
              (nameParts.length > 1 ? nameParts.sublist(1).join(' ') : ''));

    // 3. Resolve Status
    final status = _parseStatus(
      user['status'] ?? user['accountStatus'] ?? user['account_status'],
    );

    return StudentModel(
      id: id,
      firstName: resolvedFirst,
      secondName: second,
      thirdName: third,
      fourthName: fourth,
      lastName: resolvedLast.toString(),
      email: ModelParser.asString(user['email']),
      phoneNumber: ModelParser.asString(
        user['phone'] ?? user['phoneNumber'] ?? user['phone_number'],
      ),
      profileImageUrl: ModelParser.asString(
        user['profileImageUrl'] ??
            user['profileImage'] ??
            user['avatarUrl'] ??
            user['profile_photo_url'] ??
            user['profile_image_url'],
      ),
      identityDocumentUrl: ModelParser.asString(
        user['identityDocumentUrl'] ?? user['identity_document_url'],
      ),
      gender: _parseGender(user['gender']),
      status: status,
      gradeId: ModelParser.asString(user['gradeId'] ?? user['grade_id']),
      gradeName: ModelParser.asString(
        user['gradeName'] ?? user['grade_name'] ?? user['grade'],
      ),
      studentCode: ModelParser.asString(
        user['studentCode'] ?? user['student_code'],
      ),
      studyType: ModelParser.asString(user['studyType'] ?? user['study_type']),
      studyLocation: ModelParser.asString(
        user['studyLocation'] ?? user['study_location'],
      ),
      walletBalance: ModelParser.asDouble(
        user['walletBalance'] ?? user['wallet_balance'] ?? user['balance'],
      ),
      totalPoints: ModelParser.asInt(
        user['totalPoints'] ?? user['total_points'] ?? user['points'],
      ),
      schoolName: ModelParser.asString(
        user['schoolName'] ?? user['school_name'],
      ),
      educationDepartment: ModelParser.asString(
        user['educationDepartment'] ?? user['education_department'],
      ),
      centerId: ModelParser.asString(user['centerId'] ?? user['center_id']),
      centerName: ModelParser.asString(
        user['centerName'] ?? user['center_name'] ?? user['center'],
      ),
      parentName: ModelParser.asString(
        user['parentName'] ?? user['parent_name'],
      ),
      parentPhone: ModelParser.asString(
        user['parentPhone'] ?? user['parent_phone'],
      ),
      academicLevel: ModelParser.asString(
        user['academicLevel'] ?? user['academic_level'],
      ),
      dateOfBirth: ModelParser.asDateTime(
        user['dateOfBirth'] ?? user['date_of_birth'],
      ),
      address: ModelParser.asString(user['address']),
      city: ModelParser.asString(user['city']),
      area: ModelParser.asString(user['area'] ?? user['district']),
      governorate: ModelParser.asString(user['governorate']),
      isOnline: ModelParser.asBool(
        user['online'] ?? user['isOnline'] ?? user['is_online'],
      ),
      enabled: ModelParser.asBool(
        user['enabled'] ?? user['active'],
        fallback: true,
      ),
      hasActiveSession: ModelParser.asBool(
        user['hasActiveSession'] ?? user['hasSession'],
      ),
      devicesCount: ModelParser.asInt(
        user['devicesCount'] ?? user['devices_count'],
      ),
      loginCount: ModelParser.asInt(user['loginCount'] ?? user['login_count']),
      logoutCount: ModelParser.asInt(
        user['logoutCount'] ?? user['logout_count'],
      ),
      rejectionReason: ModelParser.asString(
        user['rejectionReason'] ?? user['rejection_reason'],
      ),
      mapAddress: ModelParser.asString(
        user['mapAddress'] ?? user['map_address'],
      ),
      latitude: ModelParser.asDouble(user['latitude']),
      longitude: ModelParser.asDouble(user['longitude']),
      lastLoginAt: ModelParser.asDateTime(
        user['lastLoginAt'] ?? user['last_login_at'],
      ),
      enrolledCourseIds: ModelParser.asList(
        user['enrolledCourseIds'] ?? user['enrolled_course_ids'],
      ).map((e) => e.toString()).toList(),
      metadata: ModelParser.asMap(user['metadata']),
      createdAt:
          ModelParser.asDateTime(user['createdAt'] ?? user['created_at']) ??
          DateTime.now(),
      updatedAt:
          ModelParser.asDateTime(user['updatedAt'] ?? user['updated_at']) ??
          DateTime.now(),
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
    // Map backend variations to status
    if (str == 'approved' || str == 'accepted' || str == 'active') {
      return StudentStatus.active;
    }
    if (str == 'blocked' || str == 'banned' || str == 'suspended') {
      return StudentStatus.suspended;
    }
    if (str == 'rejected') return StudentStatus.rejected;
    return StudentStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => StudentStatus.pending,
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
      'phone': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'identityDocumentUrl': identityDocumentUrl,
      'gender': gender.name,
      'status': status.name,
      'gradeId': gradeId,
      'gradeName': gradeName,
      'studentCode': studentCode,
      'studyType': studyType,
      'studyLocation': studyLocation,
      'walletBalance': walletBalance,
      'totalPoints': totalPoints,
      'schoolName': schoolName,
      'educationDepartment': educationDepartment,
      'centerId': centerId,
      'centerName': centerName,
      'parentName': parentName,
      'parentPhone': parentPhone,
      'academicLevel': academicLevel,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'address': address,
      'city': city,
      'area': area,
      'governorate': governorate,
      'online': isOnline,
      'enabled': enabled,
      'hasActiveSession': hasActiveSession,
      'devicesCount': devicesCount,
      'loginCount': loginCount,
      'logoutCount': logoutCount,
      'rejectionReason': rejectionReason,
      'mapAddress': mapAddress,
      'latitude': latitude,
      'longitude': longitude,
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'enrolledCourseIds': enrolledCourseIds,
      'metadata': metadata,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
