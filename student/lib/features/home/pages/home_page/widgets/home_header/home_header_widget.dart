import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';
import '../../../../../../core/routing/app_routes.dart';

final class HomeHeaderWidget extends StatelessWidget {
  final String studentName;
  final String greetingText;
  final int unreadCount;
  final String? avatarUrl;

  const HomeHeaderWidget({
    super.key,
    required this.studentName,
    required this.greetingText,
    required this.unreadCount,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => const ProfileViewPageRoute().push(context),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.brandPrimaryColor.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: Hero(
                tag: 'student_avatar',
                child: AppDynamicImage(
                  avatarUrl ?? '',
                  width: 52,
                  height: 52,
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greetingText,
                  style: TextStyle(
                    fontSize: 13,
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(2),
                Text(
                  studentName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: context.textPrimaryColor,
                    letterSpacing: -0.8,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
          const Gap(12),
          _LeaderboardButton(),
          const Gap(12),
          _NotificationButton(unreadCount: unreadCount),
        ],
      ),
    );
  }
}

final class _LeaderboardButton extends StatelessWidget {
  const _LeaderboardButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        shape: BoxShape.circle,
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => const LeaderboardPageRoute().push(context),
              borderRadius: BorderRadius.circular(26),
              child: Center(
                child: Icon(
                  Icons.emoji_events_outlined,
                  color: context.brandSecondaryColor,
                  size: 26,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class _NotificationButton extends StatelessWidget {
  final int unreadCount;

  const _NotificationButton({required this.unreadCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
            shape: BoxShape.circle,
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => const NotificationsPageRoute().push(context),
                  borderRadius: BorderRadius.circular(26),
                  child: Center(
                    child: Icon(
                      Icons.notifications_none_rounded,
                      color: context.textPrimaryColor,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (unreadCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: context.statusDangerColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.backgroundPrimaryColor,
                  width: 2.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.statusDangerColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Center(
                child: Text(
                  unreadCount > 9 ? '9+' : '$unreadCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
