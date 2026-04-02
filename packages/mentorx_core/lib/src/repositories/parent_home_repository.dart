part of '../../mentorx_core.dart';

abstract interface class ParentHomeRepository {
  Future<
    List<
      ({
        String title,
        String value,
        String subtitle,
        int colorValue,
        int iconCodePoint,
      })
    >
  >
  getStats();

  Future<List<({String subject, double performance})>> getSubjectPerformance();

  Future<List<({String title, String date, int iconCodePoint})>>
  getRecentAchievements();

  Future<String> getAiInsight();
}
