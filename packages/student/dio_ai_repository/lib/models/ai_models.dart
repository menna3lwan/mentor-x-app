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
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title'] ?? json['subject'], fallback: 'New Conversation'),
      subject: ModelParser.asString(json['subject']),
      messageCount: ModelParser.asInt(json['message_count'] ?? json['messageCount']),
      isActive: ModelParser.asBool(json['is_active'] ?? json['isActive'], fallback: true),
      createdAt: ModelParser.asDateTime(json['created_at'] ?? json['createdAt']) ?? DateTime.now(),
      updatedAt: ModelParser.asDateTime(json['updated_at'] ?? json['updatedAt']) ?? DateTime.now(),
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
      id: ModelParser.asString(json['id']),
      conversationId: ModelParser.asString(json['conversation_id'] ?? json['conversationId']),
      role: ModelParser.asString(json['role']).toLowerCase() == 'assistant'
          ? AIMessageRole.assistant
          : AIMessageRole.user,
      content: ModelParser.asString(json['content']),
      createdAt: ModelParser.asDateTime(json['created_at'] ?? json['createdAt']) ?? DateTime.now(),
      userRating: ModelParser.asInt(json['rating'] ?? json['user_rating'] ?? json['userRating']),
      userFeedback: ModelParser.asString(json['feedback'] ?? json['user_feedback'] ?? json['userFeedback']),
      sources: ModelParser.asList(json['sources'])
          .map((e) => e.toString())
          .toList(),
      confidence: ModelParser.asString(json['confidence']),
    );
  }
}
