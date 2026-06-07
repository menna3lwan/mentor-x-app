import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:animate_do/animate_do.dart';

final class NotificationsPage extends StatelessWidget {
  final List<NotificationEntity> notifications;
  final LoadingState loadingState;
  final bool hasMore;
  final ScrollController scrollController;
  final RefreshCallback onRefresh;
  final ValueChanged<NotificationEntity> onNotificationTap;
  final VoidCallback onMarkAllAsRead;

  const NotificationsPage({
    super.key,
    required this.notifications,
    required this.loadingState,
    required this.hasMore,
    required this.scrollController,
    required this.onRefresh,
    required this.onNotificationTap,
    required this.onMarkAllAsRead,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.notifications;
    final isLoading = loadingState == LoadingState.loading;
    final isInitialLoading = isLoading && notifications.isEmpty;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _BuildHeader(
            t: t,
            hasNotifications: notifications.isNotEmpty,
            onMarkAllAsRead: onMarkAllAsRead,
          ),
          Expanded(
            child: isInitialLoading
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    itemCount: 8,
                    itemBuilder: (_, _) => const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: MentorXSkeleton(height: 120, borderRadius: 28),
                    ),
                  )
                : notifications.isEmpty
                ? AppEmptyView(
                    title: t.noNotifications,
                    message: t.noNotificationsDesc,
                    icon: Icons.notifications_off_rounded,
                  )
                : RefreshIndicator(
                    color: context.brandPrimaryColor,
                    onRefresh: onRefresh,
                    child: ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      itemCount: notifications.length + (hasMore ? 1 : 0),
                      itemBuilder: (context, i) {
                        if (i == notifications.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: MentorXSkeleton(
                              height: 60,
                              borderRadius: 20,
                            ),
                          );
                        }

                        final notification = notifications[i];
                        return FadeInUp(
                          duration: const Duration(milliseconds: 500),
                          delay: Duration(milliseconds: 50 * i),
                          child: _NotificationItem(
                            notification: notification,
                            onTap: () => onNotificationTap(notification),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final dynamic t;
  final bool hasNotifications;
  final VoidCallback onMarkAllAsRead;

  const _BuildHeader({
    required this.t,
    required this.hasNotifications,
    required this.onMarkAllAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ALERTS',
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.notificationsTitle,
                      style: context.titleH1Style.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasNotifications)
                MentorXIconButton(
                  onPressed: onMarkAllAsRead,
                  icon: Icons.done_all_rounded,
                  variant: MentorXIconButtonVariant.ghost,
                  size: MentorXIconButtonSize.small,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _NotificationItem extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;

  const _NotificationItem({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;
    final color = _getNotificationColor(context, notification.type);
    final icon = _getNotificationIcon(notification.type);
    final formattedDate = DateFormat(
      'dd MMM yyyy, hh:mm a',
    ).format(notification.createdAt);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: MentorXGlassCard(
        style: Style(
          $box.padding.all(0),
          isUnread
              ? $box.border.all.color(
                  context.brandPrimaryColor.withValues(alpha: 0.2),
                )
              : null,
          isUnread ? $box.border.all.width(1.5) : null,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withValues(alpha: 0.2),
                        color.withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: color.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Icon(icon, size: 24, color: color),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: context.bodyPrimaryStyle.copyWith(
                                fontWeight: FontWeight.w900,
                                color: isUnread
                                    ? context.brandPrimaryColor
                                    : context.textPrimaryColor,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: context.brandSecondaryColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: context.brandSecondaryColor
                                        .withValues(
                                          alpha: 0.4,
                                        ),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const Gap(6),
                      Text(
                        notification.message,
                        style: context.bodySecondaryStyle.copyWith(
                          fontSize: 12,
                          height: 1.5,
                          fontWeight: isUnread
                              ? FontWeight.w700
                              : FontWeight.w600,
                        ),
                      ),
                      const Gap(16),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 14,
                            color: context.textTertiaryColor,
                          ),
                          const Gap(6),
                          Text(
                            formattedDate,
                            style: context.bodySecondaryStyle.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getNotificationColor(
    BuildContext context,
    NotificationType type,
  ) {
    switch (type) {
      case NotificationType.quiz:
        return context.brandSecondaryColor;
      case NotificationType.announcement:
        return context.brandPrimaryColor;
      case NotificationType.success:
        return context.statusSuccessColor;
      case NotificationType.system:
        return Colors.blueAccent;
      case NotificationType.error:
        return context.statusDangerColor;
      default:
        return context.brandPrimaryColor;
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.quiz:
        return Icons.quiz_rounded;
      case NotificationType.announcement:
        return Icons.campaign_rounded;
      case NotificationType.system:
        return Icons.settings_suggest_rounded;
      case NotificationType.success:
        return Icons.check_circle_rounded;
      case NotificationType.error:
        return Icons.error_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }
}
