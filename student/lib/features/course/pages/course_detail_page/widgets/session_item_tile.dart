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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            Icon(
              _iconForType(item.itemType),
              size: 20,
              color: _colorForType(item.itemType, palette),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (_subtitle != null)
                    Text(
                      _subtitle!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: palette.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            if (item.isFree)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: palette.statusSuccess.withAlpha(26),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  context.t.course.detail.free,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: palette.statusSuccess,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right,
              size: 18,
              color: palette.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  String? get _subtitle {
    if (item.durationSeconds != null) {
      final mins = item.durationSeconds! ~/ 60;
      return '${mins}m';
    }
    if (item.pageCount != null) {
      return '${item.pageCount} pages';
    }
    return null;
  }

  static IconData _iconForType(SessionItemType type) {
    return switch (type) {
      SessionItemType.video => Icons.play_circle_outline,
      SessionItemType.pdf => Icons.picture_as_pdf_outlined,
      SessionItemType.quiz => Icons.quiz_outlined,
      SessionItemType.assignment => Icons.assignment_outlined,
      SessionItemType.note => Icons.note_outlined,
      SessionItemType.link => Icons.link,
      SessionItemType.audio => Icons.headphones_outlined,
    };
  }

  static Color _colorForType(
    SessionItemType type,
    MentorXThemeColorPalette palette,
  ) {
    return switch (type) {
      SessionItemType.video => palette.brandPrimary,
      SessionItemType.pdf => Colors.red.shade400,
      SessionItemType.quiz => Colors.orange.shade400,
      SessionItemType.assignment => Colors.teal.shade400,
      SessionItemType.note => Colors.blue.shade400,
      SessionItemType.link => Colors.purple.shade400,
      SessionItemType.audio => Colors.indigo.shade400,
    };
  }
}
