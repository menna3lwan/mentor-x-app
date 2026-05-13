part of 'package:mentorx_core/mentorx_core.dart';

base class StudentCardEntity extends Equatable {
  final String id;
  final String studentName;
  final String studentCode;
  final String qrToken;
  final DateTime issuedAt;
  final DateTime? expiresAt;
  final String? grade;
  final String? school;
  final String? center;
  final String? profileImageUrl;

  const StudentCardEntity({
    required this.id,
    required this.studentName,
    required this.studentCode,
    required this.qrToken,
    required this.issuedAt,
    this.expiresAt,
    this.grade,
    this.school,
    this.center,
    this.profileImageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        studentName,
        studentCode,
        qrToken,
        issuedAt,
        expiresAt,
        grade,
        school,
        center,
        profileImageUrl,
      ];
}
