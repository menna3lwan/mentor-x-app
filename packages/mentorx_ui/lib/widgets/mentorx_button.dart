part of '../mentorx_ui.dart';

class MentorXButton extends StatelessWidget {
  const MentorXButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: const Color(0xFFF59239),
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
