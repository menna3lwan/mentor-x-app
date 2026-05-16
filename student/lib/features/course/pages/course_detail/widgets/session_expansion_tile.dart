import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';

import 'session_item_tile.dart';

final class SessionExpansionTile extends StatelessWidget {
  final SessionEntity session;
  final List<WeekEntity> weeks;
  final List<SessionItemEntity> items;
  final ValueChanged<SessionItemEntity> onItemTap;

  const SessionExpansionTile({
    super.key,
    required this.session,
    required this.weeks,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      borderRadius: BorderRadius.circular(28),
      style: Style(
        $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.45)),
        $box.border.all.color(
          context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        $box.shadows(context.softShadow),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          childrenPadding: const EdgeInsets.only(bottom: 12),
          iconColor: context.brandPrimaryColor,
          collapsedIconColor: context.textTertiaryColor,
          leading: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.brandPrimaryColor.withValues(alpha: 0.15),
                  context.brandPrimaryColor.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.brandPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: Center(
              child: Text(
                '${session.orderIndex + 1}',
                style: context.bodyPrimaryStyle.copyWith(
                  fontWeight: FontWeight.w900,
                  color: context.brandPrimaryColor,
                  fontSize: 18,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          title: Text(
            session.title,
            style: context.bodyPrimaryStyle.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -0.3,
            ),
          ),
          subtitle: Row(
            children: [
              Icon(
                Icons.layers_rounded,
                size: 14,
                color: context.textTertiaryColor,
              ),
              const Gap(6),
              Text(
                '${session.itemCount} ${context.t.course.detail.items}',
                style: context.smallTextStyle.copyWith(
                  color: context.textTertiaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (session.isFree) ...[
                const Gap(12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: context.statusSuccessColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    context.t.course.detail.sessionFree.toUpperCase(),
                    style: context.smallTextStyle.copyWith(
                      color: context.statusSuccessColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ],
          ),
          children: weeks.isNotEmpty
              ? weeks.map((week) {
                  return _WeekGroup(
                    week: week,
                    onItemTap: onItemTap,
                  );
                }).toList()
              : items.map((item) {
                  return SessionItemTile(
                    item: item,
                    onTap: () => onItemTap(item),
                  );
                }).toList(),
        ),
      ),
    );
  }
}

final class _WeekGroup extends StatelessWidget {
  final WeekEntity week;
  final ValueChanged<SessionItemEntity> onItemTap;

  const _WeekGroup({
    required this.week,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: context.brandSecondaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  week.title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: context.brandSecondaryColor,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Divider(
                  color: context.borderPrimaryColor.withValues(alpha: 0.05),
                ),
              ),
            ],
          ),
        ),
        ...week.materials.map((item) {
          return SessionItemTile(
            item: item,
            onTap: () => onItemTap(item),
          );
        }),
      ],
    );
  }
}
