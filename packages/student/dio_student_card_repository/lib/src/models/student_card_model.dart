import 'package:mentorx_core/mentorx_core.dart';

final class StudentCardModel extends StudentCardEntity {
  const StudentCardModel({
    required super.id,
    required super.studentName,
    required super.studentCode,
    required super.qrToken,
    required super.issuedAt,
    super.expiresAt,
    super.grade,
    super.school,
    super.center,
    super.profileImageUrl,
  });

  factory StudentCardModel.fromJson(Map<String, dynamic> json) {
    return StudentCardModel(
      id: ModelParser.asString(json['id']),
      studentName: ModelParser.asString(json['studentName'] ?? json['student_name']),
      studentCode: ModelParser.asString(json['studentCode'] ?? json['student_code']),
      qrToken: ModelParser.asString(json['qrToken'] ?? json['qr_token']),
      issuedAt: ModelParser.asDateTime(json['issuedAt'] ?? json['issued_at']) ?? DateTime.now(),
      expiresAt: ModelParser.asDateTime(json['expiresAt'] ?? json['expires_at']),
      grade: ModelParser.asString(json['grade']),
      school: ModelParser.asString(json['school']),
      center: ModelParser.asString(json['center']),
      profileImageUrl: ModelParser.asString(json['profileImageUrl'] ?? json['profile_image_url']),
    );
  }
}
