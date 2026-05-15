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
          .map((e) => ParentUpcomingSessionModel.fromJson(ModelParser.asMap(e)))
          .toList(),
      recentGrades: ModelParser.asList(json['recentGrades'] ?? json['recent_grades'])
          .map((e) => ParentRecentGradeModel.fromJson(ModelParser.asMap(e)))
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

// ───────────────────────────────────────────────────────────────────────────
// Parent-context dashboard models
// ───────────────────────────────────────────────────────────────────────────

final class ParentUpcomingSessionModel extends ParentUpcomingSessionEntity {
  const ParentUpcomingSessionModel({
    required super.id,
    required super.title,
    required super.courseName,
    required super.scheduledAt,
    required super.status,
    super.teacherName,
    super.duration,
    super.location,
  });

  factory ParentUpcomingSessionModel.fromJson(Map<String, dynamic> json) {
    final scheduled = ModelParser.asDateTime(
          json['scheduled_at'] ??
              json['scheduledAt'] ??
              json['start_at'] ??
              json['startAt'] ??
              json['available_from'] ??
              json['availableFrom'],
        ) ??
        DateTime.now();

    final durationMinutes = ModelParser.asInt(
      json['duration_minutes'] ?? json['durationMinutes'],
    );

    return ParentUpcomingSessionModel(
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title'] ?? json['name']),
      courseName: ModelParser.asString(
        json['course_name'] ?? json['courseName'] ?? json['course']?['name'],
      ),
      teacherName: ModelParser.asString(
        json['teacher_name'] ?? json['teacherName'] ?? json['teacher']?['name'],
      ),
      scheduledAt: scheduled,
      duration: durationMinutes > 0 ? Duration(minutes: durationMinutes) : null,
      status: _parseStatus(
        ModelParser.asString(json['status'], fallback: 'scheduled'),
      ),
      location: ModelParser.asString(json['location'] ?? json['venue']),
    );
  }

  static ParentSessionStatus _parseStatus(String raw) {
    switch (raw.toLowerCase()) {
      case 'live':
      case 'in_progress':
      case 'ongoing':
        return ParentSessionStatus.live;
      case 'completed':
      case 'done':
        return ParentSessionStatus.completed;
      case 'missed':
      case 'absent':
        return ParentSessionStatus.missed;
      case 'cancelled':
      case 'canceled':
        return ParentSessionStatus.cancelled;
      case 'scheduled':
      case 'upcoming':
      default:
        return ParentSessionStatus.scheduled;
    }
  }
}

final class ParentRecentGradeModel extends ParentRecentGradeEntity {
  const ParentRecentGradeModel({
    required super.id,
    required super.kind,
    required super.title,
    required super.courseName,
    required super.score,
    required super.totalMarks,
    required super.percentage,
    required super.gradedAt,
    super.passed,
  });

  factory ParentRecentGradeModel.fromJson(Map<String, dynamic> json) {
    final score = ModelParser.asDouble(json['score'] ?? json['grade']);
    final total = ModelParser.asDouble(
      json['total_marks'] ?? json['totalMarks'] ?? json['max_score'],
    );
    final percentageRaw = ModelParser.asDouble(json['percentage']);
    final percentage = percentageRaw > 0
        ? percentageRaw
        : (total > 0 ? (score / total) * 100 : 0);

    return ParentRecentGradeModel(
      id: ModelParser.asString(json['id']),
      kind: _parseKind(
        ModelParser.asString(
          json['kind'] ?? json['type'] ?? json['source'],
          fallback: 'other',
        ),
      ),
      title: ModelParser.asString(json['title'] ?? json['name']),
      courseName: ModelParser.asString(
        json['course_name'] ?? json['courseName'] ?? json['course']?['name'],
      ),
      score: score,
      totalMarks: total > 0 ? total : 100,
      percentage: percentage,
      passed: json['passed'] == null && json['is_passed'] == null
          ? null
          : ModelParser.asBool(json['passed'] ?? json['is_passed']),
      gradedAt: ModelParser.asDateTime(
            json['graded_at'] ??
                json['gradedAt'] ??
                json['submitted_at'] ??
                json['submittedAt'] ??
                json['created_at'],
          ) ??
          DateTime.now(),
    );
  }

  static ParentGradeKind _parseKind(String raw) {
    switch (raw.toLowerCase()) {
      case 'quiz':
        return ParentGradeKind.quiz;
      case 'assignment':
        return ParentGradeKind.assignment;
      case 'exam':
      case 'final':
        return ParentGradeKind.exam;
      case 'project':
        return ParentGradeKind.project;
      default:
        return ParentGradeKind.other;
    }
  }
}


