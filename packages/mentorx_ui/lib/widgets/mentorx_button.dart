part of '../mentorx_ui.dart';

class MentorXButton extends StatelessWidget {
  const MentorXButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
    this.loading = false,
  });

  final String text;
  final void Function()? onPressed;
  final Style? style;
  final bool loading;

  Style _defaultStyle() {
    return Style(
      $box.width.infinity(),
      $box.padding.vertical(18),
      $box.borderRadius(14),
      $box.alignment.center(),
      $box.color.ref($mentorxToken.color.brandPrimary),
      $text.style.ref($mentorxToken.textStyle.bodyPrimary),
      $text.style.color.ref($mentorxToken.color.textForeground),
      $text.style.fontWeight.w800(),
      $text.style.fontSize(16),
      $on.hover(
        $box.color.ref($mentorxToken.color.brandPressed),
      ),
      $on.disabled(
        $box.color.grey.shade300(),
        $text.style.color.grey.shade500(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: loading ? null : onPressed,
      style: _defaultStyle().merge(style),
      child: loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          : TextSpecWidget(text),
    );
  }
}
