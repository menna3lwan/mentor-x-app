part of 'package:mentorx_core/mentorx_core.dart';

enum StudentStatus { active, inactive, pending, suspended }

enum Gender { male, female }

enum StudyType { center, online, hybrid }

class StudentEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final String phoneNumber;
  final String? profileImageUrl;
  final Gender gender;
  final StudentStatus status;
  final String? gradeId;
  final String? gradeName;
  final String? studentCode;
  final String? studyType;
  final double walletBalance;
  final int totalPoints;
  final String? schoolName;
  final String? centerId;
  final String? centerName;
  final String? parentName;
  final String? parentPhone;
  final String? academicLevel;
  final DateTime? dateOfBirth;
  final String? address;
  final String? city;
  final String? governorate;
  final List<String>? enrolledCourseIds;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StudentEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.email,
    this.profileImageUrl,
    this.gender = Gender.male,
    this.gradeId,
    this.gradeName,
    this.studentCode,
    this.studyType,
    this.walletBalance = 0.0,
    this.totalPoints = 0,
    this.schoolName,
    this.centerId,
    this.centerName,
    this.parentName,
    this.parentPhone,
    this.academicLevel,
    this.dateOfBirth,
    this.address,
    this.city,
    this.governorate,
    this.enrolledCourseIds,
    this.metadata,
  });

  String get fullName => '$firstName $lastName'.trim();

  static final placeholder = StudentEntity(
    id: '',
    firstName: '',
    lastName: '',
    phoneNumber: '',
    status: StudentStatus.pending,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phoneNumber,
        profileImageUrl,
        gender,
        status,
        gradeId,
        gradeName,
        studentCode,
        studyType,
        walletBalance,
        totalPoints,
        schoolName,
        centerId,
        centerName,
        parentName,
        parentPhone,
        academicLevel,
        dateOfBirth,
        address,
        city,
        governorate,
        enrolledCourseIds,
        metadata,
        createdAt,
        updatedAt,
      ];

  StudentEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    Gender? gender,
    StudentStatus? status,
    String? gradeId,
    String? gradeName,
    String? studentCode,
    String? studyType,
    double? walletBalance,
    int? totalPoints,
    String? schoolName,
    String? centerId,
    String? centerName,
    String? parentName,
    String? parentPhone,
    String? academicLevel,
    DateTime? dateOfBirth,
    String? address,
    String? city,
    String? governorate,
    List<String>? enrolledCourseIds,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      gradeId: gradeId ?? this.gradeId,
      gradeName: gradeName ?? this.gradeName,
      studentCode: studentCode ?? this.studentCode,
      studyType: studyType ?? this.studyType,
      walletBalance: walletBalance ?? this.walletBalance,
      totalPoints: totalPoints ?? this.totalPoints,
      schoolName: schoolName ?? this.schoolName,
      centerId: centerId ?? this.centerId,
      centerName: centerName ?? this.centerName,
      parentName: parentName ?? this.parentName,
      parentPhone: parentPhone ?? this.parentPhone,
      academicLevel: academicLevel ?? this.academicLevel,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      city: city ?? this.city,
      governorate: governorate ?? this.governorate,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
