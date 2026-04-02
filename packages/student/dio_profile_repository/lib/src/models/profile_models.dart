import 'package:mentorx_core/mentorx_core.dart';

final class ProfileEditRequestModel extends ProfileEditRequestEntity {
  const ProfileEditRequestModel({
    required super.id,
    required super.fieldName,
    required super.oldValue,
    required super.newValue,
    super.reason,
    required super.status,
    super.reviewNotes,
    required super.createdAt,
  });

  factory ProfileEditRequestModel.fromJson(Map<String, dynamic> json) {
    return ProfileEditRequestModel(
      id: json['id']?.toString() ?? '',
      fieldName: (json['fieldName'] ?? json['field_name']) as String? ?? '',
      oldValue: (json['oldValue'] ?? json['old_value']) as String? ?? '',
      newValue: (json['newValue'] ?? json['new_value']) as String? ?? '',
      reason: json['reason'] as String?,
      status: _parseStatus(json['status']),
      reviewNotes: (json['reviewNotes'] ?? json['review_notes']) as String?,
      createdAt: DateTime.parse((json['createdAt'] ?? json['created_at']) as String),
    );
  }

  static EditRequestStatus _parseStatus(dynamic value) {
    final str = value?.toString().toLowerCase();
    return EditRequestStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => EditRequestStatus.pending,
    );
  }
}

final class NationalIdVerificationModel extends NationalIdVerificationEntity {
  const NationalIdVerificationModel({
    required super.status,
    super.idCardPhotoUrl,
    super.verifiedAt,
    super.rejectionReason,
  });

  factory NationalIdVerificationModel.fromJson(Map<String, dynamic> json) {
    return NationalIdVerificationModel(
      status: _parseStatus(json['status']),
      idCardPhotoUrl: (json['idCardPhotoUrl'] ?? json['id_card_photo_url']) as String?,
      verifiedAt: (json['verifiedAt'] ?? json['verified_at']) != null 
          ? DateTime.tryParse((json['verifiedAt'] ?? json['verified_at']) as String) 
          : null,
      rejectionReason: (json['rejectionReason'] ?? json['rejection_reason']) as String?,
    );
  }

  static VerificationStatus _parseStatus(dynamic value) {
    final str = value?.toString().toLowerCase();
    return VerificationStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => VerificationStatus.pending,
    );
  }
}
