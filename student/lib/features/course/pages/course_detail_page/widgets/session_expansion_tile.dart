import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              childrenPadding: const EdgeInsets.only(bottom: 12),
              iconColor: context.brandPrimaryColor,
              collapsedIconColor: context.textTertiaryColor,
              leading: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.brandPrimaryColor.withValues(alpha: 0.15),
                      context.brandPrimaryColor.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  ),
                ),
                child: Center(
                  child: Text(
                    '${session.orderIndex + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: context.brandPrimaryColor,
                      fontSize: 16,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              title: Text(
                session.title,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.3,
                ),
              ),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.layers_rounded,
                    size: 12,
                    color: context.textTertiaryColor,
                  ),
                  const Gap(6),
                  Text(
                    '${session.itemCount} ${context.t.course.detail.items}',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.textTertiaryColor,
                      fontWeight: FontWeight.w700,
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
                        style: TextStyle(
                          color: context.statusSuccessColor,
                          fontSize: 8,
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
        ...week.items.map((item) {
          return SessionItemTile(
            item: item,
            onTap: () => onItemTap(item),
          );
        }),
      ],
    );
  }
}
