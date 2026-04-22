part of 'package:mentorx_core/mentorx_core.dart';

abstract final class ParentModel {
  static ParentEntity fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? json;

    return ParentEntity(
      id: (user['id'] ?? user['userId'])?.toString() ?? '',
      firstName: user['firstName'] as String? ?? user['first_name'] as String? ?? '',
      lastName: user['lastName'] as String? ?? user['last_name'] as String? ?? '',
      phoneNumber: user['phoneNumber'] as String? ?? user['phone'] as String? ?? user['phone_number'] as String? ?? '',
      email: user['email'] as String? ?? '',
      status: ParentStatus.values.firstWhere(
        (e) => e.name == (user['status'] as String? ?? 'active'),
        orElse: () => ParentStatus.active,
      ),
      profileImageUrl: user['profilePhotoUrl'] as String? ??
          user['profile_photo_url'] as String? ??
          user['profileImageUrl'] as String?,
      createdAt: DateTime.tryParse((user['createdAt'] ?? user['created_at'])?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse((user['updatedAt'] ?? user['updated_at'])?.toString() ?? '') ?? DateTime.now(),
      childrenCount: (user['childrenCount'] ?? user['children_count'] ?? 0) as int,
      walletBalance: (user['walletBalance'] ?? user['wallet_balance'] ?? 0).toDouble(),
      totalPoints: (user['totalPoints'] ?? user['total_points'] ?? 0) as int,
    );
  }

  static Map<String, dynamic> toJson(ParentEntity entity) {
    return {
      'id': entity.id,
      'first_name': entity.firstName,
      'last_name': entity.lastName,
      'phone': entity.phoneNumber,
      'email': entity.email,
      'status': entity.status.name,
      'profile_photo_url': entity.profileImageUrl,
      'created_at': entity.createdAt.toIso8601String(),
      'updated_at': entity.updatedAt.toIso8601String(),
      'children_count': entity.childrenCount,
      'wallet_balance': entity.walletBalance,
      'total_points': entity.totalPoints,
    };
  }
}
