part of '../../mentorx_core.dart';

abstract interface class ParentHomeRepository {
  Future<List<({String title, String value, String subtitle, int colorValue, IconData icon})>> getStats();
  
  Future<List<({String subject, double performance})>> getSubjectPerformance();
  
  Future<List<({String title, String date, IconData icon})>> getRecentAchievements();
  
  Future<String> getAiInsight();
}
