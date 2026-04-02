part of '../../mentorx_core.dart';

abstract final class ParentModel {
  static ParentEntity fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? json;

    return ParentEntity(
      id: (user['id'] ?? user['userId'])?.toString() ?? '',
      name: user['name'] as String? ?? 
            ((user['firstName'] != null || user['lastName'] != null) 
              ? '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}'.trim() 
              : ''),
      phoneNumber: user['phone'] as String? ?? user['phoneNumber'] as String? ?? '',
      profileImageUrl: user['profileImageUrl'] as String? ?? user['profileImage'] as String?,
    );
  }

  static Map<String, dynamic> toJson(ParentEntity entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'phoneNumber': entity.phoneNumber,
      'profileImageUrl': entity.profileImageUrl,
    };
  }
}
