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
        color: context.brandPrimaryColor,
        borderRadius: BorderRadius.circular(size * 0.26),
        boxShadow: [
          BoxShadow(
            color: context.brandPrimaryColor.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        Icons.school_rounded,
        color: Colors.white,
        size: size * 0.47,
      ),
    );
  }
}
