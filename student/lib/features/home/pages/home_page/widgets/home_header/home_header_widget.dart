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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [palette.brandPrimary, palette.brandSecondary],
              ),
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: palette.backgroundPrimary,
              child: Icon(Icons.person_rounded, color: palette.brandPrimary, size: 24),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greetingText,
                  style: TextStyle(
                    fontSize: 14,
                    color: palette.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  studentName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: palette.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: palette.backgroundPrimary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: palette.textPrimary.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: palette.textPrimary,
                  ),
                ),
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: palette.statusDanger,
                      shape: BoxShape.circle,
                      border: Border.all(color: palette.backgroundPrimary, width: 2),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      unreadCount > 9 ? '9+' : '$unreadCount',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: palette.textForeground,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
