import 'package:mentorx_core/mentorx_core.dart';

final class ParentModel extends ParentEntity {
  const ParentModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.profileImageUrl,
    super.childrenCount = 0,
    super.walletBalance = 0.0,
    super.totalPoints = 0,
    super.metadata,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? json;

    final String name = user['name'] as String? ?? '';
    final nameParts = name.trim().split(' ');
    final String fallbackFirst = nameParts.first;
    final String fallbackLast = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return ParentModel(
      id: (user['id'] ?? user['userId'])?.toString() ?? '',
      firstName: user['firstName'] as String? ??
          user['first_name'] as String? ??
          fallbackFirst,
      lastName: user['lastName'] as String? ??
          user['last_name'] as String? ??
          fallbackLast,
      email: user['email'] as String? ?? '',
      phoneNumber: (user['phone'] ?? user['phoneNumber'] ?? user['phone_number'])
              ?.toString() ??
          '',
      profileImageUrl: (user['profileImageUrl'] ??
              user['profileImage'] ??
              user['avatarUrl'] ??
              user['profile_photo_url'])
          ?.toString(),
      status: _parseStatus(user['status']),
      childrenCount: (user['childrenCount'] ?? user['children_count'] ?? 0).toInt(),
      walletBalance: (user['walletBalance'] ?? user['wallet_balance'] ?? 0.0)
          .toDouble(),
      totalPoints: (user['totalPoints'] ?? user['total_points'] ?? 0).toInt(),
      metadata: user['metadata'] as Map<String, dynamic>?,
      createdAt: DateTime.tryParse(
              (user['createdAt'] ?? user['created_at'])?.toString() ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(
              (user['updatedAt'] ?? user['updated_at'])?.toString() ?? '') ??
          DateTime.now(),
    );
  }

  static ParentStatus _parseStatus(dynamic value) {
    if (value == null) return ParentStatus.pending;
    final str = value.toString().toLowerCase();
    return ParentStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => ParentStatus.pending,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phoneNumber,
        'profile_image_url': profileImageUrl,
        'status': status.name,
        'children_count': childrenCount,
        'wallet_balance': walletBalance,
        'total_points': totalPoints,
        'metadata': metadata,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory ParentModel.fromEntity(ParentEntity entity) {
    return ParentModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      profileImageUrl: entity.profileImageUrl,
      childrenCount: entity.childrenCount,
      walletBalance: entity.walletBalance,
      totalPoints: entity.totalPoints,
      metadata: entity.metadata,
    );
  }
}
