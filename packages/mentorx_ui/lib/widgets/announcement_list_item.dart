part of '../mentorx_ui.dart';

class AnnouncementListItem extends StatelessWidget {
  const AnnouncementListItem({
    super.key,
    required this.title,
    required this.preview,
    this.onTap,
    this.icon = Icons.campaign_outlined,
  });

  final String title;
  final String preview;
  final VoidCallback? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: context.backgroundSecondaryColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: context.brandPrimaryColor, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
            fontSize: 15,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            preview,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: context.textSecondaryColor,
              fontSize: 13,
            ),
          ),
        ),
        onTap: onTap,
        trailing: Icon(
          Icons.chevron_right_rounded, 
          color: context.textTertiaryColor.withValues(alpha: 0.5)
        ),
      ),
    );
  }
}
