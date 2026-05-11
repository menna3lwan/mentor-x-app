import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';

final class SessionItemTile extends StatelessWidget {
  final SessionItemEntity item;
  final VoidCallback onTap;

  const SessionItemTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final subtitle = _getSubtitle(context);
    final typeColor = _colorForType(context, item.itemType);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    typeColor.withValues(alpha: 0.2),
                    typeColor.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: typeColor.withValues(alpha: 0.1),
                ),
              ),
              child: Icon(
                _iconForType(item.itemType),
                size: 22,
                color: typeColor,
              ),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.textTertiaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                ],
              ),
            ),
            if (item.isFree) ...[
              const Gap(12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: context.statusSuccessColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
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
            const Gap(12),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: context.backgroundPrimaryColor.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: context.textTertiaryColor.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _getSubtitle(BuildContext context) {
    if (item.durationSeconds != null) {
      final mins = item.durationSeconds! ~/ 60;
      final secs = item.durationSeconds! % 60;
      return context.t.course.detail.durationShort(mins: mins, secs: secs);
    }
    if (item.pageCount != null) {
      return context.t.course.detail.pagesCount(count: item.pageCount!);
    }
    return null;
  }

  static IconData _iconForType(SessionItemType type) {
    return switch (type) {
      SessionItemType.video => Icons.play_arrow_rounded,
      SessionItemType.document => Icons.description_rounded,
      SessionItemType.quiz => Icons.quiz_rounded,
      SessionItemType.assignment => Icons.assignment_rounded,
      SessionItemType.link => Icons.link_rounded,
      SessionItemType.audio => Icons.headset_rounded,
    };
  }

  Color _colorForType(
    BuildContext context,
    SessionItemType type,
  ) {
    return switch (type) {
      SessionItemType.video => context.brandPrimaryColor,
      SessionItemType.document => context.statusDangerColor,
      SessionItemType.quiz => context.statusWarningColor,
      SessionItemType.assignment => context.statusSuccessColor,
      SessionItemType.link => context.brandSecondaryColor,
      SessionItemType.audio => context.brandTertiaryColor,
    };
  }
}
