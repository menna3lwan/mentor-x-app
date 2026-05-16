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
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? json['body'] ?? '',
      type: _parseType(json['type']),
      createdAt:
          DateTime.tryParse(json['created_at'] ?? json['createdAt'] ?? '') ??
          DateTime.now(),
      isRead: json['is_read'] ?? json['read'] ?? false,
      deepLink: json['deepLink'] ?? json['action_url'] ?? json['url'],
      data:
          json['action_data'] as Map<String, dynamic>? ??
          (json['data'] as Map<String, dynamic>?),
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
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? json['preview'] ?? json['body'] ?? '',
      createdAt:
          DateTime.tryParse(json['created_at'] ?? json['createdAt'] ?? '') ??
          DateTime.now(),
      imageUrl: json['image_url'] ?? json['imageUrl'],
      actionUrl: json['action_url'] ?? json['actionUrl'] ?? json['url'],
      actionText: json['action_text'] ?? json['actionText'],
      isFeatured:
          json['is_featured'] ??
          json['isFeatured'] ??
          json['is_pinned'] ??
          false,
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
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? json['invite_link'] ?? json['inviteLink'] ?? '',
      description: json['description'],
    );
  }
}
