import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'bloc/notifications_page_bloc.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<NotificationsPageBloc>().add(
        const NotificationsPageLoadMoreEvent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;

    return BlocBuilder<NotificationsPageBloc, NotificationsPageState>(
      builder: (context, state) {
        final notifications = state.notifications;
        final isLoading = state.loadingState == LoadingState.loading;
        final isInitialLoading = isLoading && notifications.isEmpty;

        return Scaffold(
          backgroundColor: palette.backgroundSecondary,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    palette.brandPrimary,
                    palette.brandPrimary.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: palette.brandPrimary.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  t['notificationsTitle']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                actions: [
                  if (notifications.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        context.read<NotificationsPageBloc>().add(
                          const NotificationsPageMarkAllAsReadEvent(),
                        );
                      },
                      icon: const Icon(Icons.done_all_rounded, size: 22),
                      tooltip: t['markAllRead'],
                    ),
                ],
              ),
            ),
          ),
          body: isInitialLoading
              ? const Center(child: CircularProgressIndicator())
              : notifications.isEmpty
              ? _EmptyNotifications(t: t, palette: palette)
              : RefreshIndicator(
                  color: palette.brandPrimary,
                  onRefresh: () async {
                    context.read<NotificationsPageBloc>().add(
                      const NotificationsPageLoadEvent(),
                    );
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    itemCount: notifications.length + (state.hasMore ? 1 : 0),
                    itemBuilder: (context, i) {
                      if (i == notifications.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }

                      final notification = notifications[i];
                      return FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        delay: Duration(milliseconds: 50 * i),
                        child: _NotificationItem(
                          notification: notification,
                          palette: palette,
                          onTap: () {
                            if (!notification.isRead) {
                              context.read<NotificationsPageBloc>().add(
                                NotificationsPageMarkAsReadEvent(
                                  notification.id,
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({
    required this.notification,
    required this.onTap,
    required this.palette,
  });
  final NotificationEntity notification;
  final VoidCallback onTap;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;
    final color = _getNotificationColor(notification.type, palette);
    final icon = _getNotificationIcon(notification.type);
    final formattedDate = DateFormat(
      'dd MMM yyyy, hh:mm a',
    ).format(notification.createdAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isUnread
              ? palette.brandPrimary.withValues(alpha: 0.15)
              : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isUnread
                ? palette.brandPrimary.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Container
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
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
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isUnread
                                    ? FontWeight.w900
                                    : FontWeight.w700,
                                color: isUnread
                                    ? palette.brandPrimary
                                    : palette.textPrimary,
                              ),
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: palette.brandSecondary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: palette.brandSecondary.withValues(
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
                        style: TextStyle(
                          fontSize: 13,
                          color: palette.textSecondary,
                          height: 1.5,
                          fontWeight: isUnread
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                      const Gap(12),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 12,
                            color: palette.textTertiary,
                          ),
                          const Gap(4),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 11,
                              color: palette.textTertiary,
                              fontWeight: FontWeight.w700,
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
    NotificationType type,
    MentorXThemeColorPalette palette,
  ) {
    switch (type) {
      case NotificationType.quiz:
        return palette.brandSecondary;
      case NotificationType.announcement:
        return palette.brandPrimary;
      case NotificationType.success:
        return palette.statusSuccess;
      case NotificationType.system:
        return Colors.blue;
      case NotificationType.error:
        return palette.statusDanger;
      default:
        return palette.brandPrimary;
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

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications({required this.t, required this.palette});
  final Map<String, String> t;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeInUp(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Icon(
                Icons.notifications_off_rounded,
                size: 80,
                color: palette.textTertiary.withValues(alpha: 0.2),
              ),
            ),
            const Gap(32),
            Text(
              t['noNotifications'] ?? 'No notifications yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: palette.textPrimary,
              ),
            ),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                t['noNotificationsDesc'] ??
                    "We'll notify you when something important happens.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: palette.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
