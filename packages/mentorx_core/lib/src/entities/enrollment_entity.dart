part of 'package:mentorx_core/mentorx_core.dart';

enum EnrollmentStatus { active, expired, completed }

enum EnrolledBy { self, code, admin }

class EnrollmentEntity extends Equatable {
  final String id;
  final String? studentId;
  final String? studentName;
  final String? studentPhone;
  final String courseId;
  final String? courseTitle;
  final String? courseDescription;
  final String? courseThumbnailUrl;
  final double progressPercent;
  final int completedSessions;
  final DateTime enrolledAt;
  final DateTime? expiresAt;
  final DateTime? completedAt;
  final DateTime? lastAccessedAt;
  final String? lastItemId;
  final EnrolledBy enrolledBy;
  final String? certificateUrl;

  final int completedLessons;
  final int totalLessons;

  final int totalWatchTimeSeconds;
  final int quizzesTaken;
  final int quizzesPassed;
  final double averageQuizScore;
  final int assignmentsSubmitted;
  final double averageAssignmentScore;
  final int remainingDays;
  final int accessCount;
  final String? notes;
  final bool isValidAccess;
  final String? completionPercentage;
  final String? timeSpentFormatted;

  const EnrollmentEntity({
    required this.id,
    this.studentId,
    this.studentName,
    this.studentPhone,
    required this.courseId,
    this.courseTitle,
    this.courseDescription,
    this.courseThumbnailUrl,
    required this.enrolledAt,
    this.progressPercent = 0,
    this.completedSessions = 0,
    this.completedLessons = 0,
    this.totalLessons = 0,
    this.expiresAt,
    this.completedAt,
    this.lastAccessedAt,
    this.lastItemId,
    this.enrolledBy = EnrolledBy.self,
    this.certificateUrl,
    this.totalWatchTimeSeconds = 0,
    this.quizzesTaken = 0,
    this.quizzesPassed = 0,
    this.averageQuizScore = 0.0,
    this.assignmentsSubmitted = 0,
    this.averageAssignmentScore = 0.0,
    this.remainingDays = 0,
    this.accessCount = 0,
    this.notes,
    this.isValidAccess = true,
    this.completionPercentage,
    this.timeSpentFormatted,
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
        studentId,
        studentName,
        studentPhone,
        courseId,
        courseTitle,
        courseDescription,
        courseThumbnailUrl,
        progressPercent,
        completedSessions,
        completedLessons,
        totalLessons,
        enrolledAt,
        expiresAt,
        completedAt,
        lastAccessedAt,
        lastItemId,
        enrolledBy,
        certificateUrl,
        totalWatchTimeSeconds,
        quizzesTaken,
        quizzesPassed,
        averageQuizScore,
        assignmentsSubmitted,
        averageAssignmentScore,
        remainingDays,
        accessCount,
        notes,
        isValidAccess,
        completionPercentage,
        timeSpentFormatted,
      ];

  EnrollmentEntity copyWith({
    String? id,
    String? studentId,
    String? studentName,
    String? studentPhone,
    String? courseId,
    String? courseTitle,
    String? courseDescription,
    String? courseThumbnailUrl,
    double? progressPercent,
    int? completedSessions,
    int? completedLessons,
    int? totalLessons,
    DateTime? enrolledAt,
    DateTime? expiresAt,
    DateTime? completedAt,
    DateTime? lastAccessedAt,
    String? lastItemId,
    EnrolledBy? enrolledBy,
    String? certificateUrl,
    int? totalWatchTimeSeconds,
    int? quizzesTaken,
    int? quizzesPassed,
    double? averageQuizScore,
    int? assignmentsSubmitted,
    double? averageAssignmentScore,
    int? remainingDays,
    int? accessCount,
    String? notes,
    bool? isValidAccess,
    String? completionPercentage,
    String? timeSpentFormatted,
  }) {
    return EnrollmentEntity(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      studentPhone: studentPhone ?? this.studentPhone,
      courseId: courseId ?? this.courseId,
      courseTitle: courseTitle ?? this.courseTitle,
      courseDescription: courseDescription ?? this.courseDescription,
      courseThumbnailUrl: courseThumbnailUrl ?? this.courseThumbnailUrl,
      progressPercent: progressPercent ?? this.progressPercent,
      completedSessions: completedSessions ?? this.completedSessions,
      completedLessons: completedLessons ?? this.completedLessons,
      totalLessons: totalLessons ?? this.totalLessons,
      enrolledAt: enrolledAt ?? this.enrolledAt,
      expiresAt: expiresAt ?? this.expiresAt,
      completedAt: completedAt ?? this.completedAt,
      lastAccessedAt: lastAccessedAt ?? this.lastAccessedAt,
      lastItemId: lastItemId ?? this.lastItemId,
      enrolledBy: enrolledBy ?? this.enrolledBy,
      certificateUrl: certificateUrl ?? this.certificateUrl,
      totalWatchTimeSeconds: totalWatchTimeSeconds ?? this.totalWatchTimeSeconds,
      quizzesTaken: quizzesTaken ?? this.quizzesTaken,
      quizzesPassed: quizzesPassed ?? this.quizzesPassed,
      averageQuizScore: averageQuizScore ?? this.averageQuizScore,
      assignmentsSubmitted: assignmentsSubmitted ?? this.assignmentsSubmitted,
      averageAssignmentScore: averageAssignmentScore ?? this.averageAssignmentScore,
      remainingDays: remainingDays ?? this.remainingDays,
      accessCount: accessCount ?? this.accessCount,
      notes: notes ?? this.notes,
      isValidAccess: isValidAccess ?? this.isValidAccess,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      timeSpentFormatted: timeSpentFormatted ?? this.timeSpentFormatted,
    );
  }
}
