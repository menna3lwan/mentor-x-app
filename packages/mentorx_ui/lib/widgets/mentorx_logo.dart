part of '../mentorx_ui.dart';

class MentorXLogo extends StatelessWidget {
  const MentorXLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 95,
          height: 95,
          decoration: BoxDecoration(
            color: const Color(0xFF183764),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(
            Icons.school,
            color: Colors.white,
            size: 45,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'MentorX',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF183764),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Welcome! Log in to continue',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
