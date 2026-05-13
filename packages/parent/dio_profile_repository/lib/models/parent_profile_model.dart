import 'package:mentorx_core/mentorx_core.dart';

class ParentProfileModel extends ParentEntity {
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
    return ParentProfileModel(
      id: json['id'] as String? ?? '',
      firstName: json['firstName'] ?? json['first_name'] ?? '',
      lastName: json['lastName'] ?? json['last_name'] ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] ?? json['phone_number'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? json['profile_image_url'],
      status: ParentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ParentStatus.active,
      ),
      childrenCount: json['childrenCount'] ?? json['children_count'] ?? 0,
      walletBalance: (json['walletBalance'] ?? json['wallet_balance'] ?? 0).toDouble(),
      totalPoints: json['totalPoints'] ?? json['total_points'] ?? 0,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] != null || json['created_at'] != null
          ? DateTime.parse(json['createdAt'] ?? json['created_at'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null || json['updated_at'] != null
          ? DateTime.parse(json['updatedAt'] ?? json['updated_at'])
          : DateTime.now(),
    );
  }
}
