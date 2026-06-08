import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

/// Vertical list of recent activity entries for the selected child.
class ParentActivityFeedWidget extends StatelessWidget {
  final List<ParentRecentActivityEntity> activities;

  /// Called when a row is tapped. Receives the activity so the caller can
  /// route to the right destination (attendance/grades/financial/etc).
  final ValueChanged<ParentRecentActivityEntity>? onActivityTap;

  const ParentActivityFeedWidget({
    super.key,
    required this.activities,
    this.onActivityTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: activities.asMap().entries.map((entry) {
        final index = entry.key;
        final activity = entry.value;
        final date = DateFormat('dd MMM, hh:mm a').format(activity.timestamp);
        final iconData = _getIconData(context, activity.type);

        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: ActivityListTile(
            title: activity.title,
            description: activity.description,
            date: date,
            icon: iconData.icon,
            onTap: onActivityTap == null
                ? null
                : () => onActivityTap!(activity),
          ),
        );
      }).toList(),
    );
  }

  ({IconData icon, Color color}) _getIconData(
    BuildContext context,
    String type,
  ) {
    switch (type.toLowerCase()) {
      case 'attendance':
        return (
          icon: Icons.calendar_today_rounded,
          color: context.brandPrimaryColor,
        );
      case 'grade':
        return (icon: Icons.grade_rounded, color: context.statusSuccessColor);
      case 'payment':
        return (
          icon: Icons.account_balance_wallet_rounded,
          color: context.brandSecondaryColor,
        );
      case 'announcement':
        return (
          icon: Icons.campaign_rounded,
          color: context.statusWarningColor,
        );
      default:
        return (
          icon: Icons.notifications_rounded,
          color: context.textTertiaryColor,
        );
    }
  }
}

/// Empty-state card shown when the activity list is loaded but empty.
class ParentActivityFeedEmpty extends StatelessWidget {
  final String title;
  final String hint;

  const ParentActivityFeedEmpty({
    super.key,
    required this.title,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.backgroundTertiaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.history_rounded,
                size: 40,
                color: context.textTertiaryColor.withValues(alpha: 0.3),
              ),
            ),
            const Gap(20),
            Text(
              title,
              style: TextStyle(
                color: context.textPrimaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 18,
                letterSpacing: -0.5,
              ),
            ),
            const Gap(8),
            Text(
              hint,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textSecondaryColor,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton placeholder shown while the activity feed is loading.
class ParentActivityFeedSkeleton extends StatelessWidget {
  const ParentActivityFeedSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (i) => Padding(
          padding: EdgeInsets.only(bottom: i == 2 ? 0 : 12),
          child: const MentorXSkeleton(height: 72, borderRadius: 20),
        ),
      ),
    );
  }
}
