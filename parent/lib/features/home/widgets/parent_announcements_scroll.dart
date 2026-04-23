import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:intl/intl.dart';

class ParentAnnouncementsScroll extends StatelessWidget {
  final List<AnnouncementEntity> announcements;

  const ParentAnnouncementsScroll({super.key, required this.announcements});

  @override
  Widget build(BuildContext context) {
    return AnnouncementScrollView(
      title: 'Announcements',
      itemCount: announcements.length,
      itemBuilder: (context, index) {
        final announcement = announcements[index];
        return AnnouncementCard(
          title: announcement.title,
          preview: announcement.preview ?? '',
          date: DateFormat('MMM d').format(announcement.createdAt),
          isPinned: announcement.isPinned,
          onTap: () {},
        );
      },
    );
  }
}
