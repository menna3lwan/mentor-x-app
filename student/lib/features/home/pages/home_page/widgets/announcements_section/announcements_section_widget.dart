import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

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

    final palette = MentorXThemeColorPalette.light;
    final announcementItems = announcements ?? const <AnnouncementEntity>[];

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        itemCount: announcementItems.isEmpty ? 2 : announcementItems.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final announcement = announcementItems.isEmpty
              ? null
              : announcementItems[index];
          final isPinned = announcement?.isPinned ?? false;
          final title =
              announcement?.title ??
              context.t.home.dashboard.loadingAnnouncement;
          final preview =
              announcement?.preview ??
              context.t.home.dashboard.loadingAnnouncementDetails;
          final createdAt = announcement?.createdAt ?? DateTime.now();

          return InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: palette.backgroundPrimary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isPinned
                      ? palette.brandPrimary.withOpacity(0.2)
                      : palette.backgroundTertiary,
                ),
                boxShadow: [
                  BoxShadow(
                    color: palette.textPrimary.withOpacity(0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isPinned
                              ? palette.brandTertiary
                              : palette.backgroundTertiary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isPinned
                              ? Icons.push_pin_rounded
                              : Icons.campaign_rounded,
                          size: 18,
                          color: isPinned
                              ? palette.brandPrimary
                              : palette.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                color: palette.textPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat.yMMMd().add_jm().format(createdAt),
                              style: TextStyle(
                                fontSize: 11,
                                color: palette.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    preview,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: palette.textSecondary,
                      height: 1.5,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
