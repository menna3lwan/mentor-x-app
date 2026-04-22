import 'package:mentorx_core/mentorx_core.dart';
import 'announcement_model.dart';

final class ParentHomeSummaryModel extends ParentHomeSummaryEntity {
  const ParentHomeSummaryModel({
    required super.overview,
    required super.upcomingSessions,
    required super.recentGrades,
    required super.latestAnnouncement,
    required super.childrenSummaries,
  });

  factory ParentHomeSummaryModel.fromJson(Map<String, dynamic> json) {
    return ParentHomeSummaryModel(
      overview: (json['overview'] != null)
          ? ParentHomeOverviewModel.fromJson(json['overview'])
          : const ParentHomeOverviewEntity(
              unpaidInvoicesCount: 0,
              avgAttendanceRate: 0,
              avgGrade: 0,
              totalPoints: 0,
            ),
      upcomingSessions: (json['upcomingSessions'] as List? ?? json['upcoming_sessions'] as List? ?? [])
          .map((e) => SessionModel.fromJson(e))
          .toList(),
      recentGrades: (json['recentGrades'] as List? ?? json['recent_grades'] as List? ?? [])
          .map((e) => QuizAttemptModel.fromJson(e))
          .toList(),
      latestAnnouncement: (json['latestAnnouncement'] != null || json['latest_announcement'] != null)
          ? AnnouncementModel.fromJson(json['latestAnnouncement'] ?? json['latest_announcement'])
          : null,
      childrenSummaries: (json['childrenSummaries'] as List? ?? json['children_summaries'] as List? ?? [])
          .map((e) => ParentChildSummaryModel.fromJson(e))
          .toList(),
    );
  }
}

final class ParentHomeOverviewModel extends ParentHomeOverviewEntity {
  const ParentHomeOverviewModel({
    required super.unpaidInvoicesCount,
    required super.avgAttendanceRate,
    required super.avgGrade,
    required super.totalPoints,
  });

  factory ParentHomeOverviewModel.fromJson(Map<String, dynamic> json) {
    return ParentHomeOverviewModel(
      unpaidInvoicesCount: (json['unpaid_invoices_count'] ?? json['unpaidInvoicesCount'] ?? 0).toInt(),
      avgAttendanceRate: (json['avg_attendance_rate'] ?? json['avgAttendanceRate'] ?? 0.0).toDouble(),
      avgGrade: (json['avg_grade'] ?? json['avgGrade'] ?? 0.0).toDouble(),
      totalPoints: (json['total_points'] ?? json['totalPoints'] ?? 0).toInt(),
    );
  }
}

final class ParentRecentActivityModel extends ParentRecentActivityEntity {
  const ParentRecentActivityModel({
    required super.id,
    required super.type,
    required super.title,
    required super.description,
    required super.timestamp,
    super.metadata,
  });

  factory ParentRecentActivityModel.fromJson(Map<String, dynamic> json) {
    return ParentRecentActivityModel(
      id: json['id']?.toString() ?? '',
      type: json['type']?.toString() ?? 'system',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] ?? json['created_at'] ?? '') ?? DateTime.now(),
      metadata: (json['metadata'] as Map<String, dynamic>?) ?? const {},
    );
  }
}

final class ParentChildSummaryModel extends ParentChildSummaryEntity {
  const ParentChildSummaryModel({
    required super.childId,
    required super.name,
    super.profileImageUrl,
    required super.grade,
    required super.attendanceRate,
    required super.averageGrade,
    super.lastActivity,
  });

  factory ParentChildSummaryModel.fromJson(Map<String, dynamic> json) {
    return ParentChildSummaryModel(
      childId: (json['childId'] ?? json['child_id'] ?? json['student_id'] ?? json['id'])?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      profileImageUrl: (json['profileImageUrl'] ?? json['profile_image_url'] ?? json['avatarUrl'])?.toString(),
      grade: (json['grade'] ?? json['gradeName'] ?? json['grade_name'])?.toString() ?? '',
      attendanceRate: (json['attendanceRate'] ?? json['attendance_rate'] ?? 0.0).toDouble(),
      averageGrade: (json['averageGrade'] ?? json['average_grade'] ?? json['avg_grade'] ?? 0.0).toDouble(),
      lastActivity: (json['last_activity'] != null || json['lastActivity'] != null)
          ? ParentRecentActivityModel.fromJson(json['last_activity'] ?? json['lastActivity'])
          : null,
    );
  }
}

// Re-using common models or defining local ones if shared logic is needed
final class SessionModel extends SessionEntity {
  const SessionModel({
    required super.id,
    required super.courseId,
    required super.title,
    required super.orderIndex,
    super.isFree = false,
    super.price,
    super.availableFrom,
    super.availableUntil,
    super.itemCount = 0,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id']?.toString() ?? '',
      courseId: json['course_id']?.toString() ?? '',
      title: json['title'] ?? '',
      orderIndex: (json['order_index'] ?? 0).toInt(),
      isFree: json['is_free'] ?? json['isFree'] ?? false,
      price: (json['price'] ?? json['priceAmount'])?.toDouble(),
      availableFrom: json['available_from'] != null ? DateTime.tryParse(json['available_from']) : null,
      availableUntil: json['available_until'] != null ? DateTime.tryParse(json['available_until']) : null,
      itemCount: (json['item_count'] ?? json['itemCount'] ?? 0).toInt(),
    );
  }
}

final class QuizAttemptModel extends QuizAttemptEntity {
  const QuizAttemptModel({
    required super.id,
    required super.quizId,
    super.courseId,
    super.courseName,
    required super.attemptNumber,
    required super.status,
    required super.score,
    required super.totalMarks,
    required super.percentage,
    required super.passed,
    required super.startedAt,
    super.submittedAt,
    super.timeSpentSeconds = 0,
  });

  factory QuizAttemptModel.fromJson(Map<String, dynamic> json) {
    return QuizAttemptModel(
      id: json['id']?.toString() ?? '',
      quizId: json['quiz_id']?.toString() ?? '',
      courseId: json['course_id']?.toString(),
      courseName: json['course_name'],
      attemptNumber: (json['attempt_number'] ?? 1).toInt(),
      status: QuizAttemptStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'submitted'),
        orElse: () => QuizAttemptStatus.submitted,
      ),
      score: (json['score'] ?? 0).toInt(),
      totalMarks: (json['total_marks'] ?? 100).toInt(),
      percentage: (json['percentage'] ?? 0.0).toDouble(),
      passed: json['passed'] ?? json['is_passed'] ?? false,
      startedAt: DateTime.tryParse(json['started_at'] ?? json['startedAt'] ?? '') ?? DateTime.now(),
      submittedAt: json['submitted_at'] != null ? DateTime.tryParse(json['submitted_at']) : null,
      timeSpentSeconds: (json['time_spent_seconds'] ?? 0).toInt(),
    );
  }
}


