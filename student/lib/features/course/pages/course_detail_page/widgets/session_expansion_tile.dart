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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: palette.backgroundPrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.textTertiary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.only(bottom: 12),
          leading: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: palette.brandPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '${session.orderIndex + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: palette.brandPrimary,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          title: Text(
            session.title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: palette.textPrimary,
            ),
          ),
          subtitle: Row(
            children: [
              Icon(Icons.layers_rounded, size: 12, color: palette.textTertiary),
              const SizedBox(width: 4),
              Text(
                '${session.itemCount} ${context.t.course.detail.items}',
                style: TextStyle(
                  fontSize: 12,
                  color: palette.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (session.isFree) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: palette.statusSuccess.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    context.t.course.detail.sessionFree,
                    style: TextStyle(
                      color: palette.statusSuccess,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
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
        ),
      ),
    );
  }
}
