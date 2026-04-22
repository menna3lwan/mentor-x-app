part of 'package:mentorx_core/mentorx_core.dart';

enum EnrollmentStatus { active, expired, completed }

enum EnrolledBy { self, code, admin }

base class EnrollmentEntity extends Equatable {
  final String id;
  final String courseId;
  final double progressPercent;
  final int completedSessions;
  final DateTime enrolledAt;
  final DateTime? expiresAt;
  final DateTime? completedAt;
  final DateTime? lastAccessedAt;
  final String? lastItemId;
  final EnrolledBy enrolledBy;
  final String? certificateUrl;

  const EnrollmentEntity({
    required this.id,
    required this.courseId,
    required this.enrolledAt,
    this.progressPercent = 0,
    this.completedSessions = 0,
    this.expiresAt,
    this.completedAt,
    this.lastAccessedAt,
    this.lastItemId,
    this.enrolledBy = EnrolledBy.self,
    this.certificateUrl,
  });

  EnrollmentStatus get status {
    if (completedAt != null) return EnrollmentStatus.completed;
    if (expiresAt != null && expiresAt!.isBefore(DateTime.now())) {
      return EnrollmentStatus.expired;
    }
    return EnrollmentStatus.active;
  }

  static final placeholder = EnrollmentEntity(
    id: '',
    courseId: '',
    enrolledAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        courseId,
        progressPercent,
        completedSessions,
        enrolledAt,
        expiresAt,
        completedAt,
        lastAccessedAt,
        lastItemId,
        enrolledBy,
        certificateUrl,
      ];

  EnrollmentEntity copyWith({
    String? id,
    String? courseId,
    double? progressPercent,
    int? completedSessions,
    DateTime? enrolledAt,
    DateTime? expiresAt,
    DateTime? completedAt,
    DateTime? lastAccessedAt,
    String? lastItemId,
    EnrolledBy? enrolledBy,
    String? certificateUrl,
  }) {
    return EnrollmentEntity(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      progressPercent: progressPercent ?? this.progressPercent,
      completedSessions: completedSessions ?? this.completedSessions,
      enrolledAt: enrolledAt ?? this.enrolledAt,
      expiresAt: expiresAt ?? this.expiresAt,
      completedAt: completedAt ?? this.completedAt,
      lastAccessedAt: lastAccessedAt ?? this.lastAccessedAt,
      lastItemId: lastItemId ?? this.lastItemId,
      enrolledBy: enrolledBy ?? this.enrolledBy,
      certificateUrl: certificateUrl ?? this.certificateUrl,
    );
  }
}
