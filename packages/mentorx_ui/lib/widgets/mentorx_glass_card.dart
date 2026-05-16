part of '../mentorx_ui.dart';

class MentorXGlassCard extends StatelessWidget {
  const MentorXGlassCard({
    super.key,
    required this.child,
    this.style,
    this.blur,
    this.opacity = 0.1,
    this.borderRadius,
    this.borderOpacity = 0.2,
  });

  final Widget child;
  final Style? style;
  final double? blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final double borderOpacity;

  @override
  Widget build(BuildContext context) {
    final effectiveBlur = blur ?? 15.0;
    final effectiveBorderRadius = borderRadius ?? context.mediumRadius;

    return Box(
      style: Style(
        $box.clipBehavior.antiAlias(),
        $box.borderRadius.all(effectiveBorderRadius.topLeft.x),
        $box.color(context.backgroundSecondaryColor.withValues(alpha: opacity)),
        $box.border.all.color(context.borderPrimaryColor.withValues(alpha: borderOpacity)),
        $box.border.all.width(1.5),
      ).merge(style),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: effectiveBlur, sigmaY: effectiveBlur),
        child: child,
      ),
    );
  }
}
