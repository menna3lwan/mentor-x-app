import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => const ProfileViewPageRoute().push(context),
                child: Hero(
                  tag: 'student_avatar',
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.brandPrimaryColor.withValues(alpha: 0.2),
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: context.backgroundSecondaryColor,
                      child: AppDynamicImage(
                        avatarUrl ?? '',
                        width: 56,
                        height: 56,
                        borderRadius: BorderRadius.circular(100),
                        errorWidget: Icon(
                          Icons.person_rounded,
                          color: context.brandPrimaryColor,
                        ),
                      ),
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
                        color: context.textTertiaryColor,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        fontSize: 10,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      studentName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.titleH2Style.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.8,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              _NotificationButton(unreadCount: unreadCount),
            ],
          ),
          const Gap(24),
          _SearchShortcut(),
        ],
      ),
    );
  }
}

final class _SearchShortcut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: () => const CourseCatalogPageRoute().push(context),
      style: Style(
        $box.padding.all(16),
        $box.borderRadius(20),
        $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.5)),
        $box.border.all.color(
          context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        $on.hover(
          $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.8)),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: context.textTertiaryColor,
            size: 20,
          ),
          const Gap(12),
          Text(
            context.t.core.search,
            style: context.bodyPrimaryStyle.copyWith(
              color: context.textTertiaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: context.backgroundPrimaryColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.tune_rounded,
              size: 16,
              color: context.brandPrimaryColor,
            ),
          ),
        ],
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
        MentorXIconButton(
          onPressed: () => const NotificationsPageRoute().push(context),
          icon: Icons.notifications_none_rounded,
          variant: MentorXIconButtonVariant.outline,
          size: MentorXIconButtonSize.medium,
        ),
        if (unreadCount > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: context.statusDangerColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.backgroundPrimaryColor,
                  width: 2,
                ),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Center(
                child: Text(
                  unreadCount > 9 ? '9+' : '$unreadCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
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
