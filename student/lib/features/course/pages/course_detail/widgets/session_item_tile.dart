import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';

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
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    typeColor.withValues(alpha: 0.2),
                    typeColor.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
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
                    style: context.bodyPrimaryStyle.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(4),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: context.smallTextStyle.copyWith(
                        color: context.textTertiaryColor,
                        fontWeight: FontWeight.w800,
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
                  context.t.course.detail.free.toUpperCase(),
                  style: context.smallTextStyle.copyWith(
                    color: context.statusSuccessColor,
                    fontSize: 10,
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
                color: context.backgroundPrimaryColor.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: context.textTertiaryColor,
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
      SessionItemType.youtube => Icons.play_circle_filled_rounded,
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
      SessionItemType.youtube => context.brandPrimaryColor,
    };
  }
}
