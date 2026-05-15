import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

/// Full announcement card for the archive page. Larger than the home-screen
/// horizontal-carousel variant; designed for vertical reading.
class AnnouncementArchiveCardWidget extends StatelessWidget {
  final AnnouncementEntity announcement;
  final String readMoreLabel;
  final VoidCallback? onTap;

  const AnnouncementArchiveCardWidget({
    super.key,
    required this.announcement,
    required this.readMoreLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM yyyy').format(announcement.createdAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.08),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
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
                        color: context.brandPrimaryColor
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.campaign_rounded,
                        color: context.brandPrimaryColor,
                        size: 20,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: Text(
                        announcement.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: context.textPrimaryColor,
                          letterSpacing: -0.3,
                          height: 1.3,
                        ),
                      ),
                    ),
                    if (announcement.isPinned) ...[
                      const Gap(8),
                      Icon(
                        Icons.push_pin_rounded,
                        color: context.statusWarningColor,
                        size: 18,
                      ),
                    ],
                  ],
                ),
                const Gap(16),
                Text(
                  announcement.preview ?? '',
                  style: TextStyle(
                    fontSize: 13,
                    color: context.textSecondaryColor,
                    height: 1.5,
                  ),
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: context.textTertiaryColor,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          readMoreLabel,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: context.brandPrimaryColor,
                          ),
                        ),
                        const Gap(4),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: context.brandPrimaryColor,
                          size: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnnouncementArchiveCardSkeleton extends StatelessWidget {
  const AnnouncementArchiveCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: MentorXSkeleton(height: 168, borderRadius: 24),
    );
  }
}
