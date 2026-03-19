import 'package:student_core/student_core.dart';

abstract final class ProfileEditRequestModel {
  static ProfileEditRequestEntity fromJson(Map<String, dynamic> json) {
    return ProfileEditRequestEntity(
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

abstract final class NationalIdVerificationModel {
  static NationalIdVerificationEntity fromJson(Map<String, dynamic> json) {
    return NationalIdVerificationEntity(
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
