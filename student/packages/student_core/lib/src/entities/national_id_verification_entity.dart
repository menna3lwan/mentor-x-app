part of '../../student_core.dart';

enum VerificationStatus { pending, verified, rejected }

final class NationalIdVerificationEntity extends Equatable {
  final VerificationStatus status;
  final String? idCardPhotoUrl;
  final DateTime? verifiedAt;
  final String? rejectionReason;

  const NationalIdVerificationEntity({
    required this.status,
    this.idCardPhotoUrl,
    this.verifiedAt,
    this.rejectionReason,
  });

  bool get isVerified => status == VerificationStatus.verified;

  @override
  List<Object?> get props => [
        status,
        idCardPhotoUrl,
        verifiedAt,
        rejectionReason,
      ];
}
