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
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title']),
      message: ModelParser.asString(json['message'] ?? json['body']),
      type: _parseType(json['type']),
      createdAt: ModelParser.asDateTime(json['created_at'] ?? json['createdAt']) ?? DateTime.now(),
      isRead: ModelParser.asBool(json['is_read'] ?? json['read'] ?? json['isRead']),
      readAt: ModelParser.asDateTime(json['read_at'] ?? json['readAt']),
      deepLink: ModelParser.asString(json['deepLink'] ?? json['action_url'] ?? json['url'] ?? json['link']),
      imageUrl: ModelParser.asString(json['image_url'] ?? json['imageUrl']),
      data: ModelParser.asMap(json['action_data'] ?? json['data']),
      studentId: ModelParser.asString(json['student_id'] ?? json['studentId']),
      studentName: ModelParser.asString(json['student_name'] ?? json['studentName']),
    );
  }

  static NotificationType _parseType(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    return NotificationType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => NotificationType.info,
    );
  }
}
