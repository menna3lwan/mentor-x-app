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
          ? ParentHomeOverviewModel.fromJson(ModelParser.asMap(json['overview']))
          : const ParentHomeOverviewEntity(
              unpaidInvoicesCount: 0,
              avgAttendanceRate: 0,
              avgGrade: 0,
              totalPoints: 0,
            ),
      upcomingSessions: ModelParser.asList(json['upcomingSessions'] ?? json['upcoming_sessions'])
          .map((e) => SessionModel.fromJson(ModelParser.asMap(e)))
          .toList(),
      recentGrades: ModelParser.asList(json['recentGrades'] ?? json['recent_grades'])
          .map((e) => QuizAttemptModel.fromJson(ModelParser.asMap(e)))
          .toList(),
      latestAnnouncement: (json['latestAnnouncement'] != null || json['latest_announcement'] != null)
          ? AnnouncementModel.fromJson(ModelParser.asMap(json['latestAnnouncement'] ?? json['latest_announcement']))
          : null,
      childrenSummaries: ModelParser.asList(json['childrenSummaries'] ?? json['children_summaries'])
          .map((e) => ParentChildSummaryModel.fromJson(ModelParser.asMap(e)))
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
      unpaidInvoicesCount: ModelParser.asInt(json['unpaid_invoices_count'] ?? json['unpaidInvoicesCount']),
      avgAttendanceRate: ModelParser.asDouble(json['avg_attendance_rate'] ?? json['avgAttendanceRate']),
      avgGrade: ModelParser.asDouble(json['avg_grade'] ?? json['avgGrade']),
      totalPoints: ModelParser.asInt(json['total_points'] ?? json['totalPoints']),
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
      id: ModelParser.asString(json['id']),
      type: ModelParser.asString(json['type'], fallback: 'system'),
      title: ModelParser.asString(json['title']),
      description: ModelParser.asString(json['description']),
      timestamp: ModelParser.asDateTime(json['timestamp'] ?? json['created_at']) ?? DateTime.now(),
      metadata: ModelParser.asMap(json['metadata']),
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
      childId: ModelParser.asString(json['childId'] ?? json['child_id'] ?? json['student_id'] ?? json['id']),
      name: ModelParser.asString(json['name']),
      profileImageUrl: ModelParser.asString(json['profileImageUrl'] ?? json['profile_image_url'] ?? json['avatarUrl']),
      grade: ModelParser.asString(json['grade'] ?? json['gradeName'] ?? json['grade_name']),
      attendanceRate: ModelParser.asDouble(json['attendanceRate'] ?? json['attendance_rate']),
      averageGrade: ModelParser.asDouble(json['averageGrade'] ?? json['average_grade'] ?? json['avg_grade']),
      lastActivity: (json['last_activity'] != null || json['lastActivity'] != null)
          ? ParentRecentActivityModel.fromJson(ModelParser.asMap(json['last_activity'] ?? json['lastActivity']))
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
    super.orderNumber = 0,
    super.isFree = false,
    super.price,
    super.availableFrom,
    super.availableUntil,
    super.itemCount = 0,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: ModelParser.asString(json['id']),
      courseId: ModelParser.asString(json['course_id'] ?? json['courseId']),
      title: ModelParser.asString(json['title']),
      orderNumber: ModelParser.asInt(json['order_number'] ?? json['order_index'] ?? json['orderNumber']),
      isFree: ModelParser.asBool(json['is_free'] ?? json['isFree']),
      price: ModelParser.asDouble(json['price'] ?? json['priceAmount']),
      availableFrom: ModelParser.asDateTime(json['available_from'] ?? json['availableFrom']),
      availableUntil: ModelParser.asDateTime(json['available_until'] ?? json['availableUntil']),
      itemCount: ModelParser.asInt(json['item_count'] ?? json['itemCount']),
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
      id: ModelParser.asString(json['id']),
      quizId: ModelParser.asString(json['quiz_id'] ?? json['quizId']),
      courseId: ModelParser.asString(json['course_id'] ?? json['courseId']),
      courseName: ModelParser.asString(json['course_name'] ?? json['courseName']),
      attemptNumber: ModelParser.asInt(json['attempt_number'] ?? json['attemptNumber'], fallback: 1),
      status: QuizAttemptStatus.values.firstWhere(
        (e) => e.name == ModelParser.asString(json['status'], fallback: 'submitted'),
        orElse: () => QuizAttemptStatus.submitted,
      ),
      score: ModelParser.asInt(json['score']),
      totalMarks: ModelParser.asInt(json['total_marks'] ?? json['totalMarks'], fallback: 100),
      percentage: ModelParser.asDouble(json['percentage']),
      passed: ModelParser.asBool(json['passed'] ?? json['is_passed'] ?? json['isPassed']),
      startedAt: ModelParser.asDateTime(json['started_at'] ?? json['startedAt']) ?? DateTime.now(),
      submittedAt: ModelParser.asDateTime(json['submitted_at'] ?? json['submittedAt']),
      timeSpentSeconds: ModelParser.asInt(json['time_spent_seconds'] ?? json['timeSpentSeconds']),
    );
  }
}


