part of '../mentorx_ui.dart';

class MentorXTile extends StatelessWidget {
  const MentorXTile({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius = 16,
    this.color,
    this.showBorder = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? color;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final baseColor = color ?? context.backgroundSecondaryColor;

    var style = Style(
      $box.borderRadius(borderRadius),
      $box.color(baseColor),
      $on.hover($box.color(baseColor.withValues(alpha: 0.95))),
    );

    if (showBorder) {
      style = style.merge(
        Style(
          $box.border.all.color(
            context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
          $box.border.all.width(1.5),
        ),
      );
    }

    return Container(
      margin: margin,
      child: PressableBox(
        onPress: onTap,
        style: style,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
