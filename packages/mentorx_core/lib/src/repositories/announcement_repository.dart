part of 'package:mentorx_core/mentorx_core.dart';

enum AnnouncementRepositoryExceptionCode {
  unknown,
  failedToLoadAnnouncements,
  failedToLoadAnnouncementDetail,
}

final class AnnouncementRepositoryException
    extends MentorXException<AnnouncementRepositoryExceptionCode> {
  AnnouncementRepositoryException({required super.code, super.message});
}

abstract interface class AnnouncementRepository {
  Future<void> initialize();

  /// Fetch announcements with optional filters and pagination.
  Future<List<AnnouncementEntity>> getAnnouncements({
    String? search,
    bool? pinned,
    MentorXPaginationInfo? paginationInfo,
  });

  /// Fetch a single announcement detail.
  Future<AnnouncementEntity> getAnnouncementDetail(String announcementId);
}
