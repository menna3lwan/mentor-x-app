import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

/// Single notification list row.
class NotificationCardWidget extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback? onTap;

  const NotificationCardWidget({
    super.key,
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM • hh:mm a').format(notification.createdAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.08),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.brandPrimaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.notifications_active_rounded,
                    color: context.brandPrimaryColor,
                    size: 22,
                  ),
                ),
                const Gap(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: context.textPrimaryColor,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        notification.message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: context.textSecondaryColor,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                      const Gap(6),
                      Text(
                        date,
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
          ),
        ),
      ),
    );
  }
}

class NotificationCardSkeleton extends StatelessWidget {
  const NotificationCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: MentorXSkeleton(height: 92, borderRadius: 20),
    );
  }
}
