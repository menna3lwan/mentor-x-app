part of '../../mock_data.dart';

final class MockParentDashboardGenerator {
  MockParentDashboardGenerator._();

  static ParentHomeSummaryEntity homeSummary() {
    return ParentHomeSummaryEntity(
      overview: const ParentHomeOverviewEntity(
        unpaidInvoicesCount: 2,
        avgAttendanceRate: 0.92,
        avgGrade: 88.5,
        totalPoints: 1250,
      ),
      upcomingSessions: const [],
      recentGrades: const [],
      latestAnnouncement: announcements().first,
      childrenSummaries: [
        ParentChildSummaryEntity(
          childId: 'child1',
          name: 'Ahmed Kamal',
          grade: 'Primary 5',
          attendanceRate: 0.95,
          averageGrade: 92.0,
          profileImageUrl: 'https://picsum.photos/200/200?child=1',
        ),
      ],
    );
  }

  static ParentChildDashboardSummaryEntity childDashboardSummary(String childId) {
    return ParentChildDashboardSummaryEntity(
      child: ParentChildEntity(
        id: childId,
        name: 'Ahmed Kamal',
        centerName: 'Zayed Branch',
        profileImageUrl: 'https://picsum.photos/200/200?child=1',
      ),
      attendance: const ParentHomeAttendanceSummary(
        attendanceRate: 0.95,
        totalDays: 20,
        attendedDays: 19,
        absentDays: 1,
      ),
      academics: const ParentHomeAcademicSummary(
        averageGrade: 92.0,
        gradeTrend: 0.05,
        enrolledCoursesCount: 5,
        activeAssignmentsCount: 3,
      ),
      financial: const ParentHomeFinancialSummary(
        walletBalance: 450.0,
        spentThisMonth: 120.0,
        currency: 'EGP',
      ),
      recentActivity: const [],
    );
  }

  static List<ParentRecentActivityEntity> recentActivity(String studentId) {
    return [
      ParentRecentActivityEntity(
        id: '1',
        type: 'quiz_graded',
        title: 'Quiz Graded',
        description: 'Mathematics Quiz 4 Graded: 95/100',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        metadata: {'score': 95, 'total': 100},
      ),
      ParentRecentActivityEntity(
        id: '2',
        type: 'attendance',
        title: 'Attendance Marked',
        description: 'Attended Physics Session',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        metadata: {'subject': 'Physics', 'status': 'present'},
      ),
      ParentRecentActivityEntity(
        id: '3',
        type: 'wallet',
        title: 'Wallet Recharge',
        description: 'Wallet recharged with 100.0 EGP',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        metadata: {'amount': 100.0, 'currency': 'EGP'},
      ),
    ];
  }

  static List<AnnouncementEntity> announcements() {
    return [
      AnnouncementEntity(
        id: '1',
        title: 'New Physics Course Available',
        preview: 'A new advanced physics course has been added to the catalog.',
        content: 'Check out the new Physics course by Prof. Einstein. Starting next week!',
        priority: 'high',
        isPinned: true,
        tenantName: 'MentorX Academy',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      AnnouncementEntity(
        id: '2',
        title: 'Parent-Teacher Meeting',
        preview: 'Join us this Friday for the monthly progress review.',
        content: 'The meeting will be held virtually via Zoom at 6:00 PM.',
        priority: 'normal',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }
}
