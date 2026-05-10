part of 'package:mentorx_core/mentorx_core.dart';

class ParentHomeSummaryEntity extends Equatable {
  final ParentHomeOverviewEntity overview;
  final List<SessionEntity> upcomingSessions;
  final List<QuizAttemptEntity> recentGrades;
  final AnnouncementEntity? latestAnnouncement;
  final List<ParentChildSummaryEntity> childrenSummaries;

  const ParentHomeSummaryEntity({
    required this.overview,
    required this.upcomingSessions,
    required this.recentGrades,
    this.latestAnnouncement,
    required this.childrenSummaries,
  });

  static final placeholder = ParentHomeSummaryEntity(
    overview: ParentHomeOverviewEntity.placeholder,
    upcomingSessions: const [],
    recentGrades: const [],
    latestAnnouncement: null,
    childrenSummaries: const [],
  );

  @override
  List<Object?> get props => [
    overview,
    upcomingSessions,
    recentGrades,
    latestAnnouncement,
    childrenSummaries,
  ];

  ParentHomeSummaryEntity copyWith({
    ParentHomeOverviewEntity? overview,
    List<SessionEntity>? upcomingSessions,
    List<QuizAttemptEntity>? recentGrades,
    AnnouncementEntity? latestAnnouncement,
    List<ParentChildSummaryEntity>? childrenSummaries,
  }) {
    return ParentHomeSummaryEntity(
      overview: overview ?? this.overview,
      upcomingSessions: upcomingSessions ?? this.upcomingSessions,
      recentGrades: recentGrades ?? this.recentGrades,
      latestAnnouncement: latestAnnouncement ?? this.latestAnnouncement,
      childrenSummaries: childrenSummaries ?? this.childrenSummaries,
    );
  }
}

class ParentHomeOverviewEntity extends Equatable {
  final int unpaidInvoicesCount;
  final double avgAttendanceRate;
  final double avgGrade;
  final int totalPoints;

  const ParentHomeOverviewEntity({
    required this.unpaidInvoicesCount,
    required this.avgAttendanceRate,
    required this.avgGrade,
    required this.totalPoints,
  });

  static const placeholder = ParentHomeOverviewEntity(
    unpaidInvoicesCount: 0,
    avgAttendanceRate: 0.0,
    avgGrade: 0.0,
    totalPoints: 0,
  );

  @override
  List<Object?> get props => [
    unpaidInvoicesCount,
    avgAttendanceRate,
    avgGrade,
    totalPoints,
  ];

  ParentHomeOverviewEntity copyWith({
    int? unpaidInvoicesCount,
    double? avgAttendanceRate,
    double? avgGrade,
    int? totalPoints,
  }) {
    return ParentHomeOverviewEntity(
      unpaidInvoicesCount: unpaidInvoicesCount ?? this.unpaidInvoicesCount,
      avgAttendanceRate: avgAttendanceRate ?? this.avgAttendanceRate,
      avgGrade: avgGrade ?? this.avgGrade,
      totalPoints: totalPoints ?? this.totalPoints,
    );
  }
}

class ParentChildSummaryEntity extends Equatable {
  final String childId;
  final String name;
  final String? profileImageUrl;
  final String grade;
  final double attendanceRate;
  final double averageGrade;
  final ParentRecentActivityEntity? lastActivity;

  const ParentChildSummaryEntity({
    required this.childId,
    required this.name,
    this.profileImageUrl,
    required this.grade,
    required this.attendanceRate,
    required this.averageGrade,
    this.lastActivity,
  });

  static const placeholder = ParentChildSummaryEntity(
    childId: '',
    name: '',
    grade: '',
    attendanceRate: 0.0,
    averageGrade: 0.0,
  );

  @override
  List<Object?> get props => [
    childId,
    name,
    profileImageUrl,
    grade,
    attendanceRate,
    averageGrade,
    lastActivity,
  ];

  ParentChildSummaryEntity copyWith({
    String? childId,
    String? name,
    String? profileImageUrl,
    String? grade,
    double? attendanceRate,
    double? averageGrade,
    ParentRecentActivityEntity? lastActivity,
  }) {
    return ParentChildSummaryEntity(
      childId: childId ?? this.childId,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      grade: grade ?? this.grade,
      attendanceRate: attendanceRate ?? this.attendanceRate,
      averageGrade: averageGrade ?? this.averageGrade,
      lastActivity: lastActivity ?? this.lastActivity,
    );
  }
}

class ParentChildDashboardSummaryEntity extends Equatable {
  final ParentChildEntity child;
  final ParentHomeAttendanceSummary attendance;
  final ParentHomeAcademicSummary academics;
  final ParentHomeFinancialSummary financial;
  final List<ParentRecentActivityEntity> recentActivity;

  const ParentChildDashboardSummaryEntity({
    required this.child,
    required this.attendance,
    required this.academics,
    required this.financial,
    required this.recentActivity,
  });

  String get childId => child.id;

  static final placeholder = ParentChildDashboardSummaryEntity(
    child: ParentChildEntity.placeholder,
    attendance: ParentHomeAttendanceSummary.placeholder,
    academics: ParentHomeAcademicSummary.placeholder,
    financial: ParentHomeFinancialSummary.placeholder,
    recentActivity: const [],
  );

  @override
  List<Object?> get props => [
    child,
    attendance,
    academics,
    financial,
    recentActivity,
  ];

