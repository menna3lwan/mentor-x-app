part of 'package:mentorx_core/mentorx_core.dart';

enum VerificationStatus { pending, verified, rejected }

base class NationalIdVerificationEntity extends Equatable {
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

  static final placeholder = NationalIdVerificationEntity(
    status: VerificationStatus.pending,
  );

  @override
  List<Object?> get props => [
        status,
        idCardPhotoUrl,
        verifiedAt,
        rejectionReason,
      ];

  NationalIdVerificationEntity copyWith({
    VerificationStatus? status,
    String? idCardPhotoUrl,
    DateTime? verifiedAt,
    String? rejectionReason,
  }) {
    return NationalIdVerificationEntity(
      status: status ?? this.status,
      idCardPhotoUrl: idCardPhotoUrl ?? this.idCardPhotoUrl,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }
}
