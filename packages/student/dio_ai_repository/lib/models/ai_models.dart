import 'package:mentorx_core/mentorx_core.dart';

final class AIConversationModel extends AIConversationEntity {
  const AIConversationModel({
    required super.id,
    super.title,
    super.subject,
    required super.messageCount,
    super.isActive = true,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AIConversationModel.fromJson(Map<String, dynamic> json) {
    return AIConversationModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? json['subject'] ?? 'New Conversation',
      subject: json['subject'],
      messageCount: json['message_count'] ?? json['messageCount'] ?? 0,
      isActive: json['is_active'] ?? json['isActive'] ?? true,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
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
      conversationId: json['conversation_id']?.toString() ?? '',
      role: json['role']?.toString() == 'assistant' ? AIMessageRole.assistant : AIMessageRole.user,
      content: json['content'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      userRating: json['rating'] ?? json['user_rating'] ?? json['userRating'],
      userFeedback: json['feedback'] ?? json['user_feedback'] ?? json['userFeedback'],
      sources: (json['sources'] as List?)?.map((e) => e.toString()).toList(),
      confidence: json['confidence']?.toString(),
    );
  }
}
