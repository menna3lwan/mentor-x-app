import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

/// Compact list-row for a single attendance group. Displays the group name,
/// optional teacher / course, today's first session line and an active badge.
class AttendanceGroupCard extends StatelessWidget {
  final ParentAttendanceGroupEntity group;
  final String activeLabel;
  final String inactiveLabel;
  final String enrolledLabel;
  final String? scheduleLine;
  final VoidCallback? onTap;

  const AttendanceGroupCard({
    super.key,
    required this.group,
    required this.activeLabel,
    required this.inactiveLabel,
    required this.enrolledLabel,
    this.scheduleLine,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = group.isActive
        ? context.statusSuccessColor
        : context.textTertiaryColor;
    return Material(
      color: context.backgroundSecondaryColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: context.brandPrimaryColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.groups_rounded,
                      color: context.brandPrimaryColor,
                      size: 22,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: context.textPrimaryColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                        if (group.teacherName != null &&
                            group.teacherName!.isNotEmpty) ...[
                          const Gap(2),
                          Text(
                            group.teacherName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: context.textSecondaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Gap(8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      group.isActive ? activeLabel : inactiveLabel,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(12),
              Row(
                children: [
                  Icon(
                    Icons.person_outline_rounded,
                    size: 13,
                    color: context.textTertiaryColor,
                  ),
                  const Gap(4),
                  Text(
                    enrolledLabel,
                    style: TextStyle(
                      color: context.textTertiaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (scheduleLine != null && scheduleLine!.isNotEmpty) ...[
                    const Gap(12),
                    Icon(
                      Icons.access_time_rounded,
                      size: 13,
                      color: context.textTertiaryColor,
                    ),
                    const Gap(4),
                    Expanded(
                      child: Text(
                        scheduleLine!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: context.textTertiaryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
