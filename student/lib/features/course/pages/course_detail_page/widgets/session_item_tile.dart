import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

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
    final palette = MentorXThemeColorPalette.light;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _colorForType(item.itemType, palette).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _iconForType(item.itemType),
                size: 20,
                color: _colorForType(item.itemType, palette),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: palette.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  if (_subtitle != null)
                    Text(
                      _subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: palette.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
            if (item.isFree) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: palette.statusSuccess.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  context.t.course.detail.free,
                  style: TextStyle(
                    color: palette.statusSuccess,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            const SizedBox(width: 12),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: palette.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  String? get _subtitle {
    if (item.durationSeconds != null) {
      final mins = item.durationSeconds! ~/ 60;
      final secs = item.durationSeconds! % 60;
      return '${mins}m ${secs}s';
    }
    if (item.pageCount != null) {
      return '${item.pageCount} pages';
    }
    return null;
  }

  static IconData _iconForType(SessionItemType type) {
    return switch (type) {
      SessionItemType.video => Icons.play_arrow_rounded,
      SessionItemType.pdf => Icons.description_rounded,
      SessionItemType.quiz => Icons.quiz_rounded,
      SessionItemType.assignment => Icons.assignment_rounded,
      SessionItemType.note => Icons.sticky_note_2_rounded,
      SessionItemType.link => Icons.link_rounded,
      SessionItemType.audio => Icons.headset_rounded,
    };
  }

  static Color _colorForType(
    SessionItemType type,
    MentorXThemeColorPalette palette,
  ) {
    return switch (type) {
      SessionItemType.video => palette.brandPrimary,
      SessionItemType.pdf => const Color(0xFFEF5350),
      SessionItemType.quiz => const Color(0xFFFFA726),
      SessionItemType.assignment => const Color(0xFF26A69A),
      SessionItemType.note => const Color(0xFF42A5F5),
      SessionItemType.link => const Color(0xFFAB47BC),
      SessionItemType.audio => const Color(0xFF5C6BC0),
    };
  }
}
