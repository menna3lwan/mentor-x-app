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
    final backgroundSecondary =
        theme.colors[$mentorxToken.color.backgroundSecondary]!;
    final backgroundElevatedSurfaceShadow =
        theme.colors[$mentorxToken.color.backgroundElevatedSurfaceShadow]!;
    final textPrimary = theme.colors[$mentorxToken.color.textPrimary]!;
    final textSecondary = theme.colors[$mentorxToken.color.textSecondary]!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundSecondary,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: textPrimary.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: backgroundElevatedSurfaceShadow.withValues(alpha: 0.8),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 24, color: iconColor),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: textSecondary,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
