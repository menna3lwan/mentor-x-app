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
      id: ModelParser.asString(json['id']),
      fieldName: ModelParser.asString(json['fieldName'] ?? json['field_name']),
      oldValue: ModelParser.asString(json['oldValue'] ?? json['old_value']),
      newValue: ModelParser.asString(json['newValue'] ?? json['new_value']),
      reason: ModelParser.asString(json['reason']),
      status: _parseStatus(json['status']),
      reviewNotes: ModelParser.asString(json['reviewNotes'] ?? json['review_notes']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at']) ?? DateTime.now(),
    );
  }

  static EditRequestStatus _parseStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    return EditRequestStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => EditRequestStatus.pending,
    );
  }
}

