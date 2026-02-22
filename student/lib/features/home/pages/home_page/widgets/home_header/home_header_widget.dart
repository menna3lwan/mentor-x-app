import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class HomeHeaderWidget extends StatelessWidget {
  final String studentName;
  final String greetingText;
  final int unreadCount;

  const HomeHeaderWidget({
    super.key,
    required this.studentName,
    required this.greetingText,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: palette.brandTertiary,
          child: Icon(Icons.person, color: palette.brandPrimary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t.home.dashboard.greetingWithName(
                  greeting: greetingText,
                  name: studentName,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: palette.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
            ),
            if (unreadCount > 0)
              Positioned(
                right: 6,
                top: 8,
                child: Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: palette.statusDanger,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    unreadCount > 9 ? '9+' : '$unreadCount',
                    style: TextStyle(
                      color: palette.textForeground,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
