part of '../parent_ui.dart';

class ClickableTextWidget extends StatelessWidget {
  const ClickableTextWidget({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    required this.alignment,
  });

  final String text;
  final Color color;
  final void Function()? onPressed;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: color, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
