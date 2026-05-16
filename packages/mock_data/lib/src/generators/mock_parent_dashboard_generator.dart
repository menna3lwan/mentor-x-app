part of '../../mock_data.dart';

final class MockParentDashboardGenerator {
  MockParentDashboardGenerator._();

  static ParentHomeSummaryEntity homeSummary() {
    return ParentHomeSummaryEntity(
      parentId: 'parent1',
      parentName: 'Kamal Ayman',
      childrenCount: 1,
      totalUnreadNotifications: 2,
      children: [
        ParentChildSummaryEntity(
          studentId: 'child1',
          studentName: 'Ahmed Kamal',
          studentCode: 'S12345',
          grade: 'Primary 5',
          studyType: 'National',
          profileImageUrl: 'https://picsum.photos/200/200?child=1',
          activeEnrollments: 5,
          completedLessons: 45,
          totalAttendance: 19,
          unreadNotifications: 1,
        ),
      ],
    );
  }

  static ParentChildDashboardSummaryEntity childDashboardSummary(String childId) {
    return ParentChildDashboardSummaryEntity(
      studentId: childId,
      studentName: 'Ahmed Kamal',
      studentCode: 'S12345',
      grade: 'Primary 5',
      governorate: 'Cairo',
      schoolName: 'Future International School',
      studyType: 'National',
      centerName: 'Zayed Branch',
      profileImageUrl: 'https://picsum.photos/200/200?child=1',
      totalAttendance: 20,
      centerAttendance: 15,
      onlineAttendance: 5,
      activeEnrollments: 5,
      completedLessons: 45,
      inProgressLessons: 10,
      lockedLessons: 5,
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
