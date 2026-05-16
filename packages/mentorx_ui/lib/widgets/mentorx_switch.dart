part of '../mentorx_ui.dart';

class MentorXSwitch extends StatelessWidget {
  const MentorXSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: value,
      onChanged: onChanged,
      activeColor: context.brandPrimaryColor,
      activeTrackColor: context.brandPrimaryColor.withValues(alpha: 0.2),
    );
  }
}

class MentorXSwitchTile extends StatelessWidget {
  const MentorXSwitchTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.leading,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String title;
  final String? subtitle;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: () => onChanged(!value),
      style: Style(
        $box.padding.all(16),
        $box.borderRadius(16),
        $box.color(context.backgroundSecondaryColor),
        $box.border.all.color(
          context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        $box.border.all.width(1.5),
        $on.hover(
          $box.color(context.backgroundTertiaryColor.withValues(alpha: 0.3)),
        ),
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
          const Gap(12),
          MentorXSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
