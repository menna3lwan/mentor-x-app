import 'package:mentorx_core/mentorx_core.dart';

abstract final class AIConversationModel {
  static AIConversationEntity fromJson(Map<String, dynamic> json) {
    return AIConversationEntity(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String?,
      subject: json['subject'] as String?,
      messageCount: (json['messageCount'] ?? json['message_count'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse((json['createdAt'] ?? json['created_at']) as String),
      updatedAt: DateTime.parse((json['updatedAt'] ?? json['updated_at']) as String),
    );
  }
}

abstract final class AIMessageModel {
  static AIMessageEntity fromJson(Map<String, dynamic> json) {
    return AIMessageEntity(
      id: json['id']?.toString() ?? '',
      conversationId: (json['conversationId'] ?? json['conversation_id'])?.toString() ?? '',
      role: _parseRole(json['role']),
      content: json['content'] as String? ?? '',
      userRating: (json['userRating'] ?? json['user_rating'] as num?)?.toInt(),
      userFeedback: (json['userFeedback'] ?? json['user_feedback']) as String?,
      sources: (json['sources'] as List?)?.map((e) => e.toString()).toList(),
      confidence: json['confidence']?.toString(),
      createdAt: DateTime.parse((json['createdAt'] ?? json['created_at']) as String),
    );
  }

  static AIMessageRole _parseRole(dynamic value) {
    final str = value?.toString().toLowerCase();
    return AIMessageRole.values.firstWhere(
      (e) => e.name == str,
      orElse: () => AIMessageRole.user,
    );
  }
}
