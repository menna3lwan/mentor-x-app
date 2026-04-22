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
      id: (json['childId'] ?? json['id'] ?? json['student_id'])?.toString() ?? '',
      name: (json['name'] ?? '${json['firstName'] ?? ''} ${json['lastName'] ?? ''}').toString().trim(),
      gradeName: (json['grade'] ?? json['gradeName'] ?? json['grade_name'])?.toString() ?? '',
      profileImageUrl: (json['profileImageUrl'] ?? json['profile_image_url'] ?? json['avatarUrl'])?.toString(),
      studentCode: (json['studentCode'] ?? json['student_code'])?.toString(),
      centerName: (json['centerName'] ?? json['tenantName'] ?? json['center_name'])?.toString(),
      isVerified: json['isVerified'] ?? json['is_verified'] ?? json['linkStatus'] == 'verified',
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
      studentId: (json['student_id'] ?? json['id'])?.toString() ?? '',
      maskedName: (json['masked_name'] ?? json['maskedName'] ?? '${json['first_name_masked'] ?? ''} ${json['last_name_masked'] ?? ''}').toString().trim(),
      gradeName: (json['grade_name'] ?? json['gradeName'] ?? '').toString(),
      centerName: (json['center_name'] ?? json['tenantName'] ?? json['tenant_name'] ?? '').toString(),
      profilePhotoUrl: (json['profile_photo_url'] ?? json['profilePhotoUrl'] ?? json['avatar_url'])?.toString(),
      canAutoVerify: json['can_auto_verify'] ?? json['canAutoVerify'] ?? false,
    );
  }
}
