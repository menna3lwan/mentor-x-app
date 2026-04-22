import 'package:mentorx_core/mentorx_core.dart';

final class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.message,
    required super.type,
    required super.createdAt,
    super.isRead,
    super.readAt,
    super.deepLink,
    super.imageUrl,
    super.data,
    super.studentId,
    super.studentName,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? json['body'] ?? '',
      type: _parseType(json['type']),
      createdAt: DateTime.tryParse(json['created_at'] ?? json['createdAt'] ?? '') ?? DateTime.now(),
      isRead: json['is_read'] ?? json['read'] ?? false,
      readAt: json['read_at'] != null ? DateTime.tryParse(json['read_at']) : null,
      deepLink: json['deepLink'] ?? json['action_url'] ?? json['url'],
      imageUrl: json['image_url'] ?? json['imageUrl'],
      data: json['action_data'] as Map<String, dynamic>? ?? (json['data'] as Map<String, dynamic>?),
      studentId: json['student_id']?.toString(),
      studentName: json['student_name'],
    );
  }

  static NotificationType _parseType(dynamic value) {
    if (value == null) return NotificationType.info;
    final str = value.toString().toLowerCase();
    return NotificationType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => NotificationType.info,
    );
  }
}
