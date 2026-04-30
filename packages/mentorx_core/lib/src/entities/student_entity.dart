part of 'package:mentorx_core/mentorx_core.dart';

enum StudentStatus { active, inactive, pending, suspended, rejected }

enum Gender { male, female }

enum StudyType { center, online, hybrid }

class StudentEntity extends Equatable {
  final String id;
  final String firstName;
  final String? secondName;
  final String? thirdName;
  final String? fourthName;
  final String lastName;
  final String? email;
  final String phoneNumber;
  final String? profileImageUrl;
  final String? identityDocumentUrl;
  final Gender gender;
  final StudentStatus status;
  final String? gradeId;
  final String? gradeName;
  final String? studentCode;
  final String? studyType;
  final String? studyLocation;
  final double walletBalance;
  final int totalPoints;
  final String? schoolName;
  final String? educationDepartment;
  final String? centerId;
  final String? centerName;
  final String? parentName;
  final String? parentPhone;
  final String? academicLevel;
  final DateTime? dateOfBirth;
  final String? address;
  final String? city;
  final String? area;
  final String? governorate;
  final bool? isOnline;
  final bool? enabled;
  final bool? hasActiveSession;
  final int? devicesCount;
  final int? loginCount;
  final DateTime? lastLoginAt;
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
    this.secondName,
    this.thirdName,
    this.fourthName,
    this.email,
    this.profileImageUrl,
    this.identityDocumentUrl,
    this.gender = Gender.male,
    this.gradeId,
    this.gradeName,
    this.studentCode,
    this.studyType,
    this.studyLocation,
    this.walletBalance = 0.0,
    this.totalPoints = 0,
    this.schoolName,
    this.educationDepartment,
    this.centerId,
    this.centerName,
    this.parentName,
    this.parentPhone,
    this.academicLevel,
    this.dateOfBirth,
    this.address,
    this.city,
    this.area,
    this.governorate,
    this.isOnline,
    this.enabled,
    this.hasActiveSession,
    this.devicesCount,
    this.loginCount,
    this.lastLoginAt,
    this.enrolledCourseIds,
    this.metadata,
  });

  String get fullName {
    final parts = [firstName, secondName, thirdName, fourthName, lastName]
        .where((p) => p != null && p.isNotEmpty)
        .toList();
    return parts.join(' ').trim();
  }

  String get shortName {
    if (fourthName != null && fourthName!.isNotEmpty) {
      return '$firstName $fourthName';
    }
    return '$firstName $lastName'.trim();
  }

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
        secondName,
        thirdName,
        fourthName,
        lastName,
        email,
        phoneNumber,
        profileImageUrl,
        identityDocumentUrl,
        gender,
        status,
        gradeId,
        gradeName,
        studentCode,
        studyType,
        studyLocation,
        walletBalance,
        totalPoints,
        schoolName,
        educationDepartment,
        centerId,
        centerName,
        parentName,
        parentPhone,
        academicLevel,
        dateOfBirth,
        address,
        city,
        area,
        governorate,
        isOnline,
        enabled,
        hasActiveSession,
        devicesCount,
        loginCount,
        lastLoginAt,
        enrolledCourseIds,
        metadata,
        createdAt,
        updatedAt,
      ];

  StudentEntity copyWith({
    String? id,
    String? firstName,
    String? secondName,
    String? thirdName,
    String? fourthName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    String? identityDocumentUrl,
    Gender? gender,
    StudentStatus? status,
    String? gradeId,
    String? gradeName,
    String? studentCode,
    String? studyType,
    String? studyLocation,
    double? walletBalance,
    int? totalPoints,
    String? schoolName,
    String? educationDepartment,
    String? centerId,
    String? centerName,
    String? parentName,
    String? parentPhone,
    String? academicLevel,
    DateTime? dateOfBirth,
    String? address,
    String? city,
    String? area,
    String? governorate,
    bool? isOnline,
    bool? enabled,
    bool? hasActiveSession,
    int? devicesCount,
    int? loginCount,
    DateTime? lastLoginAt,
    List<String>? enrolledCourseIds,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      thirdName: thirdName ?? this.thirdName,
      fourthName: fourthName ?? this.fourthName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      identityDocumentUrl: identityDocumentUrl ?? this.identityDocumentUrl,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      gradeId: gradeId ?? this.gradeId,
      gradeName: gradeName ?? this.gradeName,
      studentCode: studentCode ?? this.studentCode,
      studyType: studyType ?? this.studyType,
      studyLocation: studyLocation ?? this.studyLocation,
      walletBalance: walletBalance ?? this.walletBalance,
      totalPoints: totalPoints ?? this.totalPoints,
      schoolName: schoolName ?? this.schoolName,
      educationDepartment: educationDepartment ?? this.educationDepartment,
      centerId: centerId ?? this.centerId,
      centerName: centerName ?? this.centerName,
      parentName: parentName ?? this.parentName,
      parentPhone: parentPhone ?? this.parentPhone,
      academicLevel: academicLevel ?? this.academicLevel,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      city: city ?? this.city,
      area: area ?? this.area,
      governorate: governorate ?? this.governorate,
      isOnline: isOnline ?? this.isOnline,
      enabled: enabled ?? this.enabled,
      hasActiveSession: hasActiveSession ?? this.hasActiveSession,
      devicesCount: devicesCount ?? this.devicesCount,
      loginCount: loginCount ?? this.loginCount,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
