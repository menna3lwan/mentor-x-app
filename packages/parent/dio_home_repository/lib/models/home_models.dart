import 'package:mentorx_core/mentorx_core.dart';

final class ParentHomeSummaryModel extends ParentHomeSummaryEntity {
  const ParentHomeSummaryModel({
    required super.overview,
    required super.upcomingSessions,
    required super.recentGrades,
    required super.latestAnnouncement,
    required super.childrenSummaries,
  });

  factory ParentHomeSummaryModel.fromJson(Map<String, dynamic> json) {
    // Matches ParentDashboardSummary schema
    final children = ModelParser.asList(json['children'])
        .map((e) => ParentChildSummaryModel.fromJson(ModelParser.asMap(e)))
        .toList();

    return ParentHomeSummaryModel(
      overview: ParentHomeOverviewModel.fromJson(json),
      upcomingSessions: const [], // Not in ParentDashboardSummary
      recentGrades: const [], // Not in ParentDashboardSummary
      latestAnnouncement: null, // Not in ParentDashboardSummary
      childrenSummaries: children,
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
    // Maps top-level totals if available, otherwise from children aggregates
    final children = ModelParser.asList(json['children']);
    
    double totalAtt = 0;
    double totalGrade = 0;
    int count = children.length;
    
    if (count > 0) {
      for (final child in children) {
        final cMap = ModelParser.asMap(child);
        totalAtt += ModelParser.asDouble(cMap['totalAttendance']);
        totalGrade += ModelParser.asDouble(cMap['completedLessons']); // Use lessons as grade proxy if missing
      }
    }

    return ParentHomeOverviewModel(
      unpaidInvoicesCount: ModelParser.asInt(json['totalUnreadNotifications'] ?? json['unpaid_invoices_count']),
      avgAttendanceRate: count > 0 ? totalAtt / count : 0.0,
      avgGrade: count > 0 ? totalGrade / count : 0.0,
      totalPoints: ModelParser.asInt(json['totalPoints'] ?? json['total_points']),
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
    // Matches ChildSummaryCard schema
    return ParentChildSummaryModel(
      childId: ModelParser.asString(json['studentId'] ?? json['id']),
      name: ModelParser.asString(json['studentName'] ?? json['name']),
      profileImageUrl: ModelParser.asString(json['profileImageUrl'] ?? json['image_url']),
      grade: ModelParser.asString(json['grade'] ?? json['gradeName']),
      attendanceRate: ModelParser.asDouble(json['totalAttendance'] ?? json['attendance_rate']),
      averageGrade: ModelParser.asDouble(json['completedLessons'] ?? json['average_grade']), // Fallback to progress
      lastActivity: null, // Not in ChildSummaryCard
    );
  }
}

final class ParentChildDashboardSummaryModel extends ParentChildDashboardSummaryEntity {
  const ParentChildDashboardSummaryModel({
    required super.child,
    required super.attendance,
    required super.academics,
    required super.financial,
    required super.recentActivity,
  });

  factory ParentChildDashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    // Matches ChildOverview schema
    final studentId = ModelParser.asString(json['studentId']);
    final studentName = ModelParser.asString(json['studentName']);
    
    return ParentChildDashboardSummaryModel(
      child: ParentChildEntity(
        id: studentId,
        name: studentName,
        gradeName: ModelParser.asString(json['grade']),
        profileImageUrl: ModelParser.asString(json['profileImageUrl']),
        studentCode: ModelParser.asString(json['studentCode']),
        centerName: ModelParser.asString(json['centerName']),
        isVerified: true,
      ),
      attendance: ParentHomeAttendanceSummary(
        attendanceRate: ModelParser.asDouble(json['totalAttendance']),
        totalDays: ModelParser.asInt(json['totalAttendance']), // Approximation
        attendedDays: ModelParser.asInt(json['centerAttendance'] ?? json['onlineAttendance']),
        absentDays: 0,
      ),
      academics: ParentHomeAcademicSummary(
        averageGrade: 0.0, // Not directly in ChildOverview
        gradeTrend: 0.0,
        enrolledCoursesCount: ModelParser.asInt(json['activeEnrollments']),
        activeAssignmentsCount: 0,
      ),
      financial: const ParentHomeFinancialSummary(
        walletBalance: 0.0,
        spentThisMonth: 0.0,
        currency: 'EGP',
      ),
      recentActivity: const [],
    );
  }
}
