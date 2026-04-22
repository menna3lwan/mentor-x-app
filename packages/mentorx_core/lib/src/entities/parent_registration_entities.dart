part of 'package:mentorx_core/mentorx_core.dart';

base class ParentStudentLookupEntity extends Equatable {
  final String studentId;
  final String maskedName;
  final String gradeName;
  final String centerName;
  final String? profilePhotoUrl;
  final bool canAutoVerify;

  const ParentStudentLookupEntity({
    required this.studentId,
    required this.maskedName,
    required this.gradeName,
    required this.centerName,
    this.profilePhotoUrl,
    required this.canAutoVerify,
  });

  @override
  List<Object?> get props => [
        studentId,
        maskedName,
        gradeName,
        centerName,
        profilePhotoUrl,
        canAutoVerify,
      ];
}

base class ParentRegistrationResult extends Equatable {
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
