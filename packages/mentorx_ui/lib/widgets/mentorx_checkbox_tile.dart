part of '../mentorx_ui.dart';

class MentorXCheckboxTile extends StatelessWidget {
  const MentorXCheckboxTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.leading,
    this.padding,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;
  final String title;
  final String? subtitle;
  final Widget? leading;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: () => onChanged(!value),
      style: Style(
        $box.padding.all(16),
        $box.borderRadius(16),
        $box.color(context.backgroundSecondaryColor),
        $box.border.all.color(
          value
              ? context.brandPrimaryColor.withValues(alpha: 0.2)
              : context.borderPrimaryColor.withValues(alpha: 0.1),
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
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: context.brandPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

class MentorXRadioTile<T> extends StatelessWidget {
  const MentorXRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.leading,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final String title;
  final String? subtitle;
  final Widget? leading;

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: () => onChanged(value),
      style: Style(
        $box.padding.all(16),
        $box.borderRadius(16),
        $box.color(context.backgroundSecondaryColor),
        $box.border.all.color(
          _isSelected
              ? context.brandPrimaryColor.withValues(alpha: 0.2)
              : context.borderPrimaryColor.withValues(alpha: 0.1),
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
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: context.brandPrimaryColor,
          ),
        ],
      ),
    );
  }
}