  ParentChildDashboardSummaryEntity copyWith({
    ParentChildEntity? child,
    ParentHomeAttendanceSummary? attendance,
    ParentHomeAcademicSummary? academics,
    ParentHomeFinancialSummary? financial,
    List<ParentRecentActivityEntity>? recentActivity,
  }) {
    return ParentChildDashboardSummaryEntity(
      child: child ?? this.child,
      attendance: attendance ?? this.attendance,
      academics: academics ?? this.academics,
      financial: financial ?? this.financial,
      recentActivity: recentActivity ?? this.recentActivity,
    );
  }
}

class ParentHomeAttendanceSummary extends Equatable {
  final double attendanceRate;
  final int totalDays;
  final int attendedDays;
  final int absentDays;
  final DateTime? lastAttendanceDate;

  const ParentHomeAttendanceSummary({
    required this.attendanceRate,
    required this.totalDays,
    required this.attendedDays,
    required this.absentDays,
    this.lastAttendanceDate,
  });

  static const placeholder = ParentHomeAttendanceSummary(
    attendanceRate: 0.0,
    totalDays: 0,
    attendedDays: 0,
    absentDays: 0,
  );

  @override
  List<Object?> get props => [
    attendanceRate,
    totalDays,
    attendedDays,
    absentDays,
    lastAttendanceDate,
  ];

  ParentHomeAttendanceSummary copyWith({
    double? attendanceRate,
    int? totalDays,
    int? attendedDays,
    int? absentDays,
    DateTime? lastAttendanceDate,
  }) {
    return ParentHomeAttendanceSummary(
      attendanceRate: attendanceRate ?? this.attendanceRate,
      totalDays: totalDays ?? this.totalDays,
      attendedDays: attendedDays ?? this.attendedDays,
      absentDays: absentDays ?? this.absentDays,
      lastAttendanceDate: lastAttendanceDate ?? this.lastAttendanceDate,
    );
  }
}

class ParentHomeAcademicSummary extends Equatable {
  final double averageGrade;
  final double gradeTrend;
  final int enrolledCoursesCount;
  final int activeAssignmentsCount;
  final DateTime? nextDeadline;

  const ParentHomeAcademicSummary({
    required this.averageGrade,
    required this.gradeTrend,
    required this.enrolledCoursesCount,
    required this.activeAssignmentsCount,
    this.nextDeadline,
  });

  static const placeholder = ParentHomeAcademicSummary(
    averageGrade: 0.0,
    gradeTrend: 0.0,
    enrolledCoursesCount: 0,
    activeAssignmentsCount: 0,
  );

  @override
  List<Object?> get props => [
    averageGrade,
    gradeTrend,
    enrolledCoursesCount,
    activeAssignmentsCount,
    nextDeadline,
  ];

  ParentHomeAcademicSummary copyWith({
    double? averageGrade,
    double? gradeTrend,
    int? enrolledCoursesCount,
    int? activeAssignmentsCount,
    DateTime? nextDeadline,
  }) {
    return ParentHomeAcademicSummary(
      averageGrade: averageGrade ?? this.averageGrade,
      gradeTrend: gradeTrend ?? this.gradeTrend,
      enrolledCoursesCount: enrolledCoursesCount ?? this.enrolledCoursesCount,
      activeAssignmentsCount:
          activeAssignmentsCount ?? this.activeAssignmentsCount,
      nextDeadline: nextDeadline ?? this.nextDeadline,
    );
  }
}

class ParentHomeFinancialSummary extends Equatable {
  final double walletBalance;
  final double spentThisMonth;
  final String currency;
  final DateTime? lastTransactionDate;

  const ParentHomeFinancialSummary({
    required this.walletBalance,
    required this.spentThisMonth,
    required this.currency,
    this.lastTransactionDate,
  });

  static const placeholder = ParentHomeFinancialSummary(
    walletBalance: 0.0,
    spentThisMonth: 0.0,
    currency: 'EGP',
  );

  @override
  List<Object?> get props => [
    walletBalance,
    spentThisMonth,
    currency,
    lastTransactionDate,
  ];

  ParentHomeFinancialSummary copyWith({
    double? walletBalance,
    double? spentThisMonth,
    String? currency,
    DateTime? lastTransactionDate,
  }) {
    return ParentHomeFinancialSummary(
      walletBalance: walletBalance ?? this.walletBalance,
      spentThisMonth: spentThisMonth ?? this.spentThisMonth,
      currency: currency ?? this.currency,
      lastTransactionDate: lastTransactionDate ?? this.lastTransactionDate,
    );
  }
}

class ParentRecentActivityEntity extends Equatable {
  final String id;
  final String type;
  final String title;
  final String description;
  final DateTime timestamp;
  final Map<String, dynamic> metadata;

  const ParentRecentActivityEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    this.metadata = const {},
  });

  static final placeholder = ParentRecentActivityEntity(
    id: '',
    type: '',
    title: '',
    description: '',
    timestamp: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
    id,
    type,
    title,
    description,
    timestamp,
    metadata,
  ];

  ParentRecentActivityEntity copyWith({
    String? id,
    String? type,
    String? title,
    String? description,
    DateTime? timestamp,
    Map<String, dynamic>? metadata,
  }) {
    return ParentRecentActivityEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata ?? this.metadata,
    );
  }
}
