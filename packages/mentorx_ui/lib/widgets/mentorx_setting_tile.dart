part of '../mentorx_ui.dart';

class MentorXSettingTile extends StatelessWidget {
  const MentorXSettingTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.isDestructive = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onTap,
      style: Style(
        $box.padding.all(16),
        $box.borderRadius(16),
        $box.color(context.backgroundSecondaryColor),
        $box.border.all.color(context.borderPrimaryColor.withValues(alpha: 0.1)),
        $box.border.all.width(1.5),
        $on.hover($box.color(context.backgroundTertiaryColor.withValues(alpha: 0.3))),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const Gap(16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: context.bodyPrimaryStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isDestructive ? context.statusDangerColor : context.textPrimaryColor,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: context.smallTextStyle,
                  ),
              ],
            ),
          ),
          if (trailing != null || onTap != null) ...[
            const Gap(12),
            trailing ??
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: context.textTertiaryColor,
                ),
          ],
        ],
      ),
    );
  }
}

class MentorXInfoTile extends StatelessWidget {
  const MentorXInfoTile({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: context.brandPrimaryColor, size: 20),
            const Gap(16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.smallTextStyle.copyWith(
                    color: context.textSecondaryColor,
                  ),
                ),
                const Gap(4),
                Text(
                  value,
                  style: context.bodyPrimaryStyle.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
