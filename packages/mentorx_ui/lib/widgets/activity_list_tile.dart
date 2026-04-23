part of '../mentorx_ui.dart';

class ActivityListTile extends StatelessWidget {
  const ActivityListTile({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    this.icon = Icons.notifications_outlined,
    this.onTap,
  });

  final String title;
  final String description;
  final String date;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: context.brandPrimaryColor.withValues(alpha: 0.1),
        child: Icon(icon, color: context.brandPrimaryColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: context.textPrimaryColor,
        ),
      ),
      subtitle: Text(
        description,
        style: TextStyle(
          color: context.textSecondaryColor,
          fontSize: 13,
        ),
      ),
      trailing: Text(
        date,
        style: TextStyle(
          color: context.textTertiaryColor,
          fontSize: 11,
        ),
      ),
    );
  }
}
