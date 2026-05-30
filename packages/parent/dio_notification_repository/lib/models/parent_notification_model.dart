import 'package:mentorx_core/mentorx_core.dart';

final class ParentNotificationModel extends NotificationEntity {
  const ParentNotificationModel({
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

  factory ParentNotificationModel.fromJson(Map<String, dynamic> json) {
    return ParentNotificationModel(
      id: ModelParser.asString(json['id'] ?? json['_id']),
      title: ModelParser.asString(json['title']),
      message: ModelParser.asString(
        json['message'] ?? json['body'] ?? json['content'],
      ),
      type: _parseType(json['type'] ?? json['category']),
      createdAt:
          ModelParser.asDateTime(
            json['created_at'] ?? json['createdAt'] ?? json['date'],
          ) ??
          DateTime.fromMillisecondsSinceEpoch(0),
      isRead: ModelParser.asBool(
        json['is_read'] ?? json['isRead'] ?? json['read'],
      ),
      readAt: ModelParser.asDateTime(json['read_at'] ?? json['readAt']),
      deepLink: ModelParser.asString(
        json['deepLink'] ?? json['action_url'] ?? json['url'] ?? json['link'],
      ),
      imageUrl: ModelParser.asString(json['image_url'] ?? json['imageUrl']),
      data: ModelParser.asMap(json['action_data'] ?? json['data']),
      studentId: ModelParser.asString(json['student_id'] ?? json['studentId']),
      studentName: ModelParser.asString(
        json['student_name'] ?? json['studentName'],
      ),
    );
  }

  static NotificationType _parseType(dynamic value) {
    final typeName = ModelParser.asString(value).toLowerCase();
    return NotificationType.values.firstWhere(
      (type) => type.name == typeName,
      orElse: () => NotificationType.info,
    );
  }
}
