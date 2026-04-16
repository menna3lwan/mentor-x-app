import 'dart:math';

import '../models/parent_portal_models.dart';
import 'parent_portal_repository.dart';

final class MockParentPortalRepository implements ParentPortalRepository {
  MockParentPortalRepository({
    Duration delay = const Duration(milliseconds: 350),
  }) : _delay = delay;

  final Duration _delay;
  final Random _random = Random();

  final List<ParentChild> _children = [
    ParentChild(
      id: 'child-1',
      fullName: 'Youssef Ahmed',
      gradeName: 'Grade 10',
      tenantName: 'MentorX Maadi',
      studentCode: 'MX-1001',
      relationship: 'Father',
      isVerified: true,
      linkedAt: DateTime.now().subtract(const Duration(days: 80)),
    ),
    ParentChild(
      id: 'child-2',
      fullName: 'Salma Ahmed',
      gradeName: 'Grade 7',
      tenantName: 'MentorX Maadi',
      studentCode: 'MX-2045',
      relationship: 'Father',
      isVerified: true,
      linkedAt: DateTime.now().subtract(const Duration(days: 40)),
    ),
  ];

  final List<ParentCourseProgress> _courses = [
    ParentCourseProgress(
      id: 'course-physics',
      title: 'Advanced Physics',
      teacherName: 'Mr. Adel',
      progressPercent: 72,
      completedSessions: 18,
      totalSessions: 25,
      timeSpentHours: 21.5,
      lastAccessedAt: DateTime.now().subtract(const Duration(days: 1)),
      expiresAt: DateTime.now().add(const Duration(days: 50)),
    ),
    ParentCourseProgress(
      id: 'course-math',
      title: 'Algebra Mastery',
      teacherName: 'Ms. Reem',
      progressPercent: 90,
      completedSessions: 27,
      totalSessions: 30,
      timeSpentHours: 24.0,
      lastAccessedAt: DateTime.now().subtract(const Duration(days: 2)),
      expiresAt: DateTime.now().add(const Duration(days: 20)),
    ),
    ParentCourseProgress(
      id: 'course-chem',
      title: 'Chemistry Fundamentals',
      teacherName: 'Dr. Mina',
      progressPercent: 43,
      completedSessions: 9,
      totalSessions: 21,
      timeSpentHours: 11.2,
      lastAccessedAt: DateTime.now().subtract(const Duration(days: 3)),
      expiresAt: DateTime.now().add(const Duration(days: 64)),
    ),
  ];

  final List<ParentAssessmentRecord> _assessments = [
    ParentAssessmentRecord(
      id: 'assess-q-1',
      title: 'Forces and Motion Quiz',
      courseName: 'Advanced Physics',
      type: 'quiz',
      score: 17,
      totalScore: 20,
      date: DateTime.now().subtract(const Duration(days: 4)),
      status: 'Graded',
      attempts: 1,
    ),
    ParentAssessmentRecord(
      id: 'assess-a-1',
      title: 'Quadratic Equations Assignment',
      courseName: 'Algebra Mastery',
      type: 'assignment',
      score: 9,
      totalScore: 10,
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: 'Graded',
      attempts: 1,
    ),
    ParentAssessmentRecord(
      id: 'assess-a-2',
      title: 'Chemical Bonds Worksheet',
      courseName: 'Chemistry Fundamentals',
      type: 'assignment',
      score: 0,
      totalScore: 10,
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Pending',
      attempts: 0,
    ),
  ];

  final List<ParentAttendanceRecord> _attendance = List.generate(16, (index) {
    final date = DateTime.now().subtract(Duration(days: index));
    final statuses = ['present', 'late', 'absent', 'excused'];
    final status = statuses[index % statuses.length];
    return ParentAttendanceRecord(
      id: 'att-$index',
      date: date,
      sessionName: 'Session ${index + 1}',
      centerName: 'MentorX Branch ${index % 3 + 1}',
      startTime: '18:00',
      endTime: '20:00',
      status: status,
      checkInTime: status == 'absent'
          ? null
          : '18:${(index % 6) * 5}'.padLeft(2, '0'),
      teacherNotes: status == 'late' ? 'Arrived after grace period.' : null,
    );
  });

  final List<ParentFinancialTransaction> _transactions = List.generate(20, (
    index,
  ) {
    final isCredit = index % 4 == 0;
    final amount = isCredit ? 150.0 + index : -(60.0 + (index * 4));
    return ParentFinancialTransaction(
      id: 'txn-$index',
      description: isCredit ? 'Wallet Top-up' : 'Course Purchase #${index + 1}',
      amount: amount,
      balanceAfter: 1200 - (index * 18),
      createdAt: DateTime.now().subtract(Duration(days: index)),
      type: isCredit ? 'Credit' : 'Purchase',
      paymentMethod: isCredit ? 'InstaPay' : 'Wallet',
      status: 'Completed',
    );
  });

  final List<ParentNotificationItem> _notifications = List.generate(18, (
    index,
  ) {
    final types = [
      'quiz_result',
      'assignment_graded',
      'attendance_marked',
      'payment',
    ];
    return ParentNotificationItem(
      id: 'notif-$index',
      studentName: index.isEven ? 'Youssef Ahmed' : 'Salma Ahmed',
      type: types[index % types.length],
      title: index.isEven ? 'New grade posted' : 'Attendance updated',
      body: index.isEven
          ? 'A new assessment score was published for your child.'
          : 'Attendance status was updated for today\'s session.',
      isRead: index > 5,
      createdAt: DateTime.now().subtract(Duration(hours: index * 3)),
    );
  });

