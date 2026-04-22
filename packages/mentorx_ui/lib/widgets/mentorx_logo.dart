part of '../mentorx_ui.dart';

class MentorXLogo extends StatelessWidget {
  const MentorXLogo({super.key, this.size = 95});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF183764),
        borderRadius: BorderRadius.circular(size * 0.26),
      ),
      child: Icon(
        Icons.school,
        color: Colors.white,
        size: size * 0.47,
      ),
    );
  }
}
