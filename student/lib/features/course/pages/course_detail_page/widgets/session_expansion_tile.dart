import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'session_item_tile.dart';

final class SessionExpansionTile extends StatelessWidget {
  final SessionEntity session;
  final List<SessionItemEntity> items;
  final ValueChanged<SessionItemEntity> onItemTap;

  const SessionExpansionTile({
    super.key,
    required this.session,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      childrenPadding: const EdgeInsets.only(bottom: 8),
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: palette.brandPrimary.withAlpha(26),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '${session.orderIndex + 1}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: palette.brandPrimary,
            ),
          ),
        ),
      ),
      title: Text(
        session.title,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Row(
        children: [
          Text(
            '${session.itemCount} ${context.t.course.detail.items}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: palette.textSecondary),
          ),
          if (session.isFree) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: palette.statusSuccess.withAlpha(26),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                context.t.course.detail.sessionFree,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: palette.statusSuccess,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
      children: items.map((item) {
        return SessionItemTile(
          item: item,
          onTap: () => onItemTap(item),
        );
      }).toList(),
    );
  }
}
