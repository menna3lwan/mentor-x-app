part of '../mentorx_ui.dart';

enum MentorXButtonVariant { filled, outline, text, ghost }

enum MentorXButtonSize { small, medium, large }

class MentorXButton extends StatelessWidget {
  const MentorXButton({
    super.key,
    this.text,
    this.label,
    this.onPressed,
    this.style,
    this.loading = false,
    this.icon,
    this.color,
    this.variant = MentorXButtonVariant.filled,
    this.size = MentorXButtonSize.medium,
    this.width,
    this.analyticsName,
  });

  final String? text;
  final String? label;
  final void Function()? onPressed;
  final Style? style;
  final bool loading;
  final IconData? icon;
  final Color? color;
  final MentorXButtonVariant variant;
  final MentorXButtonSize size;
  final double? width;
  final String? analyticsName;

  String get _displayText => label ?? text ?? '';

  Style _variantStyle(BuildContext context) {
    final baseColor = color ?? context.brandPrimaryColor;

    return switch (variant) {
      MentorXButtonVariant.filled => Style(
          $box.color(baseColor),
          $text.style.color(Colors.white),
          $on.hover($box.color(baseColor.withValues(alpha: 0.9))),
        ),
      MentorXButtonVariant.outline => Style(
          $box.color(Colors.transparent),
          $box.border.all.color(baseColor),
          $box.border.all.width(1.5),
          $text.style.color(baseColor),
          $on.hover($box.color(baseColor.withValues(alpha: 0.05))),
        ),
      MentorXButtonVariant.text || MentorXButtonVariant.ghost => Style(
          $box.color(Colors.transparent),
          $text.style.color(baseColor),
          $on.hover($box.color(baseColor.withValues(alpha: 0.05))),
        ),
    };
  }

  Style _sizeStyle() {
    return switch (size) {
      MentorXButtonSize.small => Style(
          $box.padding.vertical(10),
          $box.padding.horizontal(16),
          $text.style.fontSize(13),
          $text.style.fontWeight.w700(),
        ),
      MentorXButtonSize.medium => Style(
          $box.padding.vertical(16),
          $box.padding.horizontal(24),
          $text.style.fontSize(15),
          $text.style.fontWeight.w800(),
        ),
      MentorXButtonSize.large => Style(
          $box.padding.vertical(20),
          $box.padding.horizontal(32),
          $text.style.fontSize(17),
          $text.style.fontWeight.w900(),
        ),
    };
  }

  Style _defaultStyle(BuildContext context) {
    return Style(
      $box.width(width ?? double.infinity),
      $box.borderRadius(16),
      $box.alignment.center(),
      $text.style.ref($mentorxToken.textStyle.bodyPrimary),
      $text.style.letterSpacing(-0.2),
      $on.disabled(
        $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.5)),
        $text.style.color(context.textTertiaryColor),
        $box.border.all.color(Colors.transparent),
      ),
    ).merge(_variantStyle(context)).merge(_sizeStyle());
  }

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress:
          loading
              ? null
              : () {
                if (analyticsName != null) {
                  MentorXUI.onAnalyticsEvent?.call('button_click', {
                    'button_name': analyticsName,
                    'button_text': _displayText,
                  });
                }
                onPressed?.call();
              },
      style: _defaultStyle(context).merge(style),
      child: loading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation(
                  variant == MentorXButtonVariant.filled
                      ? Colors.white
                      : (color ?? context.brandPrimaryColor),
                ),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: size == MentorXButtonSize.small ? 16 : 20,
                    color: variant == MentorXButtonVariant.filled
                        ? Colors.white
                        : (color ?? context.brandPrimaryColor),
                  ),
                  const Gap(10),
                ],
                TextSpecWidget(_displayText),
              ],
            ),
    );
  }
}
