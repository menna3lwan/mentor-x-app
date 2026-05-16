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
    final statusColor = isPinned
        ? context.brandPrimaryColor
        : context.secondaryGreen;

    return PressableBox(
      onPress: onTap,
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: statusColor.withValues(alpha: 0.1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: context.backgroundElevatedSurfaceShadowColor.withValues(
                alpha: 0.5,
              ),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    isPinned ? Icons.push_pin_rounded : Icons.campaign_rounded,
                    color: statusColor,
                    size: 14,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  isPinned
                      ? t_ui.widgets.announcement.pinned
                      : t_ui.widgets.announcement.update,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                Text(
                  date,
                  style: context.smallTextStyle.copyWith(
                    color: context.textSecondaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodyPrimaryStyle.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: context.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                preview,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.bodySecondaryStyle.copyWith(
                  fontSize: 12,
                  color: context.textSecondaryColor,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
