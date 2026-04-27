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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [palette.brandPrimary, palette.brandPrimary.withOpacity(0.4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: palette.brandPrimary.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: Icon(Icons.person_rounded, color: palette.brandPrimary, size: 28),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greetingText,
                  style: TextStyle(
                    fontSize: 13,
                    color: palette.textTertiary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  studentName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: palette.textPrimary,
                    letterSpacing: -0.8,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
          _NotificationButton(unreadCount: unreadCount, palette: palette),
        ],
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  final int unreadCount;
  final MentorXThemeColorPalette palette;

  const _NotificationButton({required this.unreadCount, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: palette.backgroundSecondary),
          ),
          child: IconButton(
            onPressed: () {
              // Navigate to notifications
            },
            icon: Icon(
              Icons.notifications_outlined,
              color: palette.textPrimary,
              size: 24,
            ),
          ),
        ),
        if (unreadCount > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: palette.statusDanger,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: palette.statusDanger.withOpacity(0.3),
                    blurRadius: 4,
                  ),
                ],
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                unreadCount > 9 ? '9+' : '$unreadCount',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
