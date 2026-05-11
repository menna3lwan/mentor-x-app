part of '../mentorx_ui.dart';

class MentorXMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MentorXMainAppBar({
    super.key,
    required this.studentName,
    required this.greetingText,
    this.unreadCount = 0,
    this.onNotificationTap,
    this.onProfileTap,
    this.avatarUrl,
  });

  final String studentName;
  final String greetingText;
  final int unreadCount;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 8, 20, 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: onProfileTap,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    context.brandPrimaryColor,
                    context.brandSecondaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.brandPrimaryColor.withValues(alpha: 0.25),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: context.backgroundPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: AppDynamicImage(
                  avatarUrl ?? '',
                  width: 56,
                  height: 56,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  greetingText.toUpperCase(),
                  style: context.smallTextStyle.copyWith(
                    color: context.brandPrimaryColor,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                const Gap(2),
                Text(
                  studentName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.titleH2Style.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          _NotificationButton(
            unreadCount: unreadCount,
            onTap: onNotificationTap,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

final class _NotificationButton extends StatelessWidget {
  final int unreadCount;
  final VoidCallback? onTap;

  const _NotificationButton({required this.unreadCount, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        PressableBox(
          onPress: onTap,
          style: Style(
            $box.width(48),
            $box.height(48),
            $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.45)),
            $box.shape.circle(),
            $box.border.all.color(context.borderPrimaryColor.withValues(alpha: 0.1)),
            $on.hover($box.color(context.backgroundSecondaryColor.withValues(alpha: 0.6))),
          ),
          child: Icon(
            Icons.notifications_none_rounded,
            color: context.textPrimaryColor,
            size: 26,
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
                  color: context.backgroundSecondaryColor,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: context.statusDangerColor.withValues(alpha: 0.3),
                    blurRadius: 6,
                  ),
                ],
              ),
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Text(
                unreadCount > 9 ? '9+' : '$unreadCount',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
