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
    final announcementItems =
        announcements ?? const <AnnouncementEntity>[];

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        itemCount: announcementItems.isEmpty ? 2 : announcementItems.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final announcement =
              announcementItems.isEmpty ? null : announcementItems[index];
          final isPinned = announcement?.isPinned ?? false;
          final title = announcement?.title ??
              context.t.home.dashboard.loadingAnnouncement;
          final preview = announcement?.preview ??
              context.t.home.dashboard.loadingAnnouncementDetails;
          final createdAt = announcement?.createdAt ?? DateTime.now();
          return Container(
            decoration: BoxDecoration(
              color: palette.backgroundPrimary,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (isPinned) ...[
                      Icon(Icons.push_pin_rounded,
                          size: 16, color: palette.statusWarning),
                      const SizedBox(width: 6),
                    ],
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: palette.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  preview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: palette.textSecondary),
                ),
                const SizedBox(height: 8),
                Text(
                  DateFormat.yMMMd().add_jm().format(createdAt),
                  style: TextStyle(fontSize: 12, color: palette.textSecondary),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
