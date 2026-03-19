import 'package:mentorx_core/mentorx_core.dart';

abstract final class NotificationModel {
  static NotificationEntity fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id']?.toString() ?? '',
      type: _parseType(json['type'] ?? json['notificationType']),
      title: json['title'] as String? ?? '',
      body: (json['body'] ?? json['message'] ?? '') as String,
      isRead: json['isRead'] as bool? ?? json['is_read'] as bool? ?? false,
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt'] as String) : null,
      imageUrl: (json['imageUrl'] ?? json['image_url']) as String?,
      actionData: (json['actionData'] ?? json['data']) as Map<String, dynamic>?,
      createdAt: DateTime.parse((json['createdAt'] ?? json['created_at']) as String),
      studentId: json['studentId']?.toString(),
      studentName: json['studentName'] as String?,
    );
  }

  static NotificationType _parseType(dynamic value) {
    final str = value?.toString().toLowerCase();
    return NotificationType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => NotificationType.system,
    );
  }
}