  final List<ParentAnnouncementItem> _announcements = List.generate(10, (
    index,
  ) {
    return ParentAnnouncementItem(
      id: 'ann-$index',
      title: 'Announcement ${index + 1}',
      content:
          'Center update for parents regarding exams, class schedules, and holiday timing. Ref #${index + 1}.',
      isPinned: index < 2,
      priority: index < 3 ? 'high' : 'normal',
      publishedAt: DateTime.now().subtract(Duration(days: index)),
    );
  });

  final List<ParentWhatsappGroup> _groups = const [
    ParentWhatsappGroup(
      id: 'group-1',
      name: 'Grade 10 Parents',
      targetType: 'grade_group',
      inviteUrl: 'https://chat.whatsapp.com/grade10',
    ),
    ParentWhatsappGroup(
      id: 'group-2',
      name: 'MentorX Parents Main',
      targetType: 'parents_group',
      inviteUrl: 'https://chat.whatsapp.com/parentsmain',
    ),
  ];

  final ParentProfileData _profile = ParentProfileData(
    fullName: 'Ahmed Hassan',
    phone: '01000000000',
    email: 'ahmed.parent@example.com',
    createdAt: DateTime(2024, 1, 10),
    relationships: const {
      'Youssef Ahmed': 'Father',
      'Salma Ahmed': 'Father',
    },
  );

  ParentSettingsData _settings = const ParentSettingsData(
    languageCode: 'en',
    themeMode: 'system',
    pushNotificationsEnabled: true,
    categoryPreferences: {
      'attendance': true,
      'grades': true,
      'assignments': true,
      'payments': true,
      'announcements': true,
      'system': true,
    },
  );

  @override
  Future<List<ParentChild>> getChildren() async {
    await Future.delayed(_delay);
    return List<ParentChild>.from(_children);
  }

  @override
  Future<ParentChild> linkChild({
    required String query,
    required String relationship,
  }) async {
    await Future.delayed(_delay);
    final child = ParentChild(
      id: 'child-${_children.length + 1}',
      fullName: 'Linked Student ${_children.length + 1}',
      gradeName: 'Grade ${7 + _random.nextInt(5)}',
      tenantName: 'MentorX Online',
      studentCode: query.toUpperCase(),
      relationship: relationship,
      isVerified: _random.nextBool(),
      linkedAt: DateTime.now(),
    );
    _children.add(child);
    return child;
  }

  @override
  Future<void> unlinkChild(String childId) async {
    await Future.delayed(_delay);
    _children.removeWhere((item) => item.id == childId);
  }

  @override
  Future<List<ParentCourseProgress>> getCourses({String? childId}) async {
    await Future.delayed(_delay);
    return List<ParentCourseProgress>.from(_courses);
  }

  @override
  Future<List<ParentAssessmentRecord>> getAssessments({
    String? childId,
    String filter = 'all',
  }) async {
    await Future.delayed(_delay);
    if (filter == 'all') {
      return List<ParentAssessmentRecord>.from(_assessments);
    }
    return _assessments.where((item) => item.type == filter).toList();
  }

  @override
  Future<ParentAssessmentRecord?> getAssessmentById(String assessmentId) async {
    await Future.delayed(_delay);
    for (final item in _assessments) {
      if (item.id == assessmentId) {
        return item;
      }
    }
    return null;
  }

  @override
  Future<List<ParentAttendanceRecord>> getAttendance({String? childId}) async {
    await Future.delayed(_delay);
    return List<ParentAttendanceRecord>.from(_attendance);
  }

  @override
  Future<List<ParentFinancialTransaction>> getTransactions({
    String? childId,
    String filter = 'all',
  }) async {
    await Future.delayed(_delay);
    if (filter == 'all') {
      return List<ParentFinancialTransaction>.from(_transactions);
    }
    if (filter == 'credits') {
      return _transactions.where((item) => item.isCredit).toList();
    }
    if (filter == 'purchases') {
      return _transactions.where((item) => !item.isCredit).toList();
    }
    return List<ParentFinancialTransaction>.from(_transactions);
  }

  @override
  Future<List<ParentNotificationItem>> getNotifications({
    String? childId,
  }) async {
    await Future.delayed(_delay);
    if (childId == null || childId.isEmpty) {
      return List<ParentNotificationItem>.from(_notifications);
    }
    return _notifications
        .where(
          (item) =>
              (childId == 'child-1' && item.studentName.contains('Youssef')) ||
              (childId == 'child-2' && item.studentName.contains('Salma')),
        )
        .toList();
  }

  @override
  Future<List<ParentAnnouncementItem>> getAnnouncements({
    String? childId,
    String search = '',
  }) async {
    await Future.delayed(_delay);
    if (search.trim().isEmpty) {
      return List<ParentAnnouncementItem>.from(_announcements);
    }
    final query = search.toLowerCase().trim();
    return _announcements
        .where(
          (item) =>
              item.title.toLowerCase().contains(query) ||
              item.content.toLowerCase().contains(query),
        )
        .toList();
  }

  @override
  Future<List<ParentWhatsappGroup>> getWhatsappGroups({String? childId}) async {
    await Future.delayed(_delay);
    return List<ParentWhatsappGroup>.from(_groups);
  }

  @override
  Future<ParentProfileData> getProfile() async {
    await Future.delayed(_delay);
    return _profile;
  }

  @override
  Future<ParentSettingsData> getSettings() async {
    await Future.delayed(_delay);
    return _settings;
  }

  @override
  Future<void> updateSettings(ParentSettingsData settings) async {
    await Future.delayed(_delay);
    _settings = settings;
  }
}
