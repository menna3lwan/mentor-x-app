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
    final user = ModelParser.asMap(json['user'] ?? json['data'] ?? json);

    final String name = ModelParser.asString(user['name'] ?? user['fullName']);
    final nameParts = name.trim().split(' ');
    final String fallbackFirst = nameParts.isNotEmpty ? nameParts.first : '';
    final String fallbackLast = nameParts.length > 1
        ? nameParts.sublist(1).join(' ')
        : '';

    return ParentModel(
      id: ModelParser.asString(user['id'] ?? user['userId']),
      firstName: ModelParser.asString(
        user['firstName'] ?? user['first_name'],
        fallback: fallbackFirst,
      ),
      lastName: ModelParser.asString(
        user['lastName'] ?? user['last_name'],
        fallback: fallbackLast,
      ),
      email: ModelParser.asString(user['email']),
      phoneNumber: ModelParser.asString(
        user['phone'] ?? user['phoneNumber'] ?? user['phone_number'],
      ),
      profileImageUrl: ModelParser.asString(
        user['profileImageUrl'] ??
            user['image_url'] ??
            user['avatarUrl'] ??
            user['profile_photo_url'],
      ),
      status: _parseStatus(user['status']),
      childrenCount: ModelParser.asInt(
        user['childrenCount'] ?? user['students'] is List
            ? (user['students'] as List).length
            : 0,
      ),
      walletBalance: ModelParser.asDouble(
        user['walletBalance'] ?? user['balance'],
      ),
      totalPoints: ModelParser.asInt(user['totalPoints'] ?? user['points']),
      metadata: ModelParser.asMap(user['metadata']),
      createdAt:
          ModelParser.asDateTime(user['createdAt'] ?? user['created_at']) ??
          DateTime.now(),
      updatedAt:
          ModelParser.asDateTime(user['updatedAt'] ?? user['updated_at']) ??
          DateTime.now(),
    );
  }

  static ParentStatus _parseStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    if (str == 'active' || str == 'approved') return ParentStatus.active;
    return ParentStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => ParentStatus.pending,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phone': phoneNumber,
    'profileImageUrl': profileImageUrl,
    'status': status.name,
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
