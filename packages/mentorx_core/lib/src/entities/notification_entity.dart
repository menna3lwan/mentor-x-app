part of 'package:mentorx_core/mentorx_core.dart';

enum NotificationType { info, success, warning, error, course, quiz, announcement, system }

base class NotificationEntity extends Equatable {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? readAt;
  final String? deepLink;
  final String? imageUrl;
  final Map<String, dynamic>? data;
  final String? studentId;
  final String? studentName;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.readAt,
    this.deepLink,
    this.imageUrl,
    this.data,
    this.studentId,
    this.studentName,
  });

  static final placeholder = NotificationEntity(
    id: '',
    title: '',
    message: '',
    type: NotificationType.info,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        title,
        message,
        type,
        isRead,
        readAt,
        createdAt,
        deepLink,
        imageUrl,
        data,
        studentId,
        studentName,
      ];

  NotificationEntity copyWith({
    String? id,
    String? title,
    String? message,
    NotificationType? type,
    bool? isRead,
    DateTime? readAt,
    DateTime? createdAt,
    String? deepLink,
    String? imageUrl,
    Map<String, dynamic>? data,
    String? studentId,
    String? studentName,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
      deepLink: deepLink ?? this.deepLink,
      imageUrl: imageUrl ?? this.imageUrl,
      data: data ?? this.data,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
    );
  }
}
