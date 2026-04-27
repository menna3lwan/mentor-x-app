part of '../mentorx_ui.dart';

enum StatusBadgeType {
  success,
  warning,
  danger,
  info,
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    this.label,
    this.color,
    this.message,
    this.status,
    this.useSolidColor = false,
    this.isSmall = false,
  }) : assert(
          (label != null && color != null) || (message != null && status != null),
          'Either (label and color) or (message and status) must be provided',
        );

  final String? label;
  final Color? color;
  final String? message;
  final StatusBadgeType? status;
  final bool useSolidColor;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    if (message != null) {
      return _buildAlert(context);
    }
    return _buildPill(context);
  }

  Widget _buildPill(BuildContext context) {
    final effectiveColor = color!;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8 : 10,
        vertical: isSmall ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: useSolidColor ? effectiveColor : effectiveColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: useSolidColor ? null : Border.all(color: effectiveColor.withValues(alpha: 0.2)),
      ),
      child: Text(
        label!,
        style: TextStyle(
          color: useSolidColor ? Colors.white : effectiveColor,
          fontSize: isSmall ? 10 : 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildAlert(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    
    final Color effectiveColor = switch (status!) {
      StatusBadgeType.success => palette.statusSuccess,
      StatusBadgeType.warning => palette.statusWarning,
      StatusBadgeType.danger => palette.statusDanger,
      StatusBadgeType.info => palette.brandPrimary,
    };

    return Container(
      width: isSmall ? null : double.infinity,
      padding: EdgeInsets.all(isSmall ? 8 : 12),
      decoration: BoxDecoration(
        color: useSolidColor ? effectiveColor : effectiveColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(isSmall ? 8 : 12),
        border: Border.all(
          color: effectiveColor.withValues(alpha: useSolidColor ? 0 : 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIcon(),
            color: useSolidColor ? Colors.white : effectiveColor,
            size: isSmall ? 16 : 20,
          ),
          SizedBox(width: isSmall ? 8 : 12),
          if (isSmall)
            Text(
              message!,
              style: TextStyle(
                color: useSolidColor ? Colors.white : effectiveColor,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            )
          else
            Expanded(
              child: Text(
                message!,
                style: TextStyle(
                  color: useSolidColor ? Colors.white : effectiveColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    return switch (status!) {
      StatusBadgeType.success => Icons.check_circle_outline_rounded,
      StatusBadgeType.warning => Icons.warning_amber_rounded,
      StatusBadgeType.danger => Icons.error_outline_rounded,
      StatusBadgeType.info => Icons.info_outline_rounded,
    };
  }
}
