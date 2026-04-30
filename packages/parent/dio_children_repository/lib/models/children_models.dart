import 'package:mentorx_core/mentorx_core.dart';

final class ParentChildModel extends ParentChildEntity {
  const ParentChildModel({
    required super.id,
    required super.name,
    super.gradeName,
    super.profileImageUrl,
    super.studentCode,
    super.centerName,
    super.isVerified,
  });

  factory ParentChildModel.fromJson(Map<String, dynamic> json) {
    return ParentChildModel(
      id: ModelParser.asString(json['childId'] ?? json['id'] ?? json['student_id']),
      name: ModelParser.asString(json['name'] ?? '${json['firstName'] ?? ''} ${json['lastName'] ?? ''}').trim(),
      gradeName: ModelParser.asString(json['grade'] ?? json['gradeName'] ?? json['grade_name']),
      profileImageUrl: ModelParser.asString(json['profileImageUrl'] ?? json['profile_image_url'] ?? json['avatarUrl']),
      studentCode: ModelParser.asString(json['studentCode'] ?? json['student_code']),
      centerName: ModelParser.asString(json['centerName'] ?? json['tenantName'] ?? json['center_name']),
      isVerified: ModelParser.asBool(json['isVerified'] ?? json['is_verified'] ?? (json['linkStatus'] == 'verified')),
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
      maskedName: ModelParser.asString(json['masked_name'] ?? json['maskedName'] ?? '${json['first_name_masked'] ?? ''} ${json['last_name_masked'] ?? ''}').trim(),
      gradeName: ModelParser.asString(json['grade_name'] ?? json['gradeName']),
      centerName: ModelParser.asString(json['center_name'] ?? json['tenantName'] ?? json['tenant_name']),
      profilePhotoUrl: ModelParser.asString(json['profile_photo_url'] ?? json['profilePhotoUrl'] ?? json['avatar_url']),
      canAutoVerify: ModelParser.asBool(json['can_auto_verify'] ?? json['canAutoVerify']),
    );
  }
}
