import 'package:mentorx_core/mentorx_core.dart';

final class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.message,
    required super.type,
    required super.createdAt,
    super.isRead,
    super.deepLink,
    super.data,
    // Note: Parent app specific fields like studentId/studentName can be put in 'data' 
    // or we can add them to the core entity if they are universally useful.
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title']),
      message: ModelParser.asString(json['message'] ?? json['body']),
      type: _parseType(json['type']),
      createdAt: ModelParser.asDateTime(json['created_at'] ?? json['createdAt']) ?? DateTime.now(),
      isRead: ModelParser.asBool(json['is_read'] ?? json['read']),
      deepLink: ModelParser.asString(json['deepLink'] ?? json['action_url'] ?? json['url']),
      data: json['action_data'] as Map<String, dynamic>? ?? (json['data'] as Map<String, dynamic>?),
    );
  }

  static NotificationType _parseType(dynamic value) {
    final str = value?.toString().toLowerCase();
    return NotificationType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => NotificationType.info,
    );
  }
}

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
      content: ModelParser.asString(json['content'] ?? json['preview'] ?? json['body']),
      createdAt: ModelParser.asDateTime(json['created_at'] ?? json['createdAt']) ?? DateTime.now(),
      imageUrl: ModelParser.asString(json['image_url'] ?? json['imageUrl']),
      actionUrl: ModelParser.asString(json['action_url'] ?? json['actionUrl'] ?? json['url']),
      actionText: ModelParser.asString(json['action_text'] ?? json['actionText']),
      isFeatured: ModelParser.asBool(json['is_featured'] ?? json['isFeatured'] ?? json['is_pinned']),
      isPinned: ModelParser.asBool(json['is_pinned'] ?? json['isPinned'] ?? json['pinned']),
      priority: ModelParser.asString(json['priority'], fallback: 'normal'),
      expireAt: ModelParser.asDateTime(json['expire_at'] ?? json['expireAt']),
      tenantName: ModelParser.asString(json['tenant_name'] ?? json['tenantName']),
      preview: ModelParser.asString(json['preview'] ?? json['summary']),
    );
  }
}

final class WhatsAppGroupModel extends WhatsAppGroupEntity {
  const WhatsAppGroupModel({
    required super.id,
    required super.name,
    required super.url,
    super.description,
  });

  factory WhatsAppGroupModel.fromJson(Map<String, dynamic> json) {
    return WhatsAppGroupModel(
      id: ModelParser.asString(json['id']),
      name: ModelParser.asString(json['name']),
      url: ModelParser.asString(json['url'] ?? json['invite_link'] ?? json['inviteLink']),
      description: ModelParser.asString(json['description']),
    );
  }
}
