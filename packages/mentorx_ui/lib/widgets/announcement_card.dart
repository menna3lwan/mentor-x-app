part of '../mentorx_ui.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    super.key,
    required this.title,
    required this.preview,
    required this.date,
    required this.isPinned,
    this.onTap,
  });

  final String title;
  final String preview;
  final String date;
  final bool isPinned;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final statusColor = isPinned ? context.brandPrimaryColor : context.textTertiaryColor;

    return PressableBox(
      onPress: onTap,
      child: Container(
        width: 240,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: statusColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: statusColor.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isPinned ? Icons.push_pin : Icons.notifications_none,
                  color: statusColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  isPinned ? 'PINNED' : 'UPDATE',
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                Text(
                  date,
                  style: TextStyle(
                    color: context.textTertiaryColor,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: context.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                preview,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: context.textTertiaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
