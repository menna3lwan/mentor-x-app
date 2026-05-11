part of '../mentorx_ui.dart';

enum MentorXIconButtonVariant { filled, outline, ghost }

enum MentorXIconButtonSize {
  small(16, 8),
  medium(24, 12),
  large(32, 16);

  final double iconSize;
  final double padding;

  const MentorXIconButtonSize(this.iconSize, this.padding);
}

class MentorXIconButton extends StatelessWidget {
  const MentorXIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = MentorXIconButtonVariant.ghost,
    this.color,
    this.size = MentorXIconButtonSize.medium,
    this.style,
    this.tooltip,
    this.iconSize,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final MentorXIconButtonVariant variant;
  final Color? color;
  final MentorXIconButtonSize size;
  final Style? style;
  final String? tooltip;
  final double? iconSize;

  Style _defaultStyle(BuildContext context) {
    final baseColor = color ?? context.brandPrimaryColor;

    return Style(
      $box.padding.all(size.padding),
      $box.borderRadius(12),
      $box.color(Colors.transparent),
      $on.hover($box.color(baseColor.withValues(alpha: 0.1))),
    ).merge(
      switch (variant) {
        MentorXIconButtonVariant.filled => Style(
            $box.color(baseColor),
            $on.hover($box.color(baseColor.withValues(alpha: 0.9))),
          ),
        MentorXIconButtonVariant.outline => Style(
            $box.border.all.color(baseColor.withValues(alpha: 0.2)),
            $box.border.all.width(1.5),
          ),
        MentorXIconButtonVariant.ghost => Style(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = variant == MentorXIconButtonVariant.filled
        ? Colors.white
        : (color ?? context.brandPrimaryColor);

    final widget = PressableBox(
      onPress: onPressed,
      style: _defaultStyle(context).merge(style),
      child: Icon(
        icon,
        size: iconSize ?? size.iconSize,
        color: iconColor,
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: widget,
      );
    }

    return widget;
  }
}
