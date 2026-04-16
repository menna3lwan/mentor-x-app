import '../models/parent_portal_models.dart';

abstract interface class ParentPortalRepository {
  Future<List<ParentChild>> getChildren();

  Future<ParentChild> linkChild({
    required String query,
    required String relationship,
  });

  Future<void> unlinkChild(String childId);

  Future<List<ParentCourseProgress>> getCourses({String? childId});

  Future<List<ParentAssessmentRecord>> getAssessments({
    String? childId,
    String filter = 'all',
  });

  Future<ParentAssessmentRecord?> getAssessmentById(String assessmentId);

  Future<List<ParentAttendanceRecord>> getAttendance({String? childId});

  Future<List<ParentFinancialTransaction>> getTransactions({
    String? childId,
    String filter = 'all',
  });

  Future<List<ParentNotificationItem>> getNotifications({String? childId});

  Future<List<ParentAnnouncementItem>> getAnnouncements({
    String? childId,
    String search = '',
  });

  Future<List<ParentWhatsappGroup>> getWhatsappGroups({String? childId});

  Future<ParentProfileData> getProfile();

  Future<ParentSettingsData> getSettings();

  Future<void> updateSettings(ParentSettingsData settings);
}
