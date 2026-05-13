
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:gap/gap.dart';

import 'package:mentorx_core/mentorx_core.dart';
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
    final title = announcement?.title ?? context.t.home.dashboard.loadingAnnouncement;
    final preview = announcement?.preview ?? context.t.home.dashboard.loadingAnnouncementDetails;
    final createdAt = announcement?.createdAt ?? DateTime.now();

    return Container(
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isPinned
              ? context.brandPrimaryColor.withValues(alpha: 0.2)
              : context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isPinned
                        ? context.brandPrimaryColor.withValues(alpha: 0.1)
                        : context.backgroundPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isPinned ? Icons.push_pin_rounded : Icons.campaign_rounded,
                    size: 16,
                    color: context.brandPrimaryColor,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: context.textPrimaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd().add_jm().format(createdAt),
                        style: TextStyle(
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
            const Gap(12),
            Text(
              preview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.textSecondaryColor,
                height: 1.4,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
