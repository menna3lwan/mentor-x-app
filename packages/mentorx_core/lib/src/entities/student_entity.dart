part of '../../mentorx_core.dart';

enum StudentStatus { pending, active, blocked, suspended, rejected }

enum StudyType { online, center, both }

enum Gender { male, female }

final class StudentEntity extends Equatable {
  final String id;
  final String name;
  final String? email;
  final String phoneNumber;
  final String? studentCode;
  final StudentStatus status;
  final Gender? gender;
  final DateTime? dateOfBirth;
  final String? gradeId;
  final String? gradeName;
  final StudyType? studyType;
  final String? profileImageUrl;
  final double walletBalance;
  final int totalPoints;
  final String? schoolName;
  final String? parentName;
  final String? parentPhone;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StudentEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    this.email,
    this.studentCode,
    this.status = StudentStatus.active,
    this.gender,
    this.dateOfBirth,
    this.gradeId,
    this.gradeName,
    this.studyType,
    this.profileImageUrl,
    this.walletBalance = 0,
    this.totalPoints = 0,
    this.schoolName,
    this.parentName,
    this.parentPhone,
  });


  static final placeholder = StudentEntity(
    id: '',
    name: '',
    phoneNumber: '',
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );
  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        studentCode,
        status,
        gender,
        dateOfBirth,
        gradeId,
        gradeName,
        studyType,
        profileImageUrl,
        walletBalance,
        totalPoints,
        schoolName,
        parentName,
        parentPhone,
        createdAt,
        updatedAt,
      ];

  StudentEntity copyWith({
    String? id,
    String? name,
    MentorXNullableValue<String?>? email,
    String? phoneNumber,
    MentorXNullableValue<String?>? studentCode,
    StudentStatus? status,
    MentorXNullableValue<Gender?>? gender,
    MentorXNullableValue<DateTime?>? dateOfBirth,
    MentorXNullableValue<String?>? gradeId,
    MentorXNullableValue<String?>? gradeName,
    MentorXNullableValue<StudyType?>? studyType,
    MentorXNullableValue<String?>? profileImageUrl,
    double? walletBalance,
    int? totalPoints,
    MentorXNullableValue<String?>? schoolName,
    MentorXNullableValue<String?>? parentName,
    MentorXNullableValue<String?>? parentPhone,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email != null ? email.value : this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      studentCode: studentCode != null ? studentCode.value : this.studentCode,
      status: status ?? this.status,
      gender: gender != null ? gender.value : this.gender,
      dateOfBirth: dateOfBirth != null ? dateOfBirth.value : this.dateOfBirth,
      gradeId: gradeId != null ? gradeId.value : this.gradeId,
      gradeName: gradeName != null ? gradeName.value : this.gradeName,
      studyType: studyType != null ? studyType.value : this.studyType,
      profileImageUrl: profileImageUrl != null ? profileImageUrl.value : this.profileImageUrl,
      walletBalance: walletBalance ?? this.walletBalance,
      totalPoints: totalPoints ?? this.totalPoints,
      schoolName: schoolName != null ? schoolName.value : this.schoolName,
      parentName: parentName != null ? parentName.value : this.parentName,
      parentPhone: parentPhone != null ? parentPhone.value : this.parentPhone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
