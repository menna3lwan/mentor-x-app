part of '../mentorx_core.dart';

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
  /// Fetch announcements with optional filters and pagination.
  Future<List<AnnouncementEntity>> getAnnouncements({
    String? search,
    bool? pinned,
    int page = 1,
    int limit = 20,
  });

  /// Fetch a single announcement detail.
  Future<AnnouncementEntity> getAnnouncementDetail(String announcementId);
}
