part of '../../mentorx_core.dart';

enum ParentLookupType { phone, studentCode }

enum ParentChildLinkStatus { verified, pending }

final class ParentStudentLookupEntity extends Equatable {
  final String studentId;
  final String firstNameMasked;
  final String lastNameMasked;
  final String gradeName;
  final String tenantName;
  final String tenantId;
  final String? profilePhotoUrl;
  final bool canAutoVerify;

  const ParentStudentLookupEntity({
    required this.studentId,
    required this.firstNameMasked,
    required this.lastNameMasked,
    required this.gradeName,
    required this.tenantName,
    required this.tenantId,
    this.profilePhotoUrl,
    required this.canAutoVerify,
  });

  String get maskedFullName => '$firstNameMasked $lastNameMasked'.trim();

  @override
  List<Object?> get props => [
    studentId,
    firstNameMasked,
    lastNameMasked,
    gradeName,
    tenantName,
    tenantId,
    profilePhotoUrl,
    canAutoVerify,
  ];
}

final class ParentRegistrationResult extends Equatable {
  final String userId;
  final String status;
  final ParentChildLinkStatus childLinkStatus;
  final int? otpExpiresInSeconds;
  final String? phone;

  const ParentRegistrationResult({
    required this.userId,
    required this.status,
    required this.childLinkStatus,
    this.otpExpiresInSeconds,
    this.phone,
  });

  @override
  List<Object?> get props => [
    userId,
    status,
    childLinkStatus,
    otpExpiresInSeconds,
    phone,
  ];
}
