import 'package:mentorx_core/mentorx_core.dart';

final class ParentChildModel extends ParentChildEntity {
  const ParentChildModel({
    required super.id,
    required super.name,
    super.studentCode,
    super.profileImageUrl,
    super.gradeName,
    super.centerName,
    super.isVerified,
  });

  factory ParentChildModel.fromJson(Map<String, dynamic> json) {
    return ParentChildModel(
      id: ModelParser.asString(json['id'] ?? json['student_id']),
      name: ModelParser.asString(json['name'] ?? json['full_name']),
      studentCode: ModelParser.asString(json['student_code']),
      profileImageUrl: ModelParser.asString(
        json['profileImageUrl'] ?? json['image_url'] ?? json['avatarUrl'] ?? json['profile_photo_url'],
      ),
      gradeName: ModelParser.asString(json['grade_name'] ?? json['grade']),
      centerName: ModelParser.asString(json['center_name'] ?? json['center']),
      isVerified: ModelParser.asBool(json['is_verified'] ?? json['verified']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'student_code': studentCode,
        'profile_photo_url': profileImageUrl,
        'grade_name': gradeName,
        'center_name': centerName,
        'is_verified': isVerified,
      };

  factory ParentChildModel.fromEntity(ParentChildEntity entity) {
    return ParentChildModel(
      id: entity.id,
      name: entity.name,
      studentCode: entity.studentCode,
      profileImageUrl: entity.profileImageUrl,
      gradeName: entity.gradeName,
      centerName: entity.centerName,
      isVerified: entity.isVerified,
    );
  }
}

final class ParentStudentLookupModel extends ParentStudentLookupEntity {
  const ParentStudentLookupModel({
    required super.studentId,
    required super.maskedName,
    required super.gradeName,
    required super.centerName,
    super.profilePhotoUrl,
    required super.canAutoVerify,
  });

  factory ParentStudentLookupModel.fromJson(Map<String, dynamic> json) {
    return ParentStudentLookupModel(
      studentId: ModelParser.asString(json['student_id'] ?? json['id']),
      maskedName: ModelParser.asString(json['masked_name'] ?? json['name']),
      gradeName: ModelParser.asString(json['grade_name'] ?? json['grade']),
      centerName: ModelParser.asString(json['center_name'] ?? json['center']),
      profilePhotoUrl: ModelParser.asString(
        json['profilePhotoUrl'] ?? json['profile_photo_url'] ?? json['image_url'],
      ),
      canAutoVerify: ModelParser.asBool(json['can_auto_verify']),
    );
  }

  Map<String, dynamic> toJson() => {
        'student_id': studentId,
        'masked_name': maskedName,
        'grade_name': gradeName,
        'center_name': centerName,
        'profile_photo_url': profilePhotoUrl,
        'can_auto_verify': canAutoVerify,
      };

  factory ParentStudentLookupModel.fromEntity(ParentStudentLookupEntity entity) {
    return ParentStudentLookupModel(
      studentId: entity.studentId,
      maskedName: entity.maskedName,
      gradeName: entity.gradeName,
      centerName: entity.centerName,
      profilePhotoUrl: entity.profilePhotoUrl,
      canAutoVerify: entity.canAutoVerify,
    );
  }
}
