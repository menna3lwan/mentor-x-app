part of 'package:mentorx_core/mentorx_core.dart';

enum StudentStatus { active, inactive, pending, suspended, rejected }

enum Gender { male, female }

enum StudyType { center, online, hybrid }

base class StudentEntity extends Equatable {
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
    MentorXNullableValue<String?>? secondName,
    MentorXNullableValue<String?>? thirdName,
    MentorXNullableValue<String?>? fourthName,
    String? lastName,
    MentorXNullableValue<String?>? email,
    String? phoneNumber,
    MentorXNullableValue<String?>? profileImageUrl,
    MentorXNullableValue<String?>? identityDocumentUrl,
    Gender? gender,
    StudentStatus? status,
    MentorXNullableValue<String?>? gradeId,
    MentorXNullableValue<String?>? gradeName,
    MentorXNullableValue<String?>? studentCode,
    MentorXNullableValue<String?>? studyType,
    MentorXNullableValue<String?>? studyLocation,
    double? walletBalance,
    int? totalPoints,
    MentorXNullableValue<String?>? schoolName,
    MentorXNullableValue<String?>? educationDepartment,
    MentorXNullableValue<String?>? centerId,
    MentorXNullableValue<String?>? centerName,
    MentorXNullableValue<String?>? parentName,
    MentorXNullableValue<String?>? parentPhone,
    MentorXNullableValue<String?>? academicLevel,
    MentorXNullableValue<DateTime?>? dateOfBirth,
    MentorXNullableValue<String?>? address,
    MentorXNullableValue<String?>? city,
    MentorXNullableValue<String?>? area,
    MentorXNullableValue<String?>? governorate,
    MentorXNullableValue<bool?>? isOnline,
    MentorXNullableValue<bool?>? enabled,
    MentorXNullableValue<bool?>? hasActiveSession,
    MentorXNullableValue<int?>? devicesCount,
    MentorXNullableValue<int?>? loginCount,
    MentorXNullableValue<DateTime?>? lastLoginAt,
    MentorXNullableValue<List<String>?>? enrolledCourseIds,
    MentorXNullableValue<Map<String, dynamic>?>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      secondName: secondName != null ? secondName.value : this.secondName,
      thirdName: thirdName != null ? thirdName.value : this.thirdName,
      fourthName: fourthName != null ? fourthName.value : this.fourthName,
      lastName: lastName ?? this.lastName,
      email: email != null ? email.value : this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl != null ? profileImageUrl.value : this.profileImageUrl,
      identityDocumentUrl: identityDocumentUrl != null ? identityDocumentUrl.value : this.identityDocumentUrl,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      gradeId: gradeId != null ? gradeId.value : this.gradeId,
      gradeName: gradeName != null ? gradeName.value : this.gradeName,
      studentCode: studentCode != null ? studentCode.value : this.studentCode,
      studyType: studyType != null ? studyType.value : this.studyType,
      studyLocation: studyLocation != null ? studyLocation.value : this.studyLocation,
      walletBalance: walletBalance ?? this.walletBalance,
      totalPoints: totalPoints ?? this.totalPoints,
      schoolName: schoolName != null ? schoolName.value : this.schoolName,
      educationDepartment: educationDepartment != null ? educationDepartment.value : this.educationDepartment,
      centerId: centerId != null ? centerId.value : this.centerId,
      centerName: centerName != null ? centerName.value : this.centerName,
      parentName: parentName != null ? parentName.value : this.parentName,
      parentPhone: parentPhone != null ? parentPhone.value : this.parentPhone,
      academicLevel: academicLevel != null ? academicLevel.value : this.academicLevel,
      dateOfBirth: dateOfBirth != null ? dateOfBirth.value : this.dateOfBirth,
      address: address != null ? address.value : this.address,
      city: city != null ? city.value : this.city,
      area: area != null ? area.value : this.area,
      governorate: governorate != null ? governorate.value : this.governorate,
      isOnline: isOnline != null ? isOnline.value : this.isOnline,
      enabled: enabled != null ? enabled.value : this.enabled,
      hasActiveSession: hasActiveSession != null ? hasActiveSession.value : this.hasActiveSession,
      devicesCount: devicesCount != null ? devicesCount.value : this.devicesCount,
      loginCount: loginCount != null ? loginCount.value : this.loginCount,
      lastLoginAt: lastLoginAt != null ? lastLoginAt.value : this.lastLoginAt,
      enrolledCourseIds: enrolledCourseIds != null ? enrolledCourseIds.value : this.enrolledCourseIds,
      metadata: metadata != null ? metadata.value : this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
