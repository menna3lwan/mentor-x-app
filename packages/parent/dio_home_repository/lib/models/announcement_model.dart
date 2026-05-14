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
      content: ModelParser.asString(json['description'] ?? json['content'] ?? json['preview'] ?? json['body']),
      createdAt: ModelParser.asDateTime(json['announcementDate'] ?? json['createdAt'] ?? json['created_at']) ?? DateTime.now(),
      imageUrl: ModelParser.asString(json['image_url'] ?? json['imageUrl']),
      actionUrl: ModelParser.asString(json['action_url'] ?? json['actionUrl'] ?? json['url']),
      actionText: ModelParser.asString(json['action_text'] ?? json['actionText']),
      isFeatured: ModelParser.asBool(json['active'] ?? json['is_featured'] ?? json['isFeatured']),
      isPinned: ModelParser.asBool(json['is_pinned'] ?? json['isPinned'] ?? json['pinned']),
      priority: ModelParser.asString(json['priority'], fallback: 'normal'),
      expireAt: ModelParser.asDateTime(json['expiryDate'] ?? json['expire_at'] ?? json['expireAt']),
      tenantName: ModelParser.asString(json['tenant_name'] ?? json['tenantName']),
      preview: ModelParser.asString(json['description'] ?? json['preview'] ?? json['summary']),
    );
  }
}
