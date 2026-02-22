part of '../mentorx_core.dart';

enum NotificationType {
  announcement,
  courseEnrolled,
  sessionAvailable,
  quizResult,
  assignmentGraded,
  attendanceMarked,
  paymentSuccess,
  paymentFailed,
  walletUpdated,
  pointsEarned,
  rewardStatus,
  profileApproved,
  profileRejected,
  system,
}

final class NotificationEntity extends Equatable {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final bool isRead;
  final DateTime? readAt;
  final String? imageUrl;
  final Map<String, dynamic>? actionData;
  final DateTime createdAt;

  /// Parent-only fields: which child this notification is about.
  final String? studentId;
  final String? studentName;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    this.isRead = false,
    this.readAt,
    this.imageUrl,
    this.actionData,
    this.studentId,
    this.studentName,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        body,
        isRead,
        readAt,
        imageUrl,
        actionData,
        createdAt,
        studentId,
        studentName,
      ];
}
