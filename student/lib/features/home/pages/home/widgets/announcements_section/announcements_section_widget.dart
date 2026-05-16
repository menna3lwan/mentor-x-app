import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:mentorx_student/core/core.dart';
import '../inline_section_error/inline_section_error_wrapper.dart';

final class AnnouncementsSectionWidget extends StatelessWidget {
  final List<AnnouncementEntity>? announcements;
  final bool isLoading;
  final bool hasFailedWithEmptyData;
  final VoidCallback onRetry;

  const AnnouncementsSectionWidget({
    super.key,
    required this.announcements,
    required this.isLoading,
    required this.hasFailedWithEmptyData,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (hasFailedWithEmptyData) {
      return InlineSectionError(onRetry: onRetry);
    }

    final announcementItems = announcements ?? const <AnnouncementEntity>[];

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        itemCount: announcementItems.isEmpty ? 2 : announcementItems.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const Gap(12),
        itemBuilder: (context, index) {
          final announcement = announcementItems.isEmpty
              ? null
              : announcementItems[index];
          return _AnnouncementCard(announcement: announcement);
        },
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final AnnouncementEntity? announcement;

  const _AnnouncementCard({this.announcement});

  @override
  Widget build(BuildContext context) {
    final isPinned = announcement?.isPinned ?? false;
    final title =
        announcement?.title ?? context.t.home.dashboard.loadingAnnouncement;
    final preview =
        announcement?.preview ??
        context.t.home.dashboard.loadingAnnouncementDetails;
    final createdAt = announcement?.createdAt ?? DateTime.now();

    return MentorXGlassCard(
      borderRadius: BorderRadius.circular(24),
      opacity: isPinned ? 0.15 : 0.08,
      borderOpacity: isPinned ? 0.3 : 0.1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isPinned
                        ? context.brandPrimaryColor.withValues(alpha: 0.1)
                        : context.backgroundPrimaryColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isPinned ? Icons.push_pin_rounded : Icons.campaign_rounded,
                    size: 18,
                    color: context.brandPrimaryColor,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.titleH3Style.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        DateFormat.yMMMd().add_jm().format(createdAt),
                        style: context.smallTextStyle.copyWith(
                          fontSize: 10,
                          color: context.textTertiaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(16),
            Text(
              preview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.bodyPrimaryStyle.copyWith(
                color: context.textSecondaryColor,
                height: 1.5,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
