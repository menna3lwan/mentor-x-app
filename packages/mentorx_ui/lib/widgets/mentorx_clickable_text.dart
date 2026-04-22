part of '../mentorx_ui.dart';

class MentorXClickableText extends StatelessWidget {
  const MentorXClickableText({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = const Color(0xFF183764),
    this.alignment = Alignment.center,
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
