import 'package:mentorx_core/mentorx_core.dart';

final class AnnouncementModel extends AnnouncementEntity {
  const AnnouncementModel({
    required super.id,
    required super.title,
    required super.content,
    required super.createdAt,
    super.imageUrl,
    super.actionUrl,
    super.actionText,
    super.isFeatured = false,
    super.isPinned = false,
    super.priority = 'normal',
    super.expireAt,
    super.tenantName,
    super.preview,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title']),
      content: ModelParser.asString(json['content'] ?? json['body']),
      createdAt:
          ModelParser.asDateTime(json['created_at'] ?? json['createdAt']) ??
          DateTime.now(),
      imageUrl: ModelParser.asString(json['image_url'] ?? json['imageUrl']),
      actionUrl: ModelParser.asString(
        json['action_url'] ?? json['actionUrl'] ?? json['url'],
      ),
      actionText: ModelParser.asString(
        json['action_text'] ?? json['actionText'],
      ),
      isFeatured: ModelParser.asBool(json['is_featured'] ?? json['isFeatured']),
      isPinned: ModelParser.asBool(
        json['is_pinned'] ?? json['isPinned'] ?? json['pinned'],
      ),
      priority: ModelParser.asString(json['priority'], fallback: 'normal'),
      expireAt: ModelParser.asDateTime(json['expire_at'] ?? json['expireAt']),
      tenantName: ModelParser.asString(
        json['tenant_name'] ?? json['tenantName'],
      ),
      preview: ModelParser.asString(json['preview'] ?? json['summary']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'created_at': createdAt.toIso8601String(),
    'image_url': imageUrl,
    'action_url': actionUrl,
    'action_text': actionText,
    'is_featured': isFeatured,
    'is_pinned': isPinned,
    'priority': priority,
    'expire_at': expireAt?.toIso8601String(),
    'tenant_name': tenantName,
    'preview': preview,
  };

  factory AnnouncementModel.fromEntity(AnnouncementEntity entity) {
    return AnnouncementModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      createdAt: entity.createdAt,
      imageUrl: entity.imageUrl,
      actionUrl: entity.actionUrl,
      actionText: entity.actionText,
      isFeatured: entity.isFeatured,
      isPinned: entity.isPinned,
      priority: entity.priority,
      expireAt: entity.expireAt,
      tenantName: entity.tenantName,
      preview: entity.preview,
    );
  }
}
