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
    if (activities.isEmpty) {
      return FadeInUp(
        duration: const Duration(milliseconds: 600),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.history_rounded, 
                  size: 40, 
                  color: context.brandPrimaryColor.withValues(alpha: 0.3),
                ),
              ),
              const Gap(24),
              Text(
                'No Recent Activity',
                style: TextStyle(
                  color: context.textPrimaryColor,
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

    return Column(
      children: activities.asMap().entries.map((entry) {
        final index = entry.key;
        final activity = entry.value;
        final date = DateFormat('dd MMM, hh:mm a').format(activity.timestamp);
        final iconData = _getIconData(context, activity.type);
        
        return _ActivityCard(
          title: activity.title,
          description: activity.description,
          date: date,
          icon: iconData.icon,
          iconColor: iconData.color,
          index: index,
        );
      }).toList(),
    );
  }

  ({IconData icon, Color color}) _getIconData(BuildContext context, String type) {
    switch (type.toLowerCase()) {
      case 'attendance': 
        return (icon: Icons.calendar_today_rounded, color: context.brandPrimaryColor);
      case 'grade': 
        return (icon: Icons.grade_rounded, color: context.statusSuccessColor);
      case 'payment': 
        return (icon: Icons.account_balance_wallet_rounded, color: context.brandSecondaryColor);
      case 'announcement': 
        return (icon: Icons.campaign_rounded, color: context.statusWarningColor);
      default: 
        return (icon: Icons.notifications_rounded, color: context.textTertiaryColor);
    }
  }
}

class _ActivityCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final IconData icon;
  final Color iconColor;
  final int index;

  const _ActivityCard({
    required this.title,
    required this.description,
    required this.date,
    required this.icon,
    required this.iconColor,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      delay: Duration(milliseconds: 100 * index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: context.textPrimaryColor,
                      fontSize: 14,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    description,
                    style: TextStyle(
                      color: context.textSecondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(12),
            Text(
              date.split(',').first,
              style: TextStyle(
                color: context.textTertiaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
