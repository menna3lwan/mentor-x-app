import 'package:student_core/student_core.dart';

final class AIConversationModel extends AIConversationEntity {
  const AIConversationModel({
    required super.id,
    required super.messageCount,
    required super.createdAt,
    required super.updatedAt,
    super.title,
    super.subject,
    super.isActive,
  });

  factory AIConversationModel.fromJson(Map<String, dynamic> json) {
    return AIConversationModel(
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

final class AIMessageModel extends AIMessageEntity {
  const AIMessageModel({
    required super.id,
    required super.conversationId,
    required super.role,
    required super.content,
    required super.createdAt,
    super.userRating,
    super.userFeedback,
    super.sources,
    super.confidence,
  });

  factory AIMessageModel.fromJson(Map<String, dynamic> json) {
    return AIMessageModel(
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
