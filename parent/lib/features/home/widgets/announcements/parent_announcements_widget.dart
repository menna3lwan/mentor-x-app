import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:intl/intl.dart';

/// Horizontal scroller of announcement cards. Re-uses [AnnouncementScrollView]
/// + [AnnouncementCard] from the shared design system so it matches the
/// student app exactly.
class ParentAnnouncementsWidget extends StatelessWidget {
  final List<AnnouncementEntity> announcements;
  final String sectionTitle;
  final ValueChanged<AnnouncementEntity>? onAnnouncementTap;

  const ParentAnnouncementsWidget({
    super.key,
    required this.announcements,
    required this.sectionTitle,
    this.onAnnouncementTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnnouncementScrollView(
      title: sectionTitle,
      itemCount: announcements.length,
      itemBuilder: (context, index) {
        final announcement = announcements[index];
        return AnnouncementCard(
          title: announcement.title,
          preview: announcement.preview ?? '',
          date: DateFormat('MMM d').format(announcement.createdAt),
          isPinned: announcement.isPinned,
          onTap: onAnnouncementTap == null
              ? () {}
              : () => onAnnouncementTap!(announcement),
        );
      },
    );
  }
}

class ParentAnnouncementsSkeleton extends StatelessWidget {
  const ParentAnnouncementsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: 3,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, _) {
          return const MentorXSkeleton(
            width: 240,
            height: 120,
            borderRadius: 20,
          );
        },
      ),
    );
  }
}
