import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:parent/core/core.dart';
import 'package:intl/intl.dart';

class ParentActivityFeed extends StatelessWidget {
  final List<ParentRecentActivityEntity> activities;

  const ParentActivityFeed({
    super.key,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    if (activities.isEmpty) {
      return FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
          decoration: BoxDecoration(
            color: Colors.white,
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
                  color: palette.backgroundSecondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.history_rounded, size: 40, color: palette.textTertiary.withValues(alpha: 0.3)),
              ),
              const Gap(20),
              Text(
                'No Recent Activity',
                style: TextStyle(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  letterSpacing: -0.5,
                ),
              ),
              const Gap(8),
              Text(
                'Activities will appear here once your child starts their learning journey.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: palette.textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: activities.asMap().entries.map((entry) {
        final index = entry.key;
        final activity = entry.value;
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: _ActivityCard(
            activity: activity,
            palette: palette,
          ),
        );
      }).toList(),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final ParentRecentActivityEntity activity;
  final MentorXThemeColorPalette palette;

  const _ActivityCard({required this.activity, required this.palette});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd MMM, hh:mm a').format(activity.timestamp);
    final iconData = _getIconData(activity.type);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconData.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              iconData.icon,
              color: iconData.color,
              size: 24,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        activity.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: palette.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 11,
                        color: palette.textTertiary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Gap(6),
                Text(
                  activity.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: palette.textSecondary,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: palette.backgroundSecondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    activity.type.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      color: palette.textTertiary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ({IconData icon, Color color}) _getIconData(String type) {
    switch (type.toLowerCase()) {
      case 'attendance': 
        return (icon: Icons.calendar_today_rounded, color: palette.brandPrimary);
      case 'grade': 
        return (icon: Icons.grade_rounded, color: palette.statusSuccess);
      case 'payment': 
        return (icon: Icons.account_balance_wallet_rounded, color: palette.brandSecondary);
      case 'announcement': 
        return (icon: Icons.campaign_rounded, color: palette.statusWarning);
      default: 
        return (icon: Icons.notifications_rounded, color: palette.textTertiary);
    }
  }
}
