part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentHomeRepositoryExceptionCode {
  unknown,
  fetchError,
}

final class ParentHomeRepositoryException
    extends MentorXException<ParentHomeRepositoryExceptionCode> {
  const ParentHomeRepositoryException({required super.code, super.message});
}

abstract interface class ParentHomeRepository {
  Future<void> initialize();

  Future<ParentHomeSummaryEntity> getSummary(String studentId);

  Future<ParentChildDashboardSummaryEntity> getChildOverview(String studentId);

  Future<List<ParentRecentActivityEntity>> getRecentActivity(
    String studentId, {
    int limit = 10,
    int page = 1,
  });

  Future<List<AnnouncementEntity>> getAnnouncements(
    String studentId, {
    int limit = 3,
  });
}
