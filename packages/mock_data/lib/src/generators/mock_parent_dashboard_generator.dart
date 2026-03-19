part of '../../mock_data.dart';

final class MockParentDashboardGenerator {
  MockParentDashboardGenerator._();

  static List<({String title, String value, String subtitle, int colorValue, IconData icon})> stats() {
    return [
      (
        title: 'This Week',
        value: '20',
        subtitle: 'Lessons Completed',
        colorValue: 0xFFE3F2FD, // Colors.blue.shade50
        icon: Icons.check_circle,
      ),
      (
        title: 'Study Time',
        value: '5.2h',
        subtitle: '+1.2h from last week',
        colorValue: 0xFFE8F5E9, // Colors.green.shade50
        icon: Icons.access_time,
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

  static List<({String title, String date, IconData icon})> recentAchievements() {
    return [
      (
        title: 'Perfect Quiz Score',
        date: 'Oct 12, 2025',
        icon: Icons.emoji_events,
      ),
      (
        title: '7 Day Study Streak',
        date: 'Oct 10, 2025',
        icon: Icons.local_fire_department,
      ),
      (
        title: 'Course Completed',
        date: 'Oct 8, 2025',
        icon: Icons.school,
      ),
    ];
  }

  static String aiInsight() {
    return 'Alex shows strong improvement in algebra. Consider introducing geometry concepts next.';
  }
}
