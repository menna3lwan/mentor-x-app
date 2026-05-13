import 'package:mentorx_core/mentorx_core.dart';

final class ParentProfileModel extends ParentEntity {
  const ParentProfileModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.profileImageUrl,
    super.childrenCount,
    super.walletBalance,
    super.totalPoints,
    super.metadata,
  });

  factory ParentProfileModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.asMap(json['data'] ?? json);

    final String name = ModelParser.asString(data['name'] ?? data['fullName']);
    final nameParts = name.trim().split(' ');
    final String first = nameParts.isNotEmpty ? nameParts.first : '';
    final String last = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return ParentProfileModel(
      id: ModelParser.asString(data['id'] ?? data['userId']),
      firstName: ModelParser.asString(data['firstName'], fallback: first),
      lastName: ModelParser.asString(data['lastName'], fallback: last),
      email: ModelParser.asString(data['email']),
      phoneNumber: ModelParser.asString(data['phone'] ?? data['phoneNumber']),
      profileImageUrl: ModelParser.asString(data['profileImageUrl'] ?? data['image_url']),
      status: _parseStatus(data['status']),
      childrenCount: ModelParser.asInt(data['childrenCount'] ?? data['students'] is List ? (data['students'] as List).length : 0),
      walletBalance: ModelParser.asDouble(data['walletBalance'] ?? data['balance']),
      totalPoints: ModelParser.asInt(data['totalPoints'] ?? data['points']),
      metadata: ModelParser.asMap(data['metadata']),
      createdAt: ModelParser.asDateTime(data['createdAt'] ?? data['created_at']) ?? DateTime.now(),
      updatedAt: ModelParser.asDateTime(data['updatedAt'] ?? data['updated_at']) ?? DateTime.now(),
    );
  }

  static ParentStatus _parseStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    if (str == 'active' || str == 'approved') return ParentStatus.active;
    return ParentStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => ParentStatus.active,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': '$firstName $lastName'.trim(),
    };
  }
}

