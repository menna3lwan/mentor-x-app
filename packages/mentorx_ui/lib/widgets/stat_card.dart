part of '../mentorx_ui.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = MentorXThemeProvider.of(context);
    final backgroundSecondary = theme.colors[$mentorxToken.color.backgroundSecondary]!;
    final backgroundElevatedSurfaceShadow = theme.colors[$mentorxToken.color.backgroundElevatedSurfaceShadow]!;
    final textPrimary = theme.colors[$mentorxToken.color.textPrimary]!;
    final textSecondary = theme.colors[$mentorxToken.color.textSecondary]!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundSecondary,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: backgroundElevatedSurfaceShadow.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: backgroundElevatedSurfaceShadow.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
