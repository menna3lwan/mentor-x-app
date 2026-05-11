import 'dart:ui';
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
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const Gap(16),
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

          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isPinned
                      ? context.brandPrimaryColor.withValues(alpha: 0.4)
                      : context.borderPrimaryColor.withValues(alpha: 0.1),
                  width: isPinned ? 1.5 : 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ExcludeSemantics(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: const SizedBox.expand(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isPinned
                                      ? context.brandPrimaryColor.withValues(alpha: 0.1)
                                      : context.backgroundPrimaryColor.withValues(alpha: 0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isPinned
                                      ? Icons.push_pin_rounded
                                      : Icons.campaign_rounded,
                                  size: 20,
                                  color: isPinned
                                      ? context.brandPrimaryColor
                                      : context.brandPrimaryColor.withValues(alpha: 0.5),
                                ),
                              ),
                              const Gap(16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(
                                        color: context.textPrimaryColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                    const Gap(6),
                                    Text(
                                      DateFormat.yMMMd().add_jm().format(createdAt),
                                      style: TextStyle(
                                        fontSize: 11,
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
                            style: TextStyle(
                              color: context.textSecondaryColor,
                              height: 1.5,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
