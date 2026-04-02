part of '../../mock_data.dart';

final class MockParentDashboardGenerator {
  MockParentDashboardGenerator._();

  static const _checkCircleCodePoint = 0xe86c;
  static const _accessTimeCodePoint = 0xe192;
  static const _emojiEventsCodePoint = 0xe838;
  static const _localFireDepartmentCodePoint = 0xef55;
  static const _schoolCodePoint = 0xe80c;

  static List<
    ({
      String title,
      String value,
      String subtitle,
      int colorValue,
      int iconCodePoint,
    })
  >
  stats() {
    return [
      (
        title: 'This Week',
        value: '20',
        subtitle: 'Lessons Completed',
        colorValue: 0xFFE3F2FD, // Colors.blue.shade50
        iconCodePoint: _checkCircleCodePoint,
      ),
      (
        title: 'Study Time',
        value: '5.2h',
        subtitle: '+1.2h from last week',
        colorValue: 0xFFE8F5E9, // Colors.green.shade50
        iconCodePoint: _accessTimeCodePoint,
      ),
    ];
  }

  static List<({String subject, double performance})> subjectPerformance() {
    return [
      (subject: 'Mathematics', performance: 0.85),
      (subject: 'Physics', performance: 0.72),
      (subject: 'Chemistry', performance: 0.90),
      (subject: 'Biology', performance: 0.65),
      (subject: 'History', performance: 0.78),
    ];
  }

  static List<({String title, String date, int iconCodePoint})>
  recentAchievements() {
    return [
      (
        title: 'Perfect Quiz Score',
        date: 'Oct 12, 2025',
        iconCodePoint: _emojiEventsCodePoint,
      ),
      (
        title: '7 Day Study Streak',
        date: 'Oct 10, 2025',
        iconCodePoint: _localFireDepartmentCodePoint,
      ),
      (
        title: 'Course Completed',
        date: 'Oct 8, 2025',
        iconCodePoint: _schoolCodePoint,
      ),
    ];
  }

  static String aiInsight() {
    return 'Alex shows strong improvement in algebra. Consider introducing geometry concepts next.';
  }
}
