import 'package:mentorx_core/mentorx_core.dart';

abstract final class StudentModel {
  static StudentEntity fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? json;
    
    return StudentEntity(
      id: (user['id'] ?? user['userId'])?.toString() ?? '',
      name: user['name'] as String? ?? 
            ((user['firstName'] != null || user['lastName'] != null) 
              ? '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}'.trim() 
              : ''),
      phoneNumber: user['phone'] as String? ?? user['phoneNumber'] as String? ?? '',
      email: user['email'] as String?,
      studentCode: user['studentCode'] as String?,
      status: _studentStatusFromJson(user['status']),
      gender: _genderFromJson(user['gender']),
      dateOfBirth: user['dateOfBirth'] != null ? DateTime.tryParse(user['dateOfBirth'] as String) : null,
      gradeId: user['gradeId']?.toString(),
      gradeName: user['gradeName'] as String?,
      studyType: _studyTypeFromJson(user['studyType']),
      profileImageUrl: user['profileImageUrl'] as String? ?? user['profileImage'] as String?,
      walletBalance: (user['walletBalance'] as num?)?.toDouble() ?? 0.0,
      totalPoints: (user['totalPoints'] as num?)?.toInt() ?? 0,
      schoolName: user['schoolName'] as String?,
      parentName: user['parentName'] as String?,
      parentPhone: user['parentPhone'] as String?,
      createdAt: user['createdAt'] != null ? DateTime.parse(user['createdAt'] as String) : DateTime.now(),
      updatedAt: user['updatedAt'] != null ? DateTime.parse(user['updatedAt'] as String) : DateTime.now(),
    );
  }

  static StudentStatus _studentStatusFromJson(dynamic status) {
    if (status == null) return StudentStatus.active;
    final statusStr = status.toString().toLowerCase();
    return StudentStatus.values.firstWhere(
      (e) => e.name == statusStr,
      orElse: () => StudentStatus.active,
    );
  }

  static Gender? _genderFromJson(dynamic gender) {
    if (gender == null) return null;
    final genderStr = gender.toString().toLowerCase();
    for (final value in Gender.values) {
      if (value.name == genderStr) return value;
    }
    return null;
  }

  static StudyType? _studyTypeFromJson(dynamic type) {
    if (type == null) return null;
    final typeStr = type.toString().toLowerCase();
    for (final value in StudyType.values) {
      if (value.name == typeStr) return value;
    }
    return null;
  }

  static Map<String, dynamic> toJson(StudentEntity entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'phoneNumber': entity.phoneNumber,
      'email': entity.email,
      'studentCode': entity.studentCode,
      'status': entity.status.name,
      'gender': entity.gender?.name,
      'dateOfBirth': entity.dateOfBirth?.toIso8601String(),
      'gradeId': entity.gradeId,
      'gradeName': entity.gradeName,
      'studyType': entity.studyType?.name,
      'profileImageUrl': entity.profileImageUrl,
      'walletBalance': entity.walletBalance,
      'totalPoints': entity.totalPoints,
      'schoolName': entity.schoolName,
      'parentName': entity.parentName,
      'parentPhone': entity.parentPhone,
      'createdAt': entity.createdAt.toIso8601String(),
      'updatedAt': entity.updatedAt.toIso8601String(),
    };
  }
}
