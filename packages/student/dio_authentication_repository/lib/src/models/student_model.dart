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

  factory StudentModel.fromEntity(StudentEntity entity) {
    return StudentModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNumber: entity.phoneNumber,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      email: entity.email,
      profileImageUrl: entity.profileImageUrl,
      gender: entity.gender,
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
    );
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? json;

    final String name = user['name'] as String? ?? '';
    final nameParts = name.trim().split(' ');
    final String fallbackFirst = nameParts.first;
    final String fallbackLast = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return StudentModel(
      id: (user['id'] ?? user['userId'])?.toString() ?? '',
      firstName: user['firstName'] as String? ??
          user['first_name'] as String? ??
          fallbackFirst,
      lastName: user['lastName'] as String? ??
          user['last_name'] as String? ??
          fallbackLast,
      email: user['email'] as String?,
      phoneNumber: (user['phone'] ?? user['phoneNumber'] ?? user['phone_number'])
              ?.toString() ??
          '',
      profileImageUrl: (user['profileImageUrl'] ??
              user['profileImage'] ??
              user['avatarUrl'] ??
              user['profile_photo_url'])
          ?.toString(),
      gender: _parseGender(user['gender']),
      status: _parseStatus(user['status']),
      gradeId: (user['gradeId'] ?? user['grade_id'])?.toString(),
      gradeName: (user['gradeName'] ?? user['grade_name'] ?? user['grade'])?.toString(),
      studentCode: (user['studentCode'] ?? user['student_code'])?.toString(),
      studyType: (user['studyType'] ?? user['study_type'])?.toString(),
      walletBalance: (user['walletBalance'] ?? user['wallet_balance'] ?? 0.0)
          .toDouble(),
      totalPoints: (user['totalPoints'] ?? user['total_points'] ?? 0).toInt(),
      schoolName: (user['schoolName'] ?? user['school_name'])?.toString(),
      centerId: (user['centerId'] ?? user['center_id'])?.toString(),
      centerName: (user['centerName'] ?? user['center_name'] ?? user['center'])?.toString(),
      parentName: (user['parentName'] ?? user['parent_name'])?.toString(),
      parentPhone: (user['parentPhone'] ?? user['parent_phone'])?.toString(),
      academicLevel: (user['academicLevel'] ?? user['academic_level'])?.toString(),
      dateOfBirth: DateTime.tryParse(
          (user['dateOfBirth'] ?? user['date_of_birth'])?.toString() ?? ''),
      address: user['address']?.toString(),
      city: user['city']?.toString(),
      governorate: user['governorate']?.toString(),
      enrolledCourseIds: (user['enrolledCourseIds'] ?? user['enrolled_course_ids'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      metadata: user['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.tryParse(
              (user['createdAt'] ?? user['created_at'])?.toString() ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(
              (user['updatedAt'] ?? user['updated_at'])?.toString() ?? '') ??
          DateTime.now(),
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'gender': gender.name,
      'status': status.name,
      'gradeId': gradeId,
      'gradeName': gradeName,
      'studentCode': studentCode,
      'studyType': studyType,
      'walletBalance': walletBalance,
      'totalPoints': totalPoints,
      'schoolName': schoolName,
      'centerId': centerId,
      'centerName': centerName,
      'parentName': parentName,
      'parentPhone': parentPhone,
      'academicLevel': academicLevel,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'address': address,
      'city': city,
      'governorate': governorate,
      'enrolledCourseIds': enrolledCourseIds,
      'metadata': metadata,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
