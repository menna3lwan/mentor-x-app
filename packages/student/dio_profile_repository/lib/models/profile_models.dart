import 'package:mentorx_core/mentorx_core.dart';

final class ProfileEditRequestModel extends ProfileEditRequestEntity {
  const ProfileEditRequestModel({
    required super.id,
    required super.fieldName,
    required super.oldValue,
    required super.newValue,
    super.reason,
    required super.status,
    super.reviewNotes,
    required super.createdAt,
  });

  factory ProfileEditRequestModel.fromJson(Map<String, dynamic> json) {
    return ProfileEditRequestModel(
      id: ModelParser.asString(json['id']),
      fieldName: ModelParser.asString(json['fieldName'] ?? json['field_name']),
      oldValue: ModelParser.asString(json['oldValue'] ?? json['old_value']),
      newValue: ModelParser.asString(json['newValue'] ?? json['new_value']),
      reason: ModelParser.asString(json['reason']),
      status: _parseEditStatus(json['status']),
      reviewNotes: ModelParser.asString(json['reviewNotes'] ?? json['review_notes']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']) ?? DateTime.now(),
    );
  }

  static EditRequestStatus _parseEditStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    return EditRequestStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => EditRequestStatus.pending,
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
    final data = ModelParser.asMap(json['data'] ?? json);

    // Build names from 4-part structure
    final String first = ModelParser.asString(data['firstName'] ?? data['first_name']);
    final String second = ModelParser.asString(data['secondName'] ?? data['second_name']);
    final String third = ModelParser.asString(data['thirdName'] ?? data['third_name']);
    final String fourth = ModelParser.asString(data['fourthName'] ?? data['fourth_name']);
    
    // Fallback: fullName split
    final String fullName = ModelParser.asString(data['fullName'] ?? data['full_name']);
    final nameParts = fullName.trim().split(' ');
    final String fallbackFirst = nameParts.isNotEmpty ? nameParts.first : '';
    final String fallbackLast = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return StudentProfileModel(
      id: ModelParser.asString(data['id'] ?? data['userId'] ?? data['studentCode']),
      firstName: first.isEmpty ? fallbackFirst : first,
      secondName: second,
      thirdName: third,
      fourthName: fourth,
      lastName: fourth.isEmpty ? (data['lastName'] ?? data['last_name'] ?? fallbackLast) : fourth,
      email: ModelParser.asString(data['email']),
      phoneNumber: ModelParser.asString(data['phone'] ?? data['phoneNumber'] ?? data['phone_number']),
      profileImageUrl: ModelParser.asString(
        data['profileImageUrl'] ?? data['image_url'] ?? data['profile_image_url'] ?? data['avatarUrl'],
      ),
      gender: _parseGender(data['gender']),
      status: _parseStudentStatus(data['status']),
      gradeId: ModelParser.asString(data['gradeId'] ?? data['grade_id']),
      gradeName: ModelParser.asString(data['grade'] ?? data['gradeName'] ?? data['grade_name']),
      studentCode: ModelParser.asString(data['studentCode'] ?? data['student_code']),
      studyType: ModelParser.asString(data['studyType'] ?? data['study_type']),
      walletBalance: ModelParser.asDouble(data['walletBalance'] ?? data['wallet_balance'] ?? data['balance']),
      totalPoints: ModelParser.asInt(data['totalPoints'] ?? data['total_points'] ?? data['points']),
      schoolName: ModelParser.asString(data['schoolName'] ?? data['school_name']),
      centerId: ModelParser.asString(data['centerId'] ?? data['center_id']),
      centerName: ModelParser.asString(data['centerName'] ?? data['center_name']),
      parentName: ModelParser.asString(data['parentName'] ?? data['parent_name']),
      parentPhone: ModelParser.asString(data['parentPhone'] ?? data['parent_phone']),
      academicLevel: ModelParser.asString(data['academicLevel'] ?? data['academic_level']),
      dateOfBirth: ModelParser.asDateTime(data['dateOfBirth'] ?? data['date_of_birth']),
      address: ModelParser.asString(data['address']),
      city: ModelParser.asString(data['city']),
      area: ModelParser.asString(data['area']),
      governorate: ModelParser.asString(data['governorate']),
      isOnline: ModelParser.asBool(data['online'] ?? data['isOnline'] ?? data['is_online']),
      enrolledCourseIds: ModelParser.asList(data['enrolledCourseIds'] ?? data['enrolled_course_ids'])
          .map((e) => e.toString())
          .toList(),
      metadata: ModelParser.asMap(data['metadata']),
      createdAt: ModelParser.asDateTime(data['createdAt'] ?? data['created_at']) ?? DateTime.now(),
      updatedAt: ModelParser.asDateTime(data['updatedAt'] ?? data['updated_at']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    // Matches UpdateStudentProfileRequest schema
    return {
      'firstName': firstName,
      'secondName': secondName,
      'thirdName': thirdName,
      'fourthName': fourthName,
      'grade': gradeName,
      'governorate': governorate,
      'area': area,
      'schoolName': schoolName,
      'educationDepartment': educationDepartment,
      'centerName': centerName,
      'online': isOnline,
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

  static StudentStatus _parseStudentStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    if (str == 'active' || str == 'approved') return StudentStatus.active;
    if (str == 'suspended' || str == 'blocked') return StudentStatus.suspended;
    return StudentStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => StudentStatus.pending,
    );
  }
}
