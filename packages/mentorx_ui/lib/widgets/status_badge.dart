part of '../mentorx_ui.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.color,
    this.useSolidColor = false,
  });

  final String label;
  final Color color;
  final bool useSolidColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: useSolidColor ? color : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: useSolidColor ? null : Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: useSolidColor ? context.textForegroundColor : color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
