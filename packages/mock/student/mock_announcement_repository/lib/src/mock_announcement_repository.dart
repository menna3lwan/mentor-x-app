import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockAnnouncementRepository implements AnnouncementRepository {
  final Duration delay;

  const MockAnnouncementRepository({required this.delay});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<AnnouncementEntity>> getAnnouncements({
    String? search,
    bool? pinned,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future<void>.delayed(delay);
    var announcements = MockAnnouncementGenerator.announcements();
    if (pinned != null) {
      announcements =
          announcements.where((a) => a.isPinned == pinned).toList();
    }
    if (search != null && search.isNotEmpty) {
      final q = search.toLowerCase();
      announcements =
          announcements
              .where(
                (a) =>
                    a.title.toLowerCase().contains(q) ||
                    a.preview.toLowerCase().contains(q),
              )
              .toList();
    }
    return announcements;
  }

  @override
  Future<AnnouncementEntity> getAnnouncementDetail(
    String announcementId,
  ) async {
    await Future<void>.delayed(delay ~/ 2);
    return MockAnnouncementGenerator.announcementDetail(announcementId);
  }
}
