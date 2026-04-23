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
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? json['body'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? json['createdAt'] ?? '') ?? DateTime.now(),
      imageUrl: json['image_url'] ?? json['imageUrl'],
      actionUrl: json['action_url'] ?? json['actionUrl'] ?? json['url'],
      actionText: json['action_text'] ?? json['actionText'],
      isFeatured: json['is_featured'] ?? json['isFeatured'] ?? false,
      isPinned: json['is_pinned'] ?? json['isPinned'] ?? json['pinned'] ?? false,
      priority: json['priority'] ?? 'normal',
      expireAt: json['expire_at'] != null ? DateTime.tryParse(json['expire_at']) : null,
      tenantName: json['tenant_name'] ?? json['tenantName'],
      preview: json['preview'] ?? json['summary'],
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
